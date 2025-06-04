---
title: 关于这个博客网站
date: 2025-06-02
author: Zhenduo
categories: [General, ]
tags: [General]
---

参考前人的教程：[https://zzy979.github.io/posts/creating-personal-blog-site/](https://zzy979.github.io/posts/creating-personal-blog-site/)

## 关于网站搭建

Jekyll官方教程[Step by Step Tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/)可以搭建一个[Demo网站](https://zzy979.github.io/jekyll-tutorial/)，了解Liquid模板（变量、标签、过滤器）、前页(front matter)、布局(layout)等基本概念，并学会使用jekyll命令。


关于搭建个人博客网站。可以参考：[Chirpy - Getting Started](https://chirpy.cotes.page/posts/getting-started/)

- 打开[chirpy-starter](https://github.com/cotes2020/chirpy-starter)仓库，点击按钮 “Use this template” → “Create a new repository”。

- 将新仓库命名为`<username>.github.io`，其中`<username>`是你的GitHub用户名，如果包含大写字母需要转换为小写。




## 关于Jekyll安装
参考[Jekyll官方教程](https://jekyllrb.com/docs/installation/)

1. 安装 ruby with dev kit
    - 要注意选择make 支持最多的x64版本
    - 要注意选择with dev kit的版本，并且安装msys2 and mingw dev toolchain
    - 要注意ruby的安装地址中[不能有空格](https://stackoverflow.com/questions/16898286/error-invalid-switch-in-rubyopt-f-runtimeerror-is-shown-while-install-gems)

    检查ruby版本
    ```terminal
    ruby -v
    gem -v
    ```

2. 安装jekyll
    在新terminal中 （新terminal自动启用gem PATH环境变量）
    ```terminal
    gem install jekyll bundler --http-proxy http://localhost:26293
    ```
    要注意使用国外源的情况下开启本地代理访问并在--switch语句中提供代理网口

    检查jekyll版本
    ```terminal
    jekyll -v
    ```
3. clone git repo，在本地clone前面创建的线上仓库。

4. 配置bundler gem国内镜像源

    如果是国内访问，那么配置如下镜像源
    ```terminal
    bundle config mirror.https://rubygems.org https://gems.ruby-china.com
    ```
    之后在repo根目录中运行
    ```terminal
    bundle
    ```
    配置完成

5. 运行本地博客网站
    ```terminal
    bundle exec jekyll serve --livereload
    ```
    可以提供即时更新的本地版本



## 关于网站部署
利用Github Pages 进行托管和部署。GitHub Pages是一个通过GitHub托管和发布网页的服务，官方文档：[https://docs.github.com/en/pages](https://docs.github.com/en/pages)

你可以创建一个用户级网站，仓库名为`<username>.github.io`，发布地址为 `https://<username>.github.io`。GitHub Pages支持自定义域名，参考文档 [About custom domains and GitHub Pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages)。

之后在GitHub上打开仓库设置，点击左侧导航栏 “Pages”，在 “Build and deployment” - “Source” 下拉列表选择 “GitHub Actions”。提交本地修改并推送至远程仓库，将会触发Actions工作流。在仓库的Actions标签页将会看到 “Build and Deploy” 工作流正在运行。构建成功后，即可通过配置的URL访问自己的博客网站。

## 关于发布文章
vscode如今对于markdown的原生支持出奇的好用, 参考官方文档：[https://code.visualstudio.com/docs/languages/markdown](https://code.visualstudio.com/docs/languages/markdown)

## TODO：
- 使用giscus实现评论系统