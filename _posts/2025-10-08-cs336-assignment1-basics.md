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

- Repository contains assignment templates: [https://github.com/stanford-cs336/assignment1-basics#](https://github.com/stanford-cs336/assignment1-basics#)

- <a href="{{zhenduowen.github.io}}/assets/files/notes/cs336_spring2025_assignment1_basics.pdf">Problem descriptions of assignment 1 can also be found here.</a> To use the fork templates, fork their github repo, clone, and add remote at local.

- For setting up a local environment, [another post]({{zhenduowen.github.io}}/posts/windows-sub-linux/) may be useful.

- This project dependencies are managed by UV. To use UV to set up dependencies locally:
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
For further reading about features of `uv`, we recommend [https://docs.astral.sh/uv/getting-started/features/#projects](https://docs.astral.sh/uv/getting-started/features/#projects)

## Overview of the assignment:

- `/cs336_basics/` is where we write all the implementations.
- `/tests/` includes all the unit tests, the `adapters.py` connects these unit tests with our implementations in `/cs336_basics/`. `pyproject.toml` is the UV project file contains all the dependencies needed for this project. To run the test, first use UV to set up dependencies, then prompt `uv run pytest`. If not implemented corresponding unit, a `NotImplementedError` will be raised.
- Create a `/data/` folder. `TinyStoriesV2-GPT4.txt` (train and validation) can be found [here](https://huggingface.co/datasets/roneneldan/TinyStories/tree/main), and `owt.txt` (train and validation) can be found [here](https://huggingface.co/datasets/stanford-cs336/owt-sample/tree/main). Download the datasets to `/data/`. Remember to update `.gitignore` for Git to ignore the datasets.

## Byte-pair encoding tokenizer

Tokenizers convert between strings and sequences of integers (tokens).

