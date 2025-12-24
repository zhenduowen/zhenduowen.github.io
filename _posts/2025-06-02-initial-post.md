---
title: 关于这个博客网站
date: 2025-06-02
author: Zhenduo
categories: [General, ]
tags: [General]
---

## 关于网站搭建

Jekyll官方教程[Step by Step Tutorial](https://jekyllrb.com/docs/step-by-step/01-setup/)可以搭建一个[Demo网站](https://zzy979.github.io/jekyll-tutorial/)，学会使用一些简单的jekyll命令。


关于搭建个人博客网站。可以参考：[Chirpy - Getting Started](https://chirpy.cotes.page/posts/getting-started/)

- 打开[chirpy-starter](https://github.com/cotes2020/chirpy-starter)仓库，点击按钮 “Use this template” → “Create a new repository”。

- 将新仓库命名为`<username>.github.io`，其中`<username>`是你的GitHub用户名，如果包含大写字母需要转换为小写。


## 关于Jekyll本地安装
本地安装成功后，我们可以在本地调试博客，确保渲染无误后再将更新推送至仓库。

这里是win平台的安装过程：

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
    其中`--livereload`可以提供即时更新的本地版本

关于在Mac Apple Silicon上安装：

參考 [Jekyll on MacOS](https://jekyllrb.com/docs/installation/macos/)

The installation steps are done in HK so no bothers using mirror sources in the mainland.

1. make sure homebrew has been installed on your mac
    ```terminal
    brew -v

    Homebrew 4.5.12
    ```

2. install chruby and the latest ruby
    ```terminal
    brew install chruby ruby-install

    ruby-install ruby 3.4.1
    ```
    Then configure your shell to automatically use `chruby`:
    ```terminal
    echo "source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.zshrc
    echo "source $(brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.zshrc
    echo "chruby ruby-3.4.1" >> ~/.zshrc # run 'chruby' to see actual version
    ```
    Check if ruby is successfully installed by checking its version:
    ```terminal
    ruby -v
    ruby 3.4.1 (2024-12-25 revision 48d4efcb85) +PRISM [arm64-darwin24]
    ```

3. install jekyll
    ```terminal
    gem install jekyll
    ```

4. under the blog github local repo path, initialize bundle
    ```terminal
    bundle
    ```

Now the local website is ready to go:
```terminal
    bundle exec jekyll serve --livereload
```



## 关于网站部署
利用Github Pages 进行托管和部署。GitHub Pages是一个通过GitHub托管和发布网页的服务，官方文档：[https://docs.github.com/en/pages](https://docs.github.com/en/pages)

你可以创建一个用户级网站，仓库名为`<username>.github.io`，发布地址为 `https://<username>.github.io`。GitHub Pages支持自定义域名，参考文档 [About custom domains and GitHub Pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages)。

使用Github Pages的方法非常简单，在GitHub上打开之前创建的仓库设置，点击左侧导航栏 “Pages”，在 “Build and deployment” - “Source” 下拉列表选择 “GitHub Actions”。提交本地修改并推送至远程仓库将会触发Actions工作流。在仓库的Actions标签页将会看到 “Build and Deploy” 工作流正在运行。

Github pages的一些缺点是：
- 不支持动态内容，博客必须都是静态网页。
- 博客不能被百度索引。
- 仓库空间不大于1G。
- 每个月的流量不超过100G。
- 每小时更新不超过 10 次。


## 关于发布文章

### yaml 标签
vscode如今对于markdown的原生支持出奇的好用, 参考官方文档：[https://code.visualstudio.com/docs/languages/markdown](https://code.visualstudio.com/docs/languages/markdown)。

- `ctrl+shift+v`即可打开实时渲染

在md文件前的yaml段落中配置标题，时间，作者，以及分类标签。

### MathJax与KaTex
在博客模板中启用MathJax可以参考[https://github.com/cotes2020/jekyll-theme-chirpy/issues/1140](https://github.com/cotes2020/jekyll-theme-chirpy/issues/1140)。我使用了katex引擎。

### 数学排版
多数文章遵从如下格式：
定义，引理，定理，推论的标题为加粗格式, 括号包含解释性的文本。段落结尾右侧用unicode char ■表示段落结束。 证明和实例的标题采用斜体，证明通常和定理在同一个段落内，在证明结束后使用■表示段落结束。而示例因其解释性，不需明示■表示段落结束从而和其他文本区分开。

**Lemma 1. (Some Lemma)**

Some Lemma says...


*Proof. 1*

Some proof here...

&nbsp;<span style="float: right;">■</span>

*Example. 1*

Some Example Here


段落结尾的样板
```html
&nbsp;<span style="float: right;">■</span>
```

### Markdown与LaTex可用颜色

利用html tag来给Markdown文字上色，[GitHub Pages对此支持良好](https://github.com/orgs/community/discussions/31570)，

```html
<code style="color : name_color">text</code>
```

常用颜色如下：
- `<code style="color : red">text</code> `: <code style="color : red" >text without inline math</code>
- `<code style="color : darkorange">text</code> `: <code style="color : darkorange" >text without inline math</code>
- ~~`<code style="color : yellow">text</code> `: <code style="color : yellow" >text without inline math</code>~~
- `<code style="color : gold">text</code> `: <code style="color : gold" >text without inline math</code>
- `<code style="color : green">text</code> `: <code style="color : green" >text without inline math</code>
- `<code style="color : skyblue">text</code> `: <code style="color : skyblue" >text without inline math</code>
- `<code style="color : cyan">text</code> `: <code style="color : cyan" >text without inline math</code>
- `<code style="color : blue">text</code> `: <code style="color : blue" >text without inline math</code>
- `<code style="color : magenta">text</code> `: <code style="color : magenta" >text without inline math</code>
- `<code style="color : violet">text</code> `: <code style="color : violet" >text without inline math</code>

特定数学公式内，KaTex可以渲染`\textcolor{}{}`和`\color{}`命令, `xcolor`包内支持的颜色[可见于此](https://www.overleaf.com/learn/latex/Using_colors_in_LaTeX)
- `\textcolor{red}{x_1}`: $\textcolor{red}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{darkorange}{x_1}`: $\textcolor{darkorange}{x_1 + x_2 + x_3 + \ldots + x_n}$
- ~~`\textcolor{yellow}{x_1}`: $\textcolor{yellow}{x_1 + x_2 + x_3 + \ldots + x_n}$~~
- `\textcolor{gold}{x_1}`: $\textcolor{gold}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{green}{x_1}`: $\textcolor{green}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{skyblue}{x_1}`: $\textcolor{skyblue}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{cyan}{x_1}`: $\textcolor{cyan}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{blue}{x_1}`: $\textcolor{blue}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{magenta}{x_1}`: $\textcolor{magenta}{x_1 + x_2 + x_3 + \ldots + x_n}$
- `\textcolor{violet}{x_1}`: $\textcolor{violet}{x_1 + x_2 + x_3 + \ldots + x_n}$

其中亮黄色文字在浅色背景下不易阅读。

### 超链接

- 站外超链接格式即markdown原生格式。
- 站内超链接格式可以参考这个例子：
```markdown
<a href="{{zhenduowen.github.io}}/assets/files/notes/cs336_spring2025_assignment1_basics.pdf">Problem descriptions of assignment 1 can also be found here.</a> 
```



## 关于评论系统

Giscus非常好用
- 在對應的repo下面安裝giscus [https://github.com/apps/giscus](https://github.com/apps/giscus)
- 在倉庫設置頁面features中勾選Discussions
- 之後再倉庫設置中的Discussions標籤頁，打開Categories旁邊的編輯按鈕，編輯用於博客評論的類別名稱。
- 在[https://giscus.app/](https://giscus.app/)中如下配置：
Repository: `<username>/<username>.github.io`
Page - Discussions Mapping：保持默认值 “Discussion title contains page pathname” 即可（URL为`https://<username>.github.io/posts/<title>`的文章将映射到标题为`/posts/<title>`的Discussion，即使用URL的pathname部分作为Discussion标题）
Discussion Category：选择上一步创建的类别名称（例如 “Comments”）
之后找到 “Enable giscus” 一节，将自动生成的配置填写到_config.yml中`comments.giscus`的对应选项。
```yml
comments:
  provider: giscus
  giscus:
    repo: zhenduowen/zhenduowen.github.io # <gh-username>/<repo>
    repo_id: R********
    category: Comments
    category_id: DIC********
    mapping: pathname # optional, default to 'pathname'
    strict: # optional, default to '0'
    input_position: # optional, default to 'bottom'
    lang: # optional, default to the value of `site.lang`
    reactions_enabled: # optional, default to the value of `1`
```

## 关于Git
如果位于国内，可以配置proxy以便更好的`git push`
```terminal
git config --global http.proxy 127.0.0.1:26293
git config --global https.proxy 127.0.0.1:26293
```
端口号自然是可变的。

## 自定义代码框
- [https://github.com/cotes2020/jekyll-theme-chirpy/discussions/1319](https://github.com/cotes2020/jekyll-theme-chirpy/discussions/1319)

创建`assets/css/jekyll-theme-chirpy.scss` 使用默认模版如下
```css
---
---

/* prettier-ignore */
@use 'main
{%- if jekyll.environment == 'production' -%}
  .bundle
{%- endif -%}
';

/* append your custom style below */

```
在之后添加
```css
div.scroll > .highlight {
    overflow-y: auto;
    height: 400px;
}
```

此后在较长代码块尾部添加`{: .scroll } `即可

## 设置博客对于搜索引擎可见

可以参考
- [https://stackoverflow.com/questions/get-github-pages-site-found-in-google-search-results](https://stackoverflow.com/questions/49073043/get-github-pages-site-found-in-google-search-results)
- [https://developers.google.com/search/docs/fundamentals/seo-starter-guide](https://developers.google.com/search/docs/fundamentals/seo-starter-guide?hl=en&ref_topic=4564315&visit_id=638985346021853045-3173096693&rd=2)

Google Search Console:
- [https://search.google.com/search-console/welcome?utm_source=wmx&utm_medium=deprecation-pane&utm_content=home](https://search.google.com/search-console/welcome?utm_source=wmx&utm_medium=deprecation-pane&utm_content=home)

将网站url prefix `https://zhenduowen.github.io/` 提交给Google

将验证用`.html`文件放置于博客根目录下。

一些增加被搜索引擎index的操作：
- 上传sitemap
- 使用meta标签增加SEO信息


## 一些已知的问题
- 如果想要打出花括号$\\{ \\}$, 需要利用`\`来escape两次，分别对应jekyll与mathjax。但是如此重复两次的语法是不适配latex的。一个解决方法是使用`\lbrace`与`\rbrace`。参见[https://stackoverflow.com/questions/41312777/mathjax-curly-brackets-dont-show-up-using-jekyll](https://stackoverflow.com/questions/41312777/mathjax-curly-brackets-dont-show-up-using-jekyll)
- `|` `*`在inline math中需要用`\`escape一次。前者可以用`\mid`替代，而`\\|`对应模长$\\|$ 而段落模式中的block math则无需如此。
