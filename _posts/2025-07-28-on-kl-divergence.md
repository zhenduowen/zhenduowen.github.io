---
title: On Kullback-Leibler Divergence
description: A brief introduction to Kullback-Leibler(KL) divergence, its properties and applications.
date: 2025-07-28
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Information Theory, Divergence]
published: false
---

## Preliminary
Let $P$ and $Q$ be two probability distributions over alphabet $\mathcal X$ such that $P(X) = 0$ whenever $Q(X) = 0$, often denoted as $P \ll Q$, then Kullback-Leibler(KL) Divergence is defined to be:
$$
D(P \| Q) \overset{\triangle}{=} \sum_{x \in \mathcal X} p(x) \log \frac{p(x)}{q(x)} = E_{P} \left ( \log \frac{p(X)}{q(X)} \right )
$$

My favorite interpretation of this is from the context of basic coding theory. By viewing $\log \frac{1}{p(x)}$, $\log \frac{1}{q(x)}$ as the code length of a symbol $x$, KL-divergence can be interpreted as measuring the expected number of extra bits required to code samples from $P$ using a code optimized for $Q$ rather than the code optimized for $P$ (excess entropy).

The following manipulations can be established from the definition.

- By chain rule, 
$$
D(P_{X_1,X_2} \| Q_{X_1,X_2}) = D(P_{X_1} \| Q_{X_1}) + D(P_{X_2|X_1} \| Q_{X_2|X_1})
$$


TODO: 
- chain expansion and data processing

- convexity of mutual information

Statistics:
- Stein's lemma, relates KL Divergence with Type II error exponent

- Donsker-Varadhen variational representation of KL divergence

- Golden formula for mutual information, Eq 8.7 in Information Theory: coding theorems for discrete memoryless systems

Information geometry and projection:
- Sanov Theorem

- Also, some basic arithmetics
 

