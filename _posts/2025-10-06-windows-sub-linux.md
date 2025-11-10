---
title: Windows Sub-Linux with Deep Learning Kits on NVIDIA Blackwell GPUs
description: I bought myself an NVIDIA RTX 5070 Ti and installed in on my ITX personal computer. I need to use Win 11 as its OS as this computer also handles many daily tasks and I will have a Linux Server available to myself soon. This blog is my personal note on installing many deep learning kits under Windows Subsystem for Linux (WSL) with a Blackwell architecture GPU.
date: 2025-10-06
author: Zhenduo
categories: [Deep Learning, Programming Toolkits]
tags: [Deep Learning, CUDA, PyTorch]
published: true
---

For setting up WSL, [this official user manual](https://learn.microsoft.com/en-us/windows/wsl/setup/environment#set-up-your-linux-username-and-password) is a great reference.

```terminal
wsl --install

(Then set up usename and password)

(base) PS C:\Users\Administrator> wsl
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

stratocumulus@WIN-RF8MKB6MO8N:/mnt/c/Users/Administrator$ exit
logout

```