---
title: Stanford CS336 Assignment 1 - Basics
description: Student version of Assignment 1 for Stanford CS336 - Language Modeling From Scratch
date: 2025-11-14
author: Zhenduo
categories: [Deep Learning, Language Models from Scratch]
tags: [Deep Learning, CUDA, PyTorch, Language Models]
published: true
---
## Preliminaries

- The repository contains the assignment templates: [https://github.com/stanford-cs336/assignment1-basics#](https://github.com/stanford-cs336/assignment1-basics#)

- <a href="{{ site.baseurl }}/assets/files/notes/cs336_spring2025_assignment1_basics.pdf">The problem descriptions for Assignment 1 can also be found here.</a> Fork their GitHub repository and clone it.

- For setting up a local environment, [another post]({{ site.baseurl }}/posts/windows-sub-linux/) may be useful.

- This project's dependencies are managed by `uv`. To use `uv` to set up dependencies locally:
    ```terminal
    # Navigate to the cloned repository
    cd your-repo-name

    # Install dependencies from pyproject.toml
    uv sync

    # Activate the virtual environment created by uv
    source .venv/bin/activate  # On Unix/macOS
    # OR
    .venv\Scripts\activate     # On Windows
    ```
`uv sync` creates a local environment for this particular project and then installs dependencies according to `pyproject.toml`.

An additional file, `uv.lock`, records the exact dependency versions that should be installed. This file usually imposes stricter version requirements than `pyproject.toml`.

For further reading about the features of `uv`, see [https://docs.astral.sh/uv/getting-started/features/#projects](https://docs.astral.sh/uv/getting-started/features/#projects).

## Overview of the Assignment

- `/cs336_basics/` is where we write all the implementations.
- `/tests/` includes all the unit tests, and `adapters.py` connects these unit tests with our implementations in `/cs336_basics/`. `pyproject.toml` is the `uv` project file that contains all the dependencies needed for this project. To run the tests, first use `uv` to set up the dependencies, and then run `uv run pytest`. If a corresponding unit has not been implemented, a `NotImplementedError` will be raised.
- Create a `/data/` folder. `TinyStoriesV2-GPT4.txt` (training and validation) can be found [here](https://huggingface.co/datasets/roneneldan/TinyStories/tree/main), and `owt.txt` (training and validation) can be found [here](https://huggingface.co/datasets/stanford-cs336/owt-sample/tree/main). Download the datasets to `/data/`. Add this folder to `.gitignore` so that Git ignores the datasets.

I am following the spring 2025 version of assignment 1. Assignment 1 does not change much from 2025 to 2026.

## Byte-Pair Encoding Tokenizer

### Unicode Standard and UTF-8 Encoding

#### Intro and Example
Unicode Standard gives every character a unique number called a **code point**.

```plain
A        → U+0041
中       → U+4E2D
😊       → U+1F60A
```
It is not practical to train tokenizers on Unicode code points, the vocabulary would be too large (roughly 150K items in it) and sparse (a lot of rare characters). This is why `UTF-8` encoding was introduced.

`UTF-8` is an encoding method on Unicode code points as bytes. The `8` stands for 1 byte which is 8 bits. The Unicode standard itself defines three encodings: `UTF-8`, `UTF-16`, and `UTF-32`. `UTF-8` is the most prevailing encoding for the Internet, used roughly in over 98% of web pages.

```python
In [9]: test_string = "I 我"

In [10]: utf8_encoded = test_string.encode('utf-8')

In [11]: utf8_encoded
Out[11]: b'I \xe6\x88\x91'
```

In `b'I \xe6\x88\x91'`, the prefix `b` means it is a sequence of raw bytes in Python. After UTF-8 encoding:
```plain
I      → 0x49
space  → 0x20
我     → 0xe6 0x88 0x91
```
Since each byte value is an integer range 0 to 255, but number of codepoints are 154997. 

#### prefix-free and self-synchronizing
A code point could use multiple bytes after encoding, like `我 : 0xe6 0x88 0x91`. Luckily, UTF-8 is **prefix-free** and **self-synchronizing**. Self-synchronizing means that even if one start reading a UTF-8 byte sequence from the middle, one can still recover the correct character boundaries. And prefix-free means that no encoding is the prefix of some other encodings. The following example explains these in details:
```plain
0xxxxxxx   = 1-byte character (for ASCII)
110xxxxx   = start of a 2-byte character
1110xxxx   = start of a 3-byte character
11110xxx   = start of a 4-byte character
10xxxxxx   = continuation byte
```
Observe that starting bytes never start with `10` and continuation bytes always start with `10`. So if the stream is corrupted and we start in the middle, any byte start with `10` is a continuation byte and we can move on, till we find a starting byte.

Note that Python displays printable ASCII directly:
```plain
0x49 → I
0x20 → space
```
The byte `\xe6` means it is a hexdecimal value is `e6`. So the actual UTF-8 encoding is `49 20 e6 88 91`.

The UTF-8 encoding helps us to focus on byte values which only range within 0 to 255. 

Now a quick summary. The advantages of UTF-8 over UTF 16 and UTF 32 are:
- Compact:
  ```plain
    Character    UTF-8 bytes              UTF-16 bytes        UTF-32 bytes

    I            49                       49 00               49 00 00 00
    space        20                       20 00               20 00 00 00
    我           e6 88 91                 11 62               11 62 00 00
  ```
- ACSII-compatible:
  ```plain
  A → 0x41
  B → 0x42
  space → 0x20
  ```
  English text remains readable at the byte level.
- UTF-8 gives a universal vocabulary of size 256.
Also, note that most training data is already stored in UTF-8.

### Subword Tokenization

#### Intro

The word ``token" means *something that represents or indicates something else*. Earlier when I was learning English, I encountered this word in a brief text explaining how languages are evolved. In the early days of civilizations, people use tokens to represents and record goods.

Although byte-level tokenization can alleviate the issue of out-of-vocabulary, tokenizing texts by character results in extremely long input sequences. For example, a sentence with 10 words may only be 10 tokens in a word-level language model, but could be 50 or more tokens in a character-level model. 

Subword tokenization is designed to balance such a mismatch. For character level tokenization, byte vocabulary has size 256. A subword tokenizer trades off a larger vocabulary size for better compressing the length of the input bytes sequence. For example, it would be good to add a particular token in the vocabulary for the word "the".

To achieve such scheme, [Sennrich et al [2016]](https://aclanthology.org/P16-1162/) propose to use byte-pair encoding (BPE; Gage, 1994). This algorithm iteratively merges the most frequent pair of bytes with a new unused index. Tokenizers constructed in such a scheme are called **BPE tokenizers**. The process of building the BPE tokenizer vocabulary is call "training" the BPE tokenizer.

#### Training BPE Tokenizers

The training procedure consists of three steps:
- **Initialization** The tokenizer vocabulary is a bijective mapping from bytestring token to integer ID. For byte level BPE tokenizer, the initial vocabulary is simply the set of all 256 bytes.
- **Pre-tokenization** Going through the entire text corpus each time we want to merge some bytes can be computationally expensive. Also, directly merging tokens across the corpus may result in tokens that differ only in punctuation, as BPE merges frequent adjacent byte pairs purely by frequency, not by semantic meaning. For example, suppose the corpus contains many examples like:
```plain
dog.
dog!
dog?
```
If we directly run BPE over the whole byte stream, the algorithm may see these frequent adjacent pairs:
```plain
d o
do g
dog .
dog !
dog ?
```
These are different byte strings, so they receive different token IDs:
```plain
"dog." → token ID 1057
"dog!" → token ID 3092
"dog?" → token ID 8271
```
To avoid this, we *pre-tokenize* the corpus by manually splitting the text into meaningful pieces. A naive approach can be splitting by spaces, like `I love dogs!` to `["I", " love", " dogs", "!"]`. Suppose the word `dogs` appear 10 times, we can directly add character pair frequences with `(d,o) += 10, (o,g) += 10, (g,s) += 10`, which makes character pairs counting more efficient.

In GPT-2 (and in this assignment), regex-based pre-tokenizer is applied [Radford et al., 2019](https://cdn.openai.com/better-language-models/language_models_are_unsupervised_multitask_learners.pdf) from `github.com/openai/tiktoken/pull/234/files:`1
```python
# split by contractions | words | numbers | punctuation | trailing spaces | other spaces
PAT = r"""'(?:[sdmt]|ll|ve|re)| ?\p{L}+| ?\p{N}+| ?[^\s\p{L}\p{N}]+|\s+(?!\S)|\s+"""
```
