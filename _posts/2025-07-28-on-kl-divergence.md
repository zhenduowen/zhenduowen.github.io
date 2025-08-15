---
title: On Kullback-Leibler Divergence
description: A brief introduction to Kullback-Leibler(KL) divergence, its properties and applications.
date: 2025-07-28
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Information Theory, Divergence]
published: true
---

## Preliminary
Let $P$ and $Q$ be two probability distributions over alphabet $\mathcal X$ such that $P(X) = 0$ whenever $Q(X) = 0$, often denoted as $P \ll Q$, then Kullback-Leibler(KL) Divergence is defined to be:
$$
D(P \| Q) \overset{\triangle}{=} \sum_{x \in \mathcal X} p(x) \log \frac{p(x)}{q(x)} = E_{P} \left ( \log \frac{p(X)}{q(X)} \right ).
$$

It is a special case $(f(x) = x\log x)$ of $f$-divergence, where $P \ll Q$ are two probability distributions over a space $\Omega$ and $f: [0, +\infty) \rightarrow(-\infty, +\infty]$ is convex, finite for $x>0$ and $f(0) = \lim_{t \rightarrow 0^+}f(t)$ (maybe infinity), and $f(1) = 0$, the $f$-divergence from $P$ to $Q$ is defined as
$$
D_f(P \| Q) = \int_\Omega f \left (\frac{dP}{dQ} \right ) dQ.
$$

My favorite interpretation of KL divergence is from the context of basic coding theory: By viewing $\log \frac{1}{p(x)}$, $\log \frac{1}{q(x)}$ as the code length of a symbol $x$, KL-divergence can be interpreted as measuring the expected number of extra bits required to code samples from $P$ using a code optimized for $Q$ rather than the code optimized for $P$ (excess entropy), $\sum_{x \in \mathcal X} p(x) \lbrace \log [\frac{1}{q(x)}] - \log[\frac{1}{p(x)}] \rbrace$.

The following manipulations can be established from the definition.

- **Chain rule**, 
    $$
    D(P_{X,Y} \| Q_{X,Y}) = D(P_{X} \| Q_{X}) + D(P_{Y|X} \| Q_{Y|X} | P_X).
    $$

    By $D(P_{Y|X} \| Q_{Y|X} | P_X)$ we mean $\sum_{x \in \mathcal X} p(x) \sum_{y \in \mathcal Y} p(y | x) \log \frac{p(y | x)}{q({y | x})}$.

    This allows us to "re-measure under a different distribution", for example, in
    Eq 8.7 from *Information Theory: coding theorems for discrete memoryless systems*:

    $$
    \begin{align*}
    D(P_{X,Y} \| Q_X P_Y) &= D(P_X \| Q_X) + D(P_{Y|X} \| P_Y | P_X) \\
    &= D(P_X \| Q_X)  + I_P(X;Y).
    \end{align*}
    $$

- **Convexity**,
    


TODO: 
- chain expansion and data processing

- convexity of mutual information
- Golden formula for mutual information, Eq 8.7 in Information Theory: coding theorems for discrete memoryless systems

Statistics:
- Stein's lemma, relates KL Divergence with Type II error exponent

- Donsker-Varadhen variational representation of KL divergence



Information geometry and projection:
- Sanov Theorem
 

