---
title: Double Markovity and Common Randomness
date: 2025-06-21
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Markovity, Common Randomness]
---


**Theorem 1.  (Double Markovity)**

> See Exercise  16.25 in 
>
> Imre Csiszar and J´ anos K¨orner, Information theory: Coding theorems for discrete memoryless systems, Cambridge University Press, 1 2011.
>
>Also, Lemma 6 and Remark 19 in
>
> Amin Gohari and Chandra Nair, Outer bounds for multiuser settings: The auxiliary receiver approach, IEEE Transactions on Information Theory 68 (2022), no. 2, 701–736.

Let $U,X,Y$ be three real-valued, random variables defined on the same probability space, such that both the Markov chains $U \rightarrow X \rightarrow Y$ and $U \rightarrow Y \rightarrow X$ hold. Then

- (i) There exists functions $f(X)$ and $g(Y)$ such that $f(X) = g(Y)$ with probability one.
- (ii) For $f,g$ in (i),  $U \rightarrow f(X) \rightarrow (X,Y)$ and $U \rightarrow g(Y) \rightarrow (X,Y)$ hold.

*Proof.*

$$

\begin{array}{c | cccc}

X/Y & y_1 & y_2 & \cdots & y_{ \mid \mathcal Y  \mid } \\
\hline
x_1 & (x_1,y_1) & (x_1,y_2) & \cdots & (x_1,y_{ \mid \mathcal Y \mid }) \\
x_2 & (x_2,y_1) & (x_2,y_2) & \cdots & (x_2,y_{ \mid \mathcal Y \mid }) \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
x_{ \mid \mathcal X \mid } & (x_{ \mid \mathcal X \mid },y_1) & (x_{ \mid \mathcal X \mid },y_2) & \cdots & (x_{ \mid \mathcal X \mid },y_{ \mid \mathcal Y \mid }) \\

\end{array}

$$

From the double Markov chain, we have for all $x \in \mathcal X, y \in \mathcal Y$, $P_{U \mid  x,y} = P_{U \mid x} = P_{U \mid y}$. Everything we derive in the sequel comes from this equality.

Every $(x,y)$ pair across the same row and same column gives the same conditional probability $P_{U \mid x,y}$ (if $P_{x,y} \neq 0$). For the conditional probability $P_{U \mid x,y}$ given by the first row and first column of the xy-table, denote it as $P_{U \mid i=1}$, paint the corresponding column and row in green. 

$$

\begin{array}{c | cccc}

X/Y & \textcolor{green}{y_1} & y_2 & \cdots & y_{ \mid \mathcal Y  \mid } \\
\hline
\textcolor{green}{x_1} & \textcolor{green}{(x_1,y_1)} & \textcolor{green}{(x_1,y_2)} & \textcolor{green}{\cdots} & \textcolor{green}{(x_1,y_{ \mid \mathcal Y \mid })} 
\\
x_2 & \textcolor{green}{(x_2,y_1)} & (x_2,y_2) & \cdots & (x_2,y_{ \mid \mathcal Y \mid }) 
\\
\vdots & \textcolor{green}{\vdots} & \vdots & \ddots & \vdots 
\\
x_{ \mid \mathcal X \mid } & \textcolor{green}{(x_{ \mid \mathcal X \mid },y_1)} & (x_{ \mid \mathcal X \mid },y_2) & \cdots & (x_{ \mid \mathcal X \mid },y_{ \mid \mathcal Y \mid }) 
\\

\end{array}

$$

For the second row and second column, paint xy-pairs in blue, and they give $P_{U \| i=2}$.

$$

\begin{array}{c | cccc}

X/Y & y_1 & \textcolor{blue}{y_2} & \cdots & y_{ \mid \mathcal Y  \mid } \\
\hline
x_1 & (x_1,y_1) & \textcolor{blue}{(x_1,y_2)} & \cdots & (x_1,y_{ \mid \mathcal Y \mid }) \\
\textcolor{blue}{x_2} & \textcolor{blue}{(x_2,y_1)} & \textcolor{blue}{(x_2,y_2)} & \textcolor{blue}{\cdots} & \textcolor{blue}{(x_2,y_{ \mid \mathcal Y \mid })} \\
\vdots & \vdots & \textcolor{blue}{\vdots} & \ddots & \vdots \\
x_{ \mid \mathcal X \mid } & (x_{ \mid \mathcal X \mid },y_1) & \textcolor{blue}{(x_{ \mid \mathcal X \mid },y_2)} & \cdots & (x_{ \mid \mathcal X \mid },y_{ \mid \mathcal Y \mid }) \\

\end{array}

$$

Now immediately we have $P_{U \mid i=1} \neq P_{U \mid i=2}$ only if $P_{x_1, y_2} = P_{x_2, y_1} = 0$, which seperate the two colors. Conversely, if $P_{x_1, y_2} \neq 0, P_{x_2, y_1} \neq 0$, then $P_{U \mid i=1} = P_{U \mid i=2}$.

Now for values of $P_{U \| i}$, we remove redundancy in $i$ so that each $P_{U \mid i}$ corresponds to a unique $i^\*$, denote them as $P_{U \mid i^\*}$.


Let the function $f(x) = i^\*$ such that $P_{U \mid x} = P_{U \mid i^\*}$. This gives $U \rightarrow f(X) \rightarrow X$. Note that for all $y \in \mathcal Y$, $P_{U \mid x,y} = P_{U \mid x} = P_{U \mid i^\*}$, thus we have $U \rightarrow f(X) \rightarrow Y$. WLOG, one can use a similar manner to define $g(y)$.

&nbsp;<span style="float: right;">■</span>

*Remark.*

1. If $X,Y$ are full support, that is, for all $x \in \mathcal X, y \in \mathcal Y$, $p(x,y) \neq 0$, then immediately we have $P_{U \mid i=1} = P_{U \mid i=2} = \cdots$. There is only one $i^\*$ and $P_{U \mid i^\*} = P_U$, which gives $U \perp X,Y$.

2. $f(X), g(Y)$ we found in this way is Gacs-Korner common information between $X$ and $Y$. Intuitively, everything $Y$ has that can help in decoding $X$ is contained in $f(X)$.
