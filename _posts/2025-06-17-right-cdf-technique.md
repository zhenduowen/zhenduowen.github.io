---
title: Right CDF Method for Expectation
date: 2025-06-17
author: Zhenduo
categories: [Statistics, General Techniques for Statistics]
tags: [Statistics, Expectation, CDF]
---

This is a simple yet useful characterization of the first order moment (Expectation) when **the support of probability mass(density) function is exactly $X \in \mathbb N$ ($X \geq 0$)**. But a similiar rationale can be applied and you may devise similar characterizations when this requirement on the support is not satisfied.

In the discrete case, if the support is $X \in \mathbb N$,

$$
\begin{align*}
E(X) &= \sum_{i=1}^\infty i P(X=i)
\\&= P(X=1) + 2P(X=2) + 3P(X=3)+ \cdots 
\\&=P(X \geq 1) + P(X\geq 2) + P(X \geq 3) + \ldots 
\\&= \sum_{i=1}^\infty P(X\geq i)
\end{align*}
$$
 
Similarly, in the continuous setting, if the support is $X \geq 0$, then

$$
E(X) = \int_{x=0}^\infty 1-F(x) dx
$$

where $F(x)$ is the cumulative distribution function(CDF) of $X$.

This is called the *right CDF method of expectation* as it is summation of rightward cumulative probabilities.

*Remark.*

1. Note that the sum indices of right CDF start at $1$.

2. The support requirement is commonly satisfied when $X$ is a [*Stopping Time*](https://www.wikiwand.com/en/articles/Stopping_time), where this method is commonly used.
