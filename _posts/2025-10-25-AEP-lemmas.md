---
title: A Few Lemmas Related to the Asymptotic Equipartition Property (AEP)
description: An introduction to several lemmas commonly used in proofs in Shannon's multiuser information theory. These lemmas are closely related to typical sets, which consist of sequences whose probabilities are close to the asymptotic average characterized by the Asymptotic Equipartition Property (AEP).
date: 2025-10-25
author: Zhenduo
categories: [Information Theory, Asymptotic Equipartition Property]
tags: [Information Theory, Asymptotic Equipartition Property, Method of Types, Typical Set, Packing Lemma, Covering Lemma, Blowing-Up Lemma]
published: true
---

Two information theory textbooks are used as references:

- <a href="{{ site.baseurl }}/assets/files/books/Abbas El Gamal, Young-Han Kim - Network Information Theory-Cambridge University Press (2012).pdf">Abbas El Gamal and Young-Han Kim, <em>Network Information Theory</em> (Cambridge University Press, 2012)</a>

- <a href="{{ site.baseurl }}/assets/files/books/Wiley.Interscience.Elements.of.Information.Theory.Jul.2006.eBook-DDU.pdf">Thomas M. Cover and Joy A. Thomas, <em>Elements of Information Theory</em> (Wiley-Interscience, 2006)</a>

Throughout this post, logarithms are taken to base 2 unless stated otherwise.

## Asymptotic Equipartition Property (AEP)

Let $X_1, X_2, \ldots, X_n$ be independent and identically distributed (i.i.d.) random variables drawn according to a probability mass function $p_X(x)$. Denote $X^n=(X_1,\ldots,X_n)$.

The AEP states that

$$
-\frac{1}{n}\log p_{X^n}(X^n)
$$

converges in probability to the entropy $H(X)$ as $n\to\infty$. Equivalently, for every $\epsilon>0$,

$$
\lim_{n\to\infty}
\Pr\left(
\left|
-\frac{1}{n}\log p_{X^n}(X^n)-H(X)
\right|<\epsilon
\right)
=1.
$$

Because the source is memoryless,

$$
-\frac{1}{n}\log p_{X^n}(X^n)
=
\frac{1}{n}\sum_{i=1}^n -\log p_X(X_i).
$$

The AEP therefore follows from the weak law of large numbers, since

$$
\mathbb{E}\big[-\log p_X(X)\big]=H(X).
$$

The AEP leads naturally to the concept of a typical set: a collection of sequences whose empirical information content is close to the entropy of the source.

**Definition (Weakly typical set).**

For $\epsilon>0$, the weakly typical set is defined as

$$
{\mathcal T}_\epsilon^{(n)}(X)
\triangleq
\left\{
x^n\in\mathcal{X}^n:
\left|
-\frac{1}{n}\log p_{X^n}(x^n)-H(X)
\right|<\epsilon
\right\}.
$$

Equivalently,

$$
{\mathcal T}_\epsilon^{(n)}(X)
=
\left\{
x^n\in\mathcal{X}^n:
2^{-n(H(X)+\epsilon)}
<
p_{X^n}(x^n)
<
2^{-n(H(X)-\epsilon)}
\right\}.
$$

&nbsp;<span style="float: right;">■</span>

### Properties of the Typical Set

For every $\epsilon>0$ and all sufficiently large $n$, the typical set has the following properties.

1. **High probability.** A randomly generated source sequence belongs to the typical set with probability close to one:

   $$
   \Pr\left(X^n\in {\mathcal T}_\epsilon^{(n)}(X)\right)>1-\epsilon.
   $$

2. **Approximate equiprobability.** Every sequence in the typical set has probability approximately $2^{-nH(X)}$. More precisely, if $x^n\in {\mathcal T}_\epsilon^{(n)}(X)$, then

   $$
   2^{-n(H(X)+\epsilon)}
   <
   p_{X^n}(x^n)
   <
   2^{-n(H(X)-\epsilon)}.
   $$

3. **Cardinality.** The number of sequences in the typical set is approximately $2^{nH(X)}$:

   $$
   (1-\epsilon)2^{n(H(X)-\epsilon)}
   \leq
   \left|{\mathcal T}_\epsilon^{(n)}(X)\right|
   \leq
   2^{n(H(X)+\epsilon)}.
   $$

Joint typicality is defined similarly by applying the same definition to the pair $(X,Y)$ under the joint distribution $P_{XY}$.

The following approximation helps explain why type classes and typical sets have exponentially many elements.

**Lemma (Stirling's approximation).**

$$
\log_2(n!)
=
n\log_2 n
-
n\log_2 e
+
\frac{1}{2}\log_2(2\pi n)
+
O\left(\frac{1}{n}\right).
$$

&nbsp;<span style="float: right;">■</span>

A proof can be found on [Wikipedia](https://www.wikiwand.com/en/articles/Stirling%27s_approximation). At the exponential scale, the basic intuition is

$$
\log(n!)
=
\sum_{j=1}^n \log j
\approx
\int_1^n \ln x\,dx
=
n\ln n-n+1.
$$

For example, when $np$ is an integer, Stirling's approximation gives

$$
\binom{n}{np}
=
2^{nh_2(p)+O(\log n)},
$$

where

$$
h_2(p)
=
-p\log_2 p-(1-p)\log_2(1-p)
$$

is the binary entropy function. Thus, at the exponential scale,

$$
\binom{n}{np}\doteq 2^{nh_2(p)},
$$

where $\doteq$ denotes equality in the exponential order. This is the basic reason that a binary type class with empirical fraction $p$ has approximately $2^{nh_2(p)}$ elements.

## Setup

Consider a discrete memoryless channel (DMC) $P_{Y\mid X}$ with input $X$ and output $Y$. Fix an input distribution $P_X$ and let

$$
P_{XY}=P_XP_{Y\mid X}.
$$

Let

$$
\mathcal{C}
=
\left\{
X^n(m)
\right\}_{m=1}^M
$$

be a random codebook with

$$
M=2^{nR}.
$$

The codewords are generated independently according to

$$
X^n(m)\sim P_X^n,
\qquad
m\in\{1,\ldots,M\}.
$$

## The Packing Lemma

Suppose that message $1$ is transmitted, so the channel output $Y^n$ is generated according to

$$
P_{Y^n\mid X^n}
\left(y^n\mid X^n(1)\right)
=
\prod_{i=1}^n
P_{Y\mid X}\left(y_i\mid X_i(1)\right).
$$

For every $m\neq 1$, the nontransmitted codeword $X^n(m)$ is independent of $Y^n$. The joint typicality lemma implies that, for a sufficiently small typicality parameter $\epsilon$,

$$
\Pr\left(
\left(X^n(m),Y^n\right)
\in
\mathcal{T}_\epsilon^{(n)}(X,Y)
\right)
\lesssim
2^{-nI(X;Y)}.
$$

Because there are approximately $2^{nR}$ nontransmitted codewords, the union bound gives

$$
\Pr\left(
\exists m\neq 1:
\left(X^n(m),Y^n\right)
\in
\mathcal{T}_\epsilon^{(n)}(X,Y)
\right)
\lesssim
2^{nR}2^{-nI(X;Y)}.
$$

Consequently,

$$
R<I(X;Y)
\quad\Longrightarrow\quad
2^{nR}2^{-nI(X;Y)}
\longrightarrow 0
$$

as $n\to\infty$.

**Theorem (Simplified packing lemma).**

Let $\mathcal{C}=\lbrace X^n(m)\rbrace_{m=1}^{2^{nR}}$ be a random codebook generated independently according to $P_X^n$. Suppose that $X^n(1)$ is transmitted through the memoryless channel $P_{Y\mid X}$, producing the output $Y^n$. If

$$
R<I(X;Y),
$$

then, for sufficiently small $\epsilon>0$,

$$
\Pr\left(
\exists m\neq 1:
\left(X^n(m),Y^n\right)
\in
\mathcal{T}_\epsilon^{(n)}(X,Y)
\right)
\longrightarrow 0
$$

as $n\to\infty$.

&nbsp;<span style="float: right;">■</span>

The packing lemma formalizes the idea that, below the mutual-information threshold, independently generated incorrect codewords are unlikely to be confused with the transmitted codeword.

## The Covering Lemma

The covering lemma describes the complementary phenomenon. Instead of asking whether an independently generated codeword accidentally matches a given sequence, we ask whether a sufficiently large random codebook contains at least one matching codeword.

Fix a typical sequence

$$
y^n\in\mathcal{T}_{\epsilon'}^{(n)}(Y),
$$

and generate a random codebook

$$
\mathcal{C}
=
\left\{
X^n(m)
\right\}_{m=1}^{2^{nR}}
$$

independently according to $P_X^n$. For each codeword,

$$
\Pr\left(
\left(X^n(m),y^n\right)
\in
\mathcal{T}_\epsilon^{(n)}(X,Y)
\right)
\approx
2^{-nI(X;Y)}.
$$

Therefore, the expected number of jointly typical codewords is approximately

$$
2^{nR}2^{-nI(X;Y)}
=
2^{n(R-I(X;Y))}.
$$

When $R>I(X;Y)$, this quantity grows exponentially with $n$.

**Theorem (Covering lemma).**

Let $y^n$ be a typical sequence with respect to $P_Y$, and let

$$
\mathcal{C}
=
\left\{
X^n(m)
\right\}_{m=1}^{2^{nR}}
$$

be a random codebook whose codewords are generated independently according to $P_X^n$. If

$$
R>I(X;Y),
$$

then, for appropriate typicality parameters,

$$
\Pr_{\mathcal{C}}
\left\{
\exists m\in\{1,\ldots,2^{nR}\}:
\left(X^n(m),y^n\right)
\in
\mathcal{T}_\epsilon^{(n)}(X,Y)
\right\}
\longrightarrow 1
$$

as $n\to\infty$.

Equivalently, if $Y^n$ is random and typical with high probability, then

$$
\Pr
\left\{
\exists m\in\{1,\ldots,2^{nR}\}:
\left(X^n(m),Y^n\right)
\in
\mathcal{T}_\epsilon^{(n)}(X,Y)
\right\}
\longrightarrow 1.
$$

&nbsp;<span style="float: right;">■</span>

Thus, the packing and covering lemmas describe two sides of the same threshold:

- If $R<I(X;Y)$, a random codebook is sparse enough that incorrect jointly typical matches are unlikely.
- If $R>I(X;Y)$, a random codebook is dense enough to contain a jointly typical match with high probability.

## The Blowing-Up Lemma

Two relevant references are:

> K. Marton, “A Simple Proof of the Blowing-Up Lemma,” *IEEE Transactions on Information Theory*, vol. 32, no. 3, pp. 445–446, May 1986.

> R. Ahlswede and I. Csiszár, “Hypothesis Testing with Communication Constraints,” *IEEE Transactions on Information Theory*, vol. 32, no. 4, pp. 533–542, July 1986.

The blowing-up lemma states that if a set $F\subseteq\mathcal{Y}^n$ has probability that is not exponentially small under a product measure, then a sublinear enlargement of $F$ has probability approaching one.

For a set $F\subseteq\mathcal{Y}^n$ and an integer $\ell\geq 0$, define its Hamming $\ell$-neighborhood by

$$
\Gamma^\ell(F)
=
\left\{
\bar y^n\in\mathcal{Y}^n:
d_H(\bar y^n,y^n)\leq\ell
\text{ for some }y^n\in F
\right\},
$$

where

$$
d_H(\bar y^n,y^n)
=
\left|
\left\{
i:\bar y_i\neq y_i
\right\}
\right|
$$

is the Hamming distance.

**Theorem (Blowing-up lemma).**

Let $\mathcal{X}$ and $\mathcal{Y}$ be finite alphabets, and let $\epsilon_n\to 0$. There exist a sequence of positive integers $\ell_n$ and a sequence of real numbers $\gamma_n$ such that

$$
\frac{\ell_n}{n}\longrightarrow 0
\qquad\text{and}\qquad
\gamma_n\longrightarrow 1,
$$

with the following property.

For any i.i.d. sequence of pairs

$$
(X_1,Y_1),\ldots,(X_n,Y_n)
$$

taking values in $\mathcal{X}\times\mathcal{Y}$, any $x^n\in\mathcal{X}^n$, and any set $F\subseteq\mathcal{Y}^n$, if

$$
\Pr\left(
Y^n\in F
\mid
X^n=x^n
\right)
\geq
\exp(-n\epsilon_n),
$$

then

$$
\Pr\left(
Y^n\in\Gamma^{\ell_n}(F)
\mid
X^n=x^n
\right)
\geq
\gamma_n.
$$

&nbsp;<span style="float: right;">■</span>

The condition

$$
\Pr\left(
Y^n\in F
\mid
X^n=x^n
\right)
\geq
\exp(-n\epsilon_n)
$$

means that the probability of $F$ may converge to zero, but it cannot decay exponentially with a strictly positive exponent. The conclusion states that after enlarging $F$ by a Hamming radius $\ell_n=o(n)$, the conditional probability of the enlarged set approaches one.

The blowing-up lemma is particularly useful in strong converse arguments and distributed hypothesis testing. It allows a set with moderately large probability under a product distribution to be replaced by a slightly enlarged set whose probability is asymptotically close to one.
