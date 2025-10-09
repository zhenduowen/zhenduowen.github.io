---
title: Stanford CS336 Assignment 1 - Basics
description: Student version of Assignment 1 for Stanford CS336 - Language Modeling From Scratch
date: 2025-10-08
author: Zhenduo
categories: [Deep Learning, Language Models from Scratch]
tags: [Deep Learning, CUDA, PyTorch, Language Models]
published: true
---
## Preliminaries

- Repository contains assignment templates: [https://github.com/stanford-cs336/assignment1-basics#](https://github.com/stanford-cs336/assignment1-basics#)

- <a href="{{zhenduowen.github.io}}/assets/files/notes/cs336_spring2025_assignment1_basics.pdf">Problem descriptions of assignment 1 can also be found here.</a>

- For setting up a local environment, [another post]({{https://zhenduowen.github.io}}/posts/dl-kits-on-nvidia-blackwell-gpu/) may be useful.

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

Additional Issues:

Note that `import resource` in the original template `test_tokenizer.py` is not available on win11. So I use AI to rewrite the `memory_limit()` function in `test_tokenizer.py` as the following:

```python
# refector memory_limit for usage on win11
import threading
import time
from typing import Callable, Optional


def memory_limit(max_mem: int):
    """
    Decorator to monitor and optionally enforce memory limits on Windows.
    Note: Windows doesn't support hard memory limits like Unix RLIMIT_AS,
    so this monitors memory usage and can raise an exception if exceeded.
    """
    def decorator(f: Callable):
        def wrapper(*args, **kwargs):
            process = psutil.Process(os.getpid())
            initial_memory = process.memory_info().rss
            max_allowed = initial_memory + max_mem
            
            # Flag to track if memory limit was exceeded
            memory_exceeded = False
            exception_msg = ""
            
            def memory_monitor():
                """Background thread to monitor memory usage"""
                nonlocal memory_exceeded, exception_msg
                while not memory_exceeded:
                    try:
                        current_memory = process.memory_info().rss
                        if current_memory > max_allowed:
                            memory_exceeded = True
                            exception_msg = f"Memory limit exceeded: {current_memory} > {max_allowed}"
                            # Try to interrupt the main thread
                            # Note: This won't actually stop the function execution
                            break
                        time.sleep(0.1)  # Check every 100ms
                    except (psutil.NoSuchProcess, psutil.AccessDenied):
                        break
            
            # Start memory monitoring in a daemon thread
            monitor_thread = threading.Thread(target=memory_monitor, daemon=True)
            monitor_thread.start()
            
            try:
                result = f(*args, **kwargs)
                
                # Check if memory was exceeded during execution
                if memory_exceeded:
                    raise MemoryError(exception_msg)
                    
                return result
                
            except MemoryError:
                # Re-raise MemoryErrors that might occur naturally
                if memory_exceeded:
                    raise MemoryError(exception_msg)
                else:
                    raise
                    
            finally:
                # Cleanup - the daemon thread will exit automatically
                pass

        return wrapper
    return decorator
```
{: .scroll } 

## Overview of the assignment:

- `/cs336_basics/` is where we write all the implementations.
- `/tests/` includes all the unit tests, the `adapters.py` connects these unit tests with our implementations in `/cs336_basics/`. `pyproject.toml` is the UV project file contains all the dependencies needed for this project. To run the test, first use UV to set up dependencies, then prompt `uv run pytest`. If not implemented corresponding unit, a `NotImplementedError` will be raised.
- Create a `/data/` folder. `TinyStoriesV2-GPT4.txt` (train and validation) can be found [here](https://huggingface.co/datasets/roneneldan/TinyStories/tree/main), and `owt.txt` (train and validation) can be found [here](https://huggingface.co/datasets/stanford-cs336/owt-sample/tree/main). Download the datasets to `/data/`. Remember to update `.gitignore` for Git to ignore the datasets.

## Byte-pair encoding tokenizer

Tokenizers convert between strings and sequences of integers (tokens).

