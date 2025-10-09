---
title: Win 11 Deep Learning Kits on NVIDIA Blackwell GPUs
description: I bought myself an NVIDIA RTX 5070 Ti and installed in on my ITX personal computer. I need to use Win 11 as its OS as this computer also handles many daily tasks and I will have a Linux Server available to myself soon. This blog is my personal note on installing many deep learning kits on this PC with a Blackwell architecture GPU.
date: 2025-10-07
author: Zhenduo
categories: [Deep Learning, Programming Toolkits]
tags: [Deep Learning, CUDA, PyTorch]
published: true
---
*Platform: win 11*

```terminal
wsl --install
```

Just for some command lines like `wget` to be available.

## Anaconda & Python
Go to [Anaconda](https://www.anaconda.com/download/success) and download Miniconda (Only Conda and Python). 

Add `conda` to `PATH` or simply use conda prompt.
```powershell
setx PATH "%PATH%;C:\Anaconda3;C:\Anaconda3\Scripts\"

PS C:\Users\Administrator> conda -V
conda 25.7.0
```

A quick [Get started with Anaconda](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html) will pop up if you agreed so during the installation.

So far we only have the base environment:
```terminal
> conda info --envs

# conda environments:
#
base                   C:\Anaconda
```

Note that win11 powershell prohibits running any scripts, while conda needs to do so. Hence, we need to set:
```terminal
> Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```
Then restart powershell.

Create a new environment with only Python and Numpy then activate it.
```terminal
 > conda create -n dlenv python numpy
 > conda init
 ...
 No action taken.
 > conda activate dlenv
 ```
 Use `conda list` to check currently installed packages. My Python version is `3.13.7`.

 - PyTorch on Windows only supports Python 3.9-3.13. Note that `dlenv` uses Python `3.13.7`.

## UV (Under Anaconda)
I am using the following solution:
- Use Conda for system dependencies (CUDA Toolkit, Pytorch... are installed under virtual environment `dlenv` under Conda)
- Use [UV](https://github.com/astral-sh/uv) for Python package installations (Within Conda virtual environment)

The reason to use uv is simple: fast (Rust based) and commonly used for open source repositories on Github.

 This [brief UV usage guide](https://docs.astral.sh/uv/guides/projects/) tells me the basics of using UV to do project dependencies management.

UV is a standalone package manager. Thus, can be simply installed by `pip`.

After activating `dlenv`, install uv by
```terminal
> pip install uv
Installing collected packages: uv
Successfully installed uv-0.9.0
```

After the project is done, we can freeze and export dependencies by

```terminal
uv pip freeze > requirements.txt
conda env export > environment.yml
```

And can such dependencies can be imported by:
```terminal
conda env create -f environment.yml
uv add -r requirements.txt
```

Some [common issue of using uv under conda](https://medium.com/@datagumshoe/using-uv-and-conda-together-effectively-a-fast-flexible-workflow-d046aff622f0) could be:
- Package Not Found in UV But Available in Conda
    If UV can’t find a package that Conda has:
    ```terminal 
    # Try installing with Conda instead
    conda install package-name
    ```
- Dependency Conflicts Between UV and Conda Packages
    If you see “Dependency conflict” errors:
    ```ternimal
    # Check which versions are installed
    pip list | grep package-name
    conda list | grep package-name
    # Reinstall the conflicting package with the same version in both
    uv pip install package-name==specific-version
    ```
- UV Installation Breaks After Conda Environment Update
    If UV stops working after a Conda update:
    ```terminal
    # Reinstall UV
    pip uninstall uv -y
    pip install uv
    ```

## Nvidia Drivers and GPU Configurations
Check the currently installed Nvidia Drivers and CUDA (Compute Unified Device Architecture) Dynamic Link Library (.dll). The latter usually comes with the basic Nvidia Driver. The CUDA (CUDA Toolkit) we later on installed relies on the correct version of this Dynamic Link Library.

Go to `NVIDIA Control Panel > Help > System Info > Components`, I find driver version `576.88`; `NVCUDA64.DLL`, version `32.0.15.7688`, name `NVIDIA CUDA 12.9.90 driver`.

I am taking extra care here as I remember when Nvidia's 50 series GPU were released, it had some compatibility issue with PyTorch. So I want to be crystal clear on the version of driver and CUDA I will be using.

We can find the compatible CUDA Toolkit with our local nvidia driver
- [https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html)

We can see `525 <= 576.88 < 580` should download CUDA Toolkit version `12.X`.


## CUDA & PyTorch (under Anaconda)

The PyTorch binaries ship with their own CUDA dependencies, which are selected/specified in the installation command. Locally installed CUDA toolkit won’t be used unless you build PyTorch from source or a custom CUDA extension.

Check PyTorch official installation guide:
[https://pytorch.org/get-started/locally/](https://pytorch.org/get-started/locally/)

I choose Stable (2.8.0), Windows, Pip, Python, CUDA 12.9, the installation prompt pops up.

To install Pytorch with its own CUDA Toolkit, under Conda `dlenv`, type
```terminal
(dlenv) PS C:\Users\Administrator> pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu129
```

Check it by:
```terminal
(dlenv) PS C:\Users\Administrator> python
>>> import torch
... torch.cuda.is_available()
...
True
>>> print(torch.__version__)
2.8.0+cu129
>>> print(torch.cuda.device_count())
1
>>> import torchvision
>>> torchvision.__version__
'0.23.0+cu129'

>>> torch.cuda.get_device_name(0)
'NVIDIA GeForce RTX 5070 Ti'
>>> torch.cuda.get_device_capability(0)
(12, 0)
>>> torch.cuda.get_device_properties(0).total_memory / 1024**3
15.92047119140625

>>> props = torch.cuda.get_device_properties(0)
... print(f"Multi-processors: {props.multi_processor_count}")
... print(f"CUDA Cores: {getattr(props, 'multi_processor_count', 'N/A') * 64}")
...
Multi-processors: 70
CUDA Cores: 4480
```











