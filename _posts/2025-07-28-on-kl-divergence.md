---
title: On Kullback–Leibler Divergence
description: A brief introduction to Kullback–Leibler (KL) divergence, its properties, and some applications.
date: 2025-07-28
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Information Theory, Divergence, Mutual Information, Variational Representation]
published: true
---

Throughout this post, all logarithms are taken to base $2$, so information quantities are measured in bits.

## Definitions

**Definition (Kullback–Leibler divergence).**

Let $P$ and $Q$ be two probability distributions on a finite alphabet $\mathcal X$, with probability mass functions $p$ and $q$, respectively. We write $P\ll Q$ if

$$
q(x)=0\quad\Longrightarrow\quad p(x)=0.
$$

When $P\ll Q$, the Kullback–Leibler (KL) divergence from $P$ to $Q$ is defined as

$$
D(P\Vert Q)
\overset{\triangle}{=}
\sum_{x\in\mathcal X}
p(x)\log\frac{p(x)}{q(x)}=
\mathbb E_P\left[
\log\frac{p(X)}{q(X)}
\right].
$$

We use the convention $0\log(0/q)=0$. If $P\not\ll Q$, we define $D(P\Vert Q)=+\infty$.

 <span style="float: right;">■</span>

KL divergence is the $f$-divergence corresponding to $f(t)=t\log t$.

**Definition ($f$-divergence).**

Let $P\ll Q$ be probability measures on a measurable space $\Omega$. Let

$$
f:[0,+\infty)\rightarrow(-\infty,+\infty]
$$

be convex and finite on $(0,+\infty)$, with $f(1)=0$ and

$$
f(0)=\lim_{t\downarrow 0}f(t),
$$

where the limit may be $+\infty$. The $f$-divergence from $P$ to $Q$ is defined as

$$
D_f(P\Vert Q)
\overset{\triangle}{=}
\int_\Omega
f\left(\frac{dP}{dQ}\right)dQ.
$$

 <span style="float: right;">■</span>

My favorite interpretation of KL divergence comes from basic coding theory. If we regard

$$
\log\frac{1}{p(x)}
\qquad\text{and}\qquad
\log\frac{1}{q(x)}
$$

as idealized code lengths for the symbol $x$, then $D(P\Vert Q)$ measures the expected number of extra bits required to encode samples generated from $P$ using a code designed for $Q$, rather than one designed for $P$:

$$
\begin{aligned}
&\mathbb E_P\left[\log\frac{1}{q(X)}\right]
-
\mathbb E_P\left[\log\frac{1}{p(X)}\right]
\\&=
\sum_{x\in\mathcal X}
p(x)
\left(
\log\frac{1}{q(x)}
-
\log\frac{1}{p(x)}
\right)
\\
&=D(P\Vert Q).
\end{aligned}
$$

Thus, KL divergence can be interpreted as a mismatch penalty or redundancy. For ordinary prefix codes, this interpretation is exact up to the usual integer-length overhead; it becomes asymptotically exact under block or arithmetic coding.

An important special case of KL divergence is mutual information, which measures divergence from independence:

$$
I_P(X;Y)
=
D(P_{XY}\Vert P_XP_Y)
=
D(P_{Y\mid X}\Vert P_Y\mid P_X).
$$

## Properties

### Chain rule

KL divergence satisfies the chain rule

$$
D(P_{XY}\Vert Q_{XY})
=
D(P_X\Vert Q_X)
+
D(P_{Y\mid X}\Vert Q_{Y\mid X}\mid P_X),
$$

where the conditional divergence is defined as

$$
D(P_{Y\mid X}\Vert Q_{Y\mid X}\mid P_X)
=
\sum_{x\in\mathcal X}
p_X(x)
D\bigl(P_{Y\mid X=x}\Vert Q_{Y\mid X=x}\bigr).
$$

For example,

$$
\begin{aligned}
&D(P_{XY}\Vert Q_XP_Y)
\\&=
D(P_X\Vert Q_X)
+
D(P_{Y\mid X}\Vert P_Y\mid P_X)
\\
&=
D(P_X\Vert Q_X)+I_P(X;Y).
\end{aligned}
$$

This identity separates the marginal mismatch between $P_X$ and $Q_X$ from the dependence between $X$ and $Y$ under $P$.

### Convexity

KL divergence is jointly convex in its two arguments. For any $\lambda\in[0,1]$,

$$
\begin{aligned}
&D\bigl(
\lambda P_1+(1-\lambda)P_2
\Vert
\lambda Q_1+(1-\lambda)Q_2
\bigr)
\\
&\qquad\leq
\lambda D(P_1\Vert Q_1)
+
(1-\lambda)D(P_2\Vert Q_2).
\end{aligned}
$$

This follows from the log-sum inequality. In particular, $D(P\Vert Q)$ is convex in $P$ for fixed $Q$, and convex in $Q$ for fixed $P$.

### Nonnegativity

KL divergence is nonnegative. Since $t\log t$ is convex, Jensen’s inequality gives

$$
\begin{aligned}
D(P\Vert Q)
&=
\sum_{x:q(x)>0}
q(x)
\frac{p(x)}{q(x)}
\log\frac{p(x)}{q(x)}
\\
&\geq
\left(
\sum_{x:q(x)>0}p(x)
\right)
\log
\left(
\sum_{x:q(x)>0}p(x)
\right)
&=0,
\end{aligned}
$$

where the last equality follows from $P\ll Q$. Moreover,

$$
D(P\Vert Q)=0
\quad\Longleftrightarrow\quad
P=Q.
$$

### Data-processing inequality

Suppose that $P_X$ and $Q_X$ are passed through the same channel $W_{Y\mid X}$, producing output distributions $P_Y$ and $Q_Y$. Applying the chain rule to the resulting joint distributions gives

$$
\begin{aligned}
&D(P_XW_{Y\mid X}\Vert Q_XW_{Y\mid X})
\\&=
D(P_X\Vert Q_X)
+
\underbrace{
D(W_{Y\mid X}\Vert W_{Y\mid X}\mid P_X)
}_{=0}
\\
&=D(P_X\Vert Q_X)
\end{aligned}
$$

and also

$$
\begin{aligned}
&D(P_XW_{Y\mid X}\Vert Q_XW_{Y\mid X})
\\&=
D(P_Y\Vert Q_Y)
\\
&\quad+
\underbrace{
D(P_{X\mid Y}\Vert Q_{X\mid Y}\mid P_Y)
}_{\geq 0}.
\end{aligned}
$$

Therefore,

$$
D(P_Y\Vert Q_Y)\leq D(P_X\Vert Q_X).
$$

In other words, passing two distributions through the same channel cannot make them easier to distinguish.

### Concavity and convexity of mutual information

For a fixed channel $P_{Y\mid X}$, the mutual information $I_P(X;Y)$ is concave in the input distribution $P_X$.

To see this, let $U$ select between two input distributions $P_{X\mid U=1}$ and $P_{X\mid U=2}$. Because

$$
U\longrightarrow X\longrightarrow Y
$$

forms a Markov chain, $I(U;Y\mid X)=0$. Hence,

$$
\begin{aligned}
&I(X;Y)
\\&=I(U,X;Y)
\\
&=I(U;Y)+I(X;Y\mid U)
\\
&\geq I(X;Y\mid U).
\end{aligned}
$$

The right-hand side is the corresponding convex combination of the mutual information values associated with the two input distributions, proving concavity in $P_X$.

For a fixed input distribution $P_X$, mutual information is convex in the channel $P_{Y\mid X}$.

Let $U$ be independent of $X$ and select between two channels $P_{Y\mid X,U=1}$ and $P_{Y\mid X,U=2}$. The marginal channel obtained after averaging over $U$ is their corresponding mixture. We then have

$$
\begin{aligned}
&I(X;Y)
\\&\leq I(X;Y,U)
\\
&=I(X;U)+I(X;Y\mid U)
\\
&=I(X;Y\mid U),
\end{aligned}
$$

where the last equality follows from $I(X;U)=0$. The right-hand side is the convex combination of the mutual information values associated with the two channels, proving convexity in $P_{Y\mid X}$.

 <span style="float: right;">■</span>

## Donsker–Varadhan variational representation

Let $Q$ be a probability distribution on a measurable space $\mathcal X$. For every measurable function $f:\mathcal X\rightarrow\mathbb R$ satisfying

$$
\mathbb E_Q\left[2^{f(X)}\right]<\infty,
$$

we have

$$
\log\mathbb E_Q\left[2^{f(X)}\right]
=
\sup_{P:P\ll Q}
\left\lbrace
\mathbb E_P[f(X)]-D(P\Vert Q)
\right\rbrace.
$$

The supremum is attained by the Gibbs distribution $G$ defined by

$$
\frac{dG}{dQ}(x)
=
\frac{2^{f(x)}}{\mathbb E_Q[2^{f(X)}]}.
$$

*Proof.*

For any $P\ll Q$,

$$
\begin{aligned}
&D(P\Vert G)
\\&=
\mathbb E_P\left[
\log\frac{dP}{dG}
\right]
\\
&=
\mathbb E_P\left[
\log\frac{dP}{dQ}
+
\log\frac{dQ}{dG}
\right]
\\
&=
D(P\Vert Q)
+
\log\mathbb E_Q[2^{f(X)}]
-
\mathbb E_P[f(X)].
\end{aligned}
$$

Since $D(P\Vert G)\geq0$,

$$
\mathbb E_P[f(X)]-D(P\Vert Q)
\leq
\log\mathbb E_Q[2^{f(X)}].
$$

Equality holds for $P=G$, which proves the variational representation.

 <span style="float: right;">■</span>

### ELBO as a change-of-measure identity

An important application of KL divergence and change of measure is the evidence lower bound (ELBO), which is commonly used to train variational autoencoders.

> There is really nothing fancy if you have seen Donsker-Varadhan variational representation.

Consider a latent-variable model with latent variable $Z$, prior distribution $p_Z$, and conditional likelihood $p_\theta(x\mid z)$. The joint distribution is

$$
p_\theta(x,z)
=
p_Z(z)p_\theta(x\mid z),
$$

and the marginal likelihood, also called the evidence, is

$$
p_\theta(x)
=
\int p_Z(z)p_\theta(x\mid z),dz.
$$

The corresponding posterior distribution is

$$
p_\theta(z\mid x)
=
\frac{p_\theta(x,z)}{p_\theta(x)}.
$$

In many latent-variable models, the marginal likelihood $p_\theta(x)$ and the posterior $p_\theta(z\mid x)$ are difficult to compute. Variational inference therefore introduces a tractable distribution $q_\phi(z\mid x)$ to approximate the true posterior.

Assuming the relevant absolute-continuity conditions, consider the KL divergence from the approximate posterior to the true posterior:

$$
\begin{aligned}
&D\bigl(q_\phi(\cdot\mid x)\Vert p_\theta(\cdot\mid x)\bigr)
\\
&\quad=
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\log
\frac{q_\phi(Z\mid x)}
{p_\theta(Z\mid x)}
\right].
\end{aligned}
$$

Using Bayes’ rule to change the reference distribution inside the likelihood ratio gives

$$
\begin{aligned}
&D\bigl(q_\phi(\cdot\mid x)\Vert p_\theta(\cdot\mid x)\bigr)
\\
&\quad=
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\log
\frac{q_\phi(Z\mid x)p_\theta(x)}
{p_\theta(x,Z)}
\right]
\\
&\quad=
\log p_\theta(x)
-
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\log
\frac{p_\theta(x,Z)}
{q_\phi(Z\mid x)}
\right].
\end{aligned}
$$

Define the ELBO as

$$
\mathcal L_{\mathrm{ELBO}}(x;\theta,\phi)
\overset{\triangle}{=}
\mathbb E_{q_\phi(\cdot\mid x)}
\left\lbrack
\log
\frac{p_\theta(x,Z)}
{q_\phi(Z\mid x)}
\right\rbrack.
$$

We then obtain the exact decomposition

$$
\log p_\theta(x)
=
\mathcal L_{\mathrm{ELBO}}(x;\theta,\phi)
+
D\bigl(
q_\phi(\cdot\mid x)
\Vert
p_\theta(\cdot\mid x)
\bigr).
$$

Since KL divergence is nonnegative,

$$
\mathcal L_{\mathrm{ELBO}}(x;\theta,\phi)
\leq
\log p_\theta(x).
$$

Therefore, the ELBO is a lower bound on the marginal log-likelihood. The bound is tight if and only if

$$
q_\phi(z\mid x)
=
p_\theta(z\mid x)
$$

almost everywhere.

Using the factorization

$$
p_\theta(x,z)
=
p_Z(z)p_\theta(x\mid z),
$$

the ELBO can also be written in its familiar reconstruction–regularization form:

$$
\boxed{
\begin{aligned}
\mathcal L_{\mathrm{ELBO}}(x;\theta,\phi)
=
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\log p_\theta(x\mid Z)
\right]
-
D\bigl(
q_\phi(\cdot\mid x)
\Vert
p_Z
\bigr).
\end{aligned}
}
$$

The first term measures how well the decoder reconstructs or explains $x$ from the latent variable $Z$. The second term regularizes the approximate posterior by encouraging it to remain close to the prior distribution $p_Z$.

The change-of-measure interpretation can also be seen directly. Under the usual common-support condition,

$$
\begin{aligned}
p_\theta(x)
&=
\int
q_\phi(z\mid x)
\frac{p_\theta(x,z)}
{q_\phi(z\mid x)}
dz
\\
&=
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\frac{p_\theta(x,Z)}
{q_\phi(Z\mid x)}
\right].
\end{aligned}
$$

Applying Jensen’s inequality gives

$$
\begin{aligned}
\log p_\theta(x)
&=
\log
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\frac{p_\theta(x,Z)}
{q_\phi(Z\mid x)}
\right]
\
&\geq
\mathbb E_{q_\phi(\cdot\mid x)}
\left[
\log
\frac{p_\theta(x,Z)}
{q_\phi(Z\mid x)}
\right]
\
&=
\mathcal L_{\mathrm{ELBO}}(x;\theta,\phi).
\end{aligned}
$$

The ELBO is also a direct instance of the Donsker–Varadhan variational representation. Taking

$$
f(z)=\log p_\theta(x\mid z)
$$

and $Q=P_Z$ in the preceding variational formula gives

$$
\log p_\theta(x)
=
\sup_{R\ll P_Z}
\left\lbrace
\mathbb E_R
\left[
\log p_\theta(x\mid Z)
\right]
-
D(R\Vert P_Z)
\right\rbrace.
$$

The maximizing distribution is the true posterior

$$
R^*(z)=p_\theta(z\mid x).
$$

A variational autoencoder restricts $R$ to a parameterized family $q_\phi(\cdot\mid x)$ and maximizes the resulting ELBO over the encoder parameter $\phi$ and the decoder parameter $\theta$.

Thus, the change of measure itself yields an exact identity, while the lower-bound property follows from either the nonnegativity of KL divergence or Jensen’s inequality.


## Stein’s lemma

Suppose that, given an i.i.d. sample $X^n=(X_1,\ldots,X_n)$, we wish to test

$$
H_0:X_i\sim P
\qquad\text{against}\qquad
H_1:X_i\sim Q,
$$

where $P$ and $Q$ are distributions on a finite alphabet $\mathcal X$.

Let $B_n\subseteq\mathcal X^n$ be the acceptance region for $H_0$. The type-I and type-II error probabilities are respectively

$$
\alpha_n(B_n)=P^n(B_n^c)
$$

and

$$
\beta_n(B_n)=Q^n(B_n).
$$

For a fixed type-I error tolerance $\epsilon\in(0,1)$, define the smallest achievable type-II error by

$$
\beta_n^*(\epsilon)
\overset{\triangle}{=}
\min_{\substack{B_n\subseteq\mathcal X^n:\
P^n(B_n)\geq1-\epsilon}}
Q^n(B_n).
$$

**Theorem (Stein’s lemma).**

For every $\epsilon\in(0,1)$,

$$
\lim_{n\rightarrow\infty}
-\frac{1}{n}\log\beta_n^*(\epsilon)
=
D(P\Vert Q).
$$

Thus, subject to a fixed constraint on the type-I error, the optimal type-II error decays exponentially with exponent $D(P\Vert Q)$.

 <span style="float: right;">■</span>

The most detailed proof and explanation of this lemma that I know can be found in <a href="{{ site.baseurl }}/assets/files/books/information_theory_from_coding_to_learning.pdf">Chapter 14, “Neyman–Pearson Lemma,” of *Information Theory: From Coding to Learning*, by Yury Polyanskiy and Yihong Wu</a>.

## Information projection and the conditional limit theorem

Let $\mathcal P(\mathcal X)$ denote the probability simplex on a finite alphabet $\mathcal X$. Suppose that $E\subseteq\mathcal P(\mathcal X)$ is a nonempty closed convex set and $Q\notin E$. Let $P^*\in E$ be the information projection, or $I$-projection, of $Q$ onto $E$:

$$
P^*
\in
\operatorname*{arg,min}_{P\in E}D(P\Vert Q).
$$

Equivalently,

$$
D(P^*\Vert Q)
=
\min_{P\in E}D(P\Vert Q).
$$

**Theorem (Pythagorean inequality for relative entropy).**

For every $P\in E$,

$$
D(P\Vert Q)
\geq
D(P\Vert P^*)+D(P^*\Vert Q).
$$

This is an information-geometric analogue of the Pythagorean inequality: among all distributions in $E$, $P^*$ is the distribution closest to $Q$ in relative entropy.

 <span style="float: right;">■</span>

This inequality leads to the conditional limit theorem. Let $X_1,\ldots,X_n$ be drawn i.i.d. from $Q$, and let $\widehat P_{X^n}$ denote their empirical distribution. Conditional on the rare event

$$
\widehat P_{X^n}\in E,
$$

the distribution of any fixed number of coordinates becomes asymptotically i.i.d. according to $P^*$. In particular,

$$
\Pr\left(
X_1=a
\mid
\widehat P_{X^n}\in E
\right)
\longrightarrow
P^*(a).
$$

More generally, for every fixed $k$,

$$
\Pr\left(
X_1=a_1,\ldots,X_k=a_k
\mid
\widehat P_{X^n}\in E
\right)
\longrightarrow
\prod_{i=1}^kP^*(a_i).
$$

Thus, when an empirical distribution generated under $Q$ is conditioned to lie in the rare set $E$, it concentrates around the $I$-projection $P^*$.
