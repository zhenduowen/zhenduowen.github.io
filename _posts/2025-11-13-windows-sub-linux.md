---
title: Windows Sub-Linux with Deep Learning Kits on NVIDIA Blackwell GPUs
description: I bought myself an NVIDIA RTX 5070 Ti and installed it on my ITX personal computer. I need to use Win 11 as its OS as this computer also handles many daily tasks and I will have a Linux Server available to myself soon. This blog is my personal note on installing many deep learning kits under Windows Subsystem for Linux (WSL) with a Blackwell architecture GPU.
date: 2025-11-13
author: Zhenduo
categories: [Deep Learning, Programming Toolkits]
tags: [Deep Learning, CUDA, PyTorch]
published: true
---

> [WSL official user manual](https://learn.microsoft.com/en-us/windows/wsl/setup/environment#set-up-your-linux-username-and-password)

Install and setup WSL (default Distro Ubuntu) is pretty easy:

```shell
wsl --install

(Then set up username and password)

(base) PS C:\Users\Administrator> wsl
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

stratocumulus@WIN-RF8MKB6MO8N:/mnt/c/Users/Administrator$ exit
logout
```

To update your package list:
```shell
sudo apt update
```

## A brief intro to top-level UNIX directories
> https://theshepord.github.io/intro-to-WSL/

 Only mess with `/mnt`, `/home`, and maybe maybe `/usr`. Don’t touch anything else.

- `bin`: binaries, contains Ubuntu binary (aka executable) files that are used in bash. Here you’ll find the binaries that execute commands like ls and pwd. Similar to /usr/bin, but bin gets loaded earlier in the booting process so it contains the most important commands.

- `boot`: contains information for operating system booting. Empty in WSL, because WSL isn’t an operating system.

- `dev`: devices, provides files that allow Ubuntu to communicate with I/O devices. One useful file here is /dev/null, which is basically an information black hole that automatically deletes any data you pass it.

- `etc`: no idea why it’s called `etc`, but it contains system-wide configuration files.

- `home`: equivalent to Window’s `C:/Users` folder, contains home folders for the different users. `cd ~` goes to `/home/<username>`.

- `lib`: libraries used by the system, `lib64` are 64-bit libraries used by the system.

- `mnt`: mount, where your drives are located. The WSL has access to your PC’s file system through `/mnt/<drive letter>/` directories (or mount points). For example, your `C:\` and `D:\` root directories on Windows would be available through `/mnt/c/` and `/mnt/d/` respectively in the WSL.

- `opt`: third-party applications that (usually) don’t have any dependencies outside the scope of their own package.

- `proc`: process information, contains runtime information about your system (e.g. memory, mounted devices, hardware configurations, etc).

- `run`: directory for programs to store runtime information.

- `srv`: server folder, holds data to be served in protocols like ftp, www, cvs, and others.

- `sys`: system, provides information about different I/O devices to the Linux Kernel. If dev files allows you to access I/O devices, sys files tells you information about these devices.

- `tmp`: temporary, these are system runtime files that are (in most Linux distros) cleared out after every reboot. It’s also sort of deprecated for security reasons, and programs will generally prefer to use run.

- `usr`: contains additional UNIX commands, header files for compiling C programs, among other things. Kind of like bin but for less important programs. Most of everything you install using apt-get ends up here.

- `var`: variable, contains variable data such as logs, databases, e-mail etc, but that persist across different boots.

Also keep in mind that all of this is just convention. No Linux distribution needs to follow this file structure, and in fact almost all will deviate from what I just described. 

## Nvidia Drivers and GPU Configurations on Win 11
Check the currently installed Nvidia Drivers and CUDA (Compute Unified Device Architecture) Dynamic Link Library (.dll). The latter usually comes with the basic Nvidia Driver. The CUDA (CUDA Toolkit) we later on installed relies on the correct version of this Dynamic Link Library.

Go to NVIDIA Control Panel > Help > System Info > Components, my driver version is 576.88; NVCUDA64.DLL, version 32.0.15.7688, name NVIDIA CUDA 12.9.90 driver.


We can find the compatible CUDA Toolkit with our local nvidia driver

https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
We can see 525 <= 576.88 < 580 should download CUDA Toolkit version 12.X.

I want CTK version 13.x, so I update my driver to >= 580 at [https://www.nvidia.com/en-us/drivers/details/257327/](https://www.nvidia.com/en-us/drivers/details/257327/) 

This gives me:

```terminal
PS C:\Users\Administrator> nvidia-smi
Fri Nov 14 17:34:45 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 581.57                 Driver Version: 581.57         CUDA Version: 13.0     |
+-----------------------------------------+------------------------+----------------------+
| GPU  Name                  Driver-Model | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 5070 Ti   WDDM  |   00000000:01:00.0  On |                  N/A |
| 31%   43C    P8             21W /  300W |     601MiB /  16303MiB |     14%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

```



## CUDA support to WSL2

**Users must not install any NVIDIA GPU Linux driver with WSL 2.** Once a Windows NVIDIA GPU driver is installed on the system, CUDA becomes available within WSL 2. Check [NVIDIA's official docs of CUDA Support for WSL 2](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)

> One has to be very careful here as <u>the default CUDA Toolkit comes packaged with a driver, and it is easy to overwrite the WSL 2 NVIDIA driver with the default installation.</u> We recommend developers to use a separate CUDA Toolkit for WSL 2 (Ubuntu) available from the CUDA Toolkit Downloads page to avoid this overwriting.

Choose `Linux > x86_64 > WSL-Ubuntu > 2.0 > deb (network)`

Note that here we use `cuda-toolkit-13-0`, which aligns with CUDA 13.0 in the Windows host.

Follow the instructions provided on the page.
```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb

sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-13-0
```

Add `nvcc` to PATH
```shell
export PATH="/usr/local/cuda-13.0/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-13.0/lib64:$LD_LIBRARY_PATH"
```

Now check the installation:
```shell
stratocumulus@WIN-RF8MKB6MO8N:~$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2025 NVIDIA Corporation
Built on Wed_Aug_20_01:58:59_PM_PDT_2025
Cuda compilation tools, release 13.0, V13.0.88
Build cuda_13.0.r13.0/compiler.36424714_0
```

## Python, Conda, ...

Install Miniconda
```shell
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
source ~/miniconda3/bin/activate
```

Create and activate a virtual environment
```shell
conda create -n dlenv python=3.12 -y
conda activate dlenv
```

Install Pytorch under this environment `dlenv`. Go to Pytorch website and choose with your own configuration. Here, I use `Stable-Linux-Pip-Python-CUDA13.0`
```shell
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu130
```

## Git

Now to setup git. [Create a new ssh key, add the private key to the ssh agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux) and [add the public key to your github account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

```shell
$ ssh -T git@github.com
Hi! You've successfully authenticated, but GitHub does not provide shell access.
```

If cannot push to remote, remove it then add back
```shell
git remote remove origin
git remote add origin git@github.com:username/repository.git
```
When push, set upstream `git push --set-upstream origin main`


## VS Code
> [https://code.visualstudio.com/docs/remote/wsl](https://code.visualstudio.com/docs/remote/wsl)

There is a microsoft developed WSL extension in VS Code.

Press F1, select `WSL: Connect to WSL` for the default distro.
Use the File menu to open your folder.

