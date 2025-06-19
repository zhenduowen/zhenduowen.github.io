---
title: Submorduality Inequality for Entropy
date: 2025-06-05
author: Zhenduo
categories: [Network Information Theory, Entropy Inequalities]
tags: [NIT, Entropy, Information Theory]
---


**Lemma 1. (Elementary Compression Inequality)**

Let $X,Y,Z$ be discrete random variables, we have

$$
H(X,Y,Z) + H(Z) \leq H(X,Z) + H(Y,Z)
$$


*Proof.*

The inequality comes from adding a condition reduces inequality.

$$
\begin{align*}
\\&H(Y|X,Z) \leq H(Y|Z)
\\&\Leftrightarrow H(X,Y,Z) - H(X,Z) \leq H(Y,Z) - H(Z)
\end{align*}
$$ 

&nbsp;<span style="float: right;">■</span>

Lemma 1 says that if sets $\lbrace X,Z\rbrace$ and $\lbrace Y,Z \rbrace$, both moving equal amount of mass to their union $\lbrace X,Y,Z\rbrace$ and intersection $\lbrace Z\rbrace$, will result in a non-increased entropy. We call such an operation *elementary compression* in the sequel.

We can then construct inequalities using multiple steps of elementary compression. An example of applying this method is given here.

**Example 1.**

The following inequality can be shown using three steps of elementary compression.

$$
3H(X,Y,Z) + H(X) + H(Y) + H(Z) \leq 2(H(X,Y) + 2H(Y,Z) + 2 H(X,Z))
$$

The process of moving mass can be visualized using the following table.



|$\lbrace X,Y,Z\rbrace$ | $\lbrace X,Y\rbrace$ | $\lbrace Y,Z\rbrace$ | $\lbrace X,Z\rbrace$ | $\lbrace X\rbrace$ | $\lbrace Y\rbrace$ | $\lbrace Z\rbrace$ | $\phi$ |
|---|---|---|---|---|---|---|---|
| $0$ | $2$ | $2$ | $2$ | $0$ | $0$ | $0$ | $0$ |
| $1$ | $2$ | $1$ | $1$ | $0$ | $0$ | $1$ | $0$ |
| $2$ | $1$ | $0$ | $1$ | $0$ | $1$ | $1$ | $0$ |
| $3$ | $0$ | $0$ | $0$ | $1$ | $1$ | $1$ | $0$ |



This idea can be generalized and formalized in the following manner, credit to lecture notes of CUHK IERG 5254: Network Information Theory, 2025 Spring.

**Definition 1. (Compression)**

Let $n$ be a positive integer, and let $\lbrace \alpha_T \rbrace_T$, $\lbrace\beta_T \rbrace_T$ be two finite collections of non-negative real numbers indexed by $T \subseteq [1:n] $. We call $\lbrace\beta_T \rbrace_T$ an *elementary compression* of $\lbrace\alpha_T\rbrace_T$ if there exists $A,B \subseteq [1:n]$ with $A \nsubseteq B$ and $B \nsubseteq A $, and $0 \leq \delta \leq \min(\alpha_A, \alpha_B)$ such that for all $T \subseteq [1:n]$ we have 

$$
\beta_T = 
\begin{cases}
& \alpha_T - \delta \quad \text{if } T=A \text{ or } T = B,
\\& \alpha_T + \delta \quad \text{if } T = A \cup B \text{ or } T = A \cap B
\\&\alpha_T \quad \text{otherwise.}
\end{cases}
$$

The result of a finite sequence of elementary compressions of $\lbrace\alpha_T\rbrace_T$ is called *a compression of* $\lbrace\alpha_T\rbrace_T$.

&nbsp;<span style="float: right;">■</span>

The requirement of $A \nsubseteq B$ and $B \nsubseteq A $ comes from that when we trace back to union and intersections of $A$ and $B$, we do not get $A,B$ themselves. And $0 \leq \delta \leq \min(\alpha_A, \alpha_B)$ just means that the most we can move is whatever we have at hand.

Note that the relationship of "is a compression of" yields a partial order on the collection of n-fractional multiset. One may refer to:
> Balister, P. and B. Bollobás (2012, Mar). Projections, entropy and sumsets. Combinatorica 32(2), 125–141.

The following theorem is immediate.

**Theorem 1. (Submodularity Inequality of Entropy)**

Let $X_1, \ldots, X_n$ be any collection of random variables. Then the following hold:

- (i) $H(X_A) + H(X_B) \geq H(X_{A \cup B}) + H(X_{A \cap B})$, for all $A, B \subseteq [1:n]$;
- (ii) $\sum_{T \subseteq[1:n]} \alpha_T H(X_T) \geq \sum_{T \subseteq[1:n]} \beta_T H(X_T)$, for any $n$-fractional multisets $\lbrace\alpha_T\rbrace_T$, $\lbrace\beta_T \rbrace_T$ such that $\lbrace\beta_T \rbrace_T$ is a compression of $\lbrace\alpha_T\rbrace_T$.

&nbsp;<span style="float: right;">■</span>