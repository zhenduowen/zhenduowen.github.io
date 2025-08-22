---
title: On Kullback-Leibler Divergence
description: A brief introduction to Kullback-Leibler(KL) divergence, its properties and applications.
date: 2025-07-28
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Information Theory, Divergence, Mutual Information, Variational Representation]
published: true
---
## Definitions

**Definition. (Kullback-Leibler Divergence)** 

Let $P$ and $Q$ be two probability distributions over alphabet $\mathcal X$ such that $P(X) = 0$ whenever $Q(X) = 0$, often denoted as $P \ll Q$, then Kullback-Leibler(KL) divergence is defined to be:

$$
D(P \| Q) \overset{\triangle}{=} \sum_{x \in \mathcal X} p(x) \log \frac{p(x)}{q(x)} = E_{P} \left ( \log \frac{p(X)}{q(X)} \right ).
$$

&nbsp;<span style="float: right;">■</span>

It is a special case $(f(x) = x\log x)$ of $f$-divergence.

**Definition. ($f$-Divergence)** 

Let $P \ll Q$ be two probability distributions over a space $\Omega$ and $f: [0, +\infty) \rightarrow(-\infty, +\infty]$ is convex, finite for $x>0$ and $f(0) = \lim_{t \rightarrow 0^+}f(t)$ (maybe infinity), and $f(1) = 0$, the $f$-divergence from $P$ to $Q$ is defined as 

$$
D_f(P \| Q) \overset{\triangle}{=} \int_\Omega f \left (\frac{dP}{dQ} \right ) dQ.
$$

&nbsp;<span style="float: right;">■</span>

My favorite interpretation of KL divergence is from the context of basic coding theory: By viewing $\log \frac{1}{p(x)}$, $\log \frac{1}{q(x)}$ as the code length of a symbol $x$, KL-divergence can be interpreted as measuring the expected number of extra bits required to code samples from $P$ using a code optimized for $Q$ rather than the code optimized for $P$ (excess entropy), $\sum_{x \in \mathcal X} p(x) \lbrace \log [\frac{1}{q(x)}] - \log[\frac{1}{p(x)}] \rbrace$.

A well-known case of KL divergence is *Mutual Information*, which can be viewed as divergence against independence:
$$
I_P(X;Y) = D(P_{XY} \| P_X P_Y) = D(P_{Y|X} \| P_Y | P_X).
$$

## Properties

The following manipulations can be directly established from the definition.

- **Chain rule**, 

    $$
    D(P_{X,Y} \| Q_{X,Y}) = D(P_{X} \| Q_{X}) + D(P_{Y|X} \| Q_{Y|X} | P_X).
    $$

    Note that by $D(P_{Y\|X} \\| Q_{Y \|X} \| P_X)$ we mean $\sum_{x \in \mathcal X} p(x) \sum_{y \in \mathcal Y} p(y \| x) \log \frac{p(y \| x)}{q({y \| x})}$.

    This allows us to "re-measure under a different distribution", for example, 
    Eq 8.7 in *Information Theory: coding theorems for discrete memoryless systems*:

    $$
    \begin{align*}
    D(P_{X,Y} \| Q_X P_Y) &= D(P_X \| Q_X) + D(P_{Y|X} \| P_Y | P_X) \\
    &= D(P_X \| Q_X)  + I_P(X;Y).
    \end{align*}
    $$

- **Convexity**,

    $$
    D(P \| Q) {=} \sum_{x \in \mathcal X} p(x) \log \frac{p(x)}{q(x)} {=} \sum_{x \in \mathcal X} [p(x) \log p(x) - p(x) \log q(x) ].
    $$

    Therefore, KL divergence is **convex in $P_X$ for every fixed $Q_X$ and convex in $Q_X$ for every fixed $P_X$,** as $x \log(x)$ is convex.

    - KL divergence is **non-negative**, $-\log(\cdot)$ is convex, by Jensen's inequality:

        $$
        \begin{align*}
        D(P \| Q) &= \sum_{x \in \mathcal X} p(x) \log \frac{p(x)}{q(x)}
        \\&= - \sum_{x \in \mathcal X} p(x) \log \frac{q(x)}{p(x)}
        \\& \geq -  \log \sum_{x \in \mathcal X} p(x) \frac{q(x)}{p(x)} = 0.
        \end{align*}
        $$

    - The above non-negativity yields the **data processing inequality**. If two distributions $P_X$ and $Q_X$ are passed through the same channel $W_{Y\|X}$, then using the chain rule

        $$
        \begin{align*}
        D(P_X \| Q_X) &= D(P_X \| Q_X) + \underbrace{D(W_{Y|X} \| W_{Y|X} | P_X)}_{=0} \\
        &= D(P_Y \| Q_Y) + \underbrace{D(P_{X|Y} \| Q_{X|Y} | P_Y)}_{\geq 0} 
        \end{align*}
        $$

        That is, it is harder to distinguish between two distributions after passing through the same channel.

    - The mutual information $I_P(X;Y) = D(P_{XY} \\| P_X P_Y)$ is concave in $P_X$ for every fixed $P_{Y\|X}$ and convex in $P_{Y \| X}$ for every fixed $P_X$.

        *Proof.*

        If fix the channel $P_{Y\|X}$, choose between two input distributions by using $U: P_{X\|U=u_1}, P_{X\|U=u_2}$, this forms a Markov chain $U \rightarrow X \rightarrow Y$, $I(U;Y \| X) = 0$, then

        $$
        I(X;Y) = I(UX;Y) \geq I(X;Y|U),
        $$

        which gives concave in $P_X$.

        If fix the input distribution $P_X$, then choose between two channels by using $U: P_{Y\|X, U=u_1}, P_{Y\|X, U = u_2}$. Since the decision $U$ to choose which channel is independent of $X$ we have $I(U;X) = 0$. Then

        $$
        I(X; Y) \leq I(X;Y) + I(U;X|Y) = I(U;X) + I(X;Y|U) = I(X;Y|U),
        $$

        which gives convex in $P_{Y\| X}$.

    &nbsp;<span style="float: right;">■</span>

## **Donsker-Varadhen variational representation of KL divergence**

Let $Q$ be a probability distribution on a measurable space $\mathcal X$. For every measurable function $f : \mathcal X \rightarrow \mathbb R$ such that $E_Q[e^{f(X)}] < \infty$, we have 

$$
\begin{align*}
    \log E_Q [e^{f(X)}] = \sup_{P:P \ll Q} \left\{ E_P [f(X)] - D(P \| Q) \right\}.
\end{align*}
$$

And the supremum is attained by the Gibbs distribution $G$:

$$
\begin{align*}
    \frac{dG}{dQ} (X) = \frac{e^{f(X)}}{E_Q[e^{f(X)}]}.
\end{align*}
$$

*Proof.*

$$
\begin{align*}
    D(P \| G) &= E_P\left[\log \frac{dP}{dQ}\right] + E_P\left[\log \frac{dQ}{dG}\right] \\
    &= D(P \|Q) + \log E_Q\left [ e^{f(X)} \right] - E_P[f(X)] \geq 0.
\end{align*}
$$

&nbsp;<span style="float: right;">■</span>

## Chernoff-Stein's lemma

The statistician has to decide on the hypothesis of a sample of size $n$ between $H_0: P = \lbrace P(x): {x \in \mathcal X} \rbrace$ and $H_1: Q = \lbrace Q(x): x \in \mathcal X \rbrace$, $\mathcal X$ is finite. Often his task is to find a test with a minimal probability of an error of type I, i.e., to find $B \subset \mathcal X^n$ with $P^n(B) \geq 1 - \epsilon$ (so that type I error is less than or equal to $\epsilon \in (0,1)$) and $Q^n(x) = \beta(n, \epsilon) \overset{\triangle}{=} \min_A \lbrace Q^n(A) \mid A \subset \mathcal X^n, P^n(A) \geq 1 - \epsilon \rbrace$ is the minimal type II error that can be achieved.

Both type I and type II error goes to zero as $n \rightarrow \infty$. The exponential rate of convergence to zero of $\beta(n, \epsilon)$ has been determined by Chernoff-Stein's lemma:

**Theorem. (Chernoff-Stein's lemma)**
> H. Chernoff, "A measure of asymptotic efficiency for tests of a hypothesis based on the sum of observations," *The Annals of Mathematical Statistics*, vol. 23, no. 4, pp. 493-507, 1952.

For any $\epsilon \in (0,1)$,

$$
- \lim_{n \rightarrow \infty} \frac 1n \log \beta(n, \epsilon) = D(P \| Q).
$$

&nbsp;<span style="float: right;">■</span>

## Conditional Limit Theorem



**Theorem. (11.6.1 in *Elements of Information Theory*)**

For a closed convex set $E \subseteq \mathcal P$  and distribution $Q$ , let $P^* \in E$  be the distribution that achieves the minimum distance to $Q$; that is,

$$
D(P^* \| Q) = \min_{P \in E} D(P \| Q).
$$

Then

$$
D(P \| Q) \geq D(P \| P^*) + D(P^* \| Q)
$$

for all $ P \in E $.




 

