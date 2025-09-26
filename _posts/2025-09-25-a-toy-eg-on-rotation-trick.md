---
title: Characteristic Functions, Gaussian Distribution, and A toy example on the rotation trick
description: Serveral characterizations of the Gaussian Distribution and A toy example explaining the rotation trick, which is commonly used to establish Gaussian optimality in Information Theory.
date: 2025-09-25
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Information Theory, Rotation Trick, Statistics, Gaussian Distribution, Characteristic Functions]
published: true
---
## Characteristic function
**Definition. (Characteristic function)** $\phi_X(t) = E_X(e^{i t X}), t \in \mathbb R$ ($i$ is the imaginary unit) is the characteristic function of the random variable $X$.


$\phi_X(t)$ is the Fourier transform of density $f_X$. Every characteristic function is: 
- Bounded: $\| \phi_X(t) \| = \|E_X(e^{i t X})\| = \| \int_{-\infty}^\infty f_X(x) e^{itx} dx \| \leq \int_{-\infty}^\infty \| f_X(x) e^{itx} \| dx = \int_{-\infty}^\infty \| f_X(x) \| dx = 1$.
- Continuous: $\| e^{i t_1 x} - e^{i t_2 x}\| \leq 2, \forall t_1, t_2, x$. Since $2f_X(x)$ is integrable, by dominated convergence theorem, $\lim_{t_1 \rightarrow t_2} \int_{-\infty}^\infty \| e^{i t_1 x} - e^{i t_2 x}\| f_X(x) dx = \int_{-\infty}^\infty \lim_{t_1 \rightarrow t_2} \| e^{i t_1 x} - e^{i t_2 x}\| f_X(x) dx = 0$. And the continuity is actually uniform: $\| \phi_X(t + h) - \phi_X(t) \| \leq E(\| e^{ihX} - 1 \|)$.

The following properties are immediate from the definition:

- $\phi_X(0) = 1$,
- $\phi_X(-t) = \overline{\phi_X(t)}$,
- $\phi_{aX + b} = e^{it b} \phi_X(at),\ a,b \in \mathbb R$.

**Proposition. (CF of sum of independent RVs)**
If $X$ and $Y$ are independent, then $\phi_{X+Y}(t) = \phi_X(t) \phi_Y(t)$.

*Proof.*
Let $Z = X + Y$, the following integrals are integrated over $(-\infty, \infty)$,

$$
\begin{align*}
\phi_Z(t) &= \int_z e^{itz}f_Z(z) \ dz \\
&= \int_z e^{itz} \int_h f_X(z - h) f_Y(h)\ dh dz \\
\end{align*}
$$

while the first identity comes from independence of $X$ and $Y$. Since both integrals converge absolutely, we can interchange the integrals:

$$
\begin{align*}
\ldots &= \int_h \int_z e^{it(z-h)}  f_X(z - h) dz \ f_Y(h) e^{ith}\  dh\\
&= \int_{z'} e^{it(z')}  f_X(z') dz' \int_h  \ f_Y(h) e^{ith}\  dh \quad (z' = z - h)\\
&= \phi_X(t) \phi_Y(t).
\end{align*}
$$

&nbsp;<span style="float: right;">■</span>

## A few characterizations of Gaussian Distribution

The following characterizations of the Gaussian distribution are known:

- Solving an ordinary differential equation of the characteristic function,
- Closedness under linear combination,
- Invariance of independence under rotation.

**Proposition. (Gaussian Characteristic function)**

Let $\phi_X(t) = E_X(e^{i t X}), t \in \mathbb R$ be the characteristic function of $X$, then $X$ is Gaussian if and only if

$$
\phi_X^2(t) = \Big[ \frac{d}{dt} \phi_X(t) \Big]^2 - \phi(t) \frac{d^2}{dt^2} \phi_X(t),
$$

for every $t \in \mathbb R$.

&nbsp;<span style="float: right;">■</span>

**Proposition. (Closedness under linear combination)**
> [https://math.stackexchange.com/questions/4961852/can-we-characterize-the-family-of-normal-gaussian-distributions-by-closedness](https://math.stackexchange.com/questions/4961852/can-we-characterize-the-family-of-normal-gaussian-distributions-by-closedness)

If a family probability distribution on $\mathbb{R}^1$ is 

- parameterized by its expectation $\mu$ and variance $\sigma^2$, i.e., for each $\mu \in \mathbb{R}$ and $\sigma^2 \in \mathbb{R}^+$, there is exactly one distribution in this family with expectation $\mu$ and variance $\sigma^2$,
- closed under independent addition, i.e., if both $X, Y$'s distributions are in this family, and $X, Y$ are independent, then $X + Y$ is in this family,
- closed under scalar multiplication, i.e., if $X$ is in this family, then for $\alpha \in \mathbb{R} \setminus \{0\}$, $\alpha X$ is also in this family,


then can we claim that this family of distributions is exactly the family of all normal distributions on $\mathbb{R}$.

&nbsp;<span style="float: right;">■</span>

**Theorem. (Kac–Bernstein)**
> Proof can be found at:
> <a href="{{zhenduowen.github.io}}/assets/files/notes/on_a_char_of_normal_distribution.pdf">Kac M. "On a characterization of the normal distribution," American Journal of Mathematics. 1939. 61. pp. 726—728.</a>
>
> [https://math.stackexchange.com/questions/4329747/bernsteins-theorem-probability](https://math.stackexchange.com/questions/4329747/bernsteins-theorem-probability)
>
> Bernstein S. N. "On a property which characterizes a Gaussian distribution," Proceedings of the Leningrad Polytechnic Institute. 1941. V. 217, No 3. pp. 21—22.
>
> For related work, see:
>
> M. P. Quine and E. Seneta, "The generalization of the Kac-Bernstein theorem," *Probability and Mathematical Statistics*, vol. 19, no. 2, pp. 441-452, 1999.

Given two independent random variables $X$ and $Y$, then $X + Y$ is independent of $X-Y$ if and only if $X,Y$ are Gaussian.

&nbsp;<span style="float: right;">■</span>

There is a generalization of this theorem which says that *If 2 linear forms on independent random variables are independent, the variables are normal*. See <a href="https://www.wikiwand.com/en/articles/Darmois%E2%80%93Skitovich_theorem">Darmois–Skitovich theorem</a>.


## A toy example of Rotation Trick 

**Example. (Gaussian is the entropy maximizer under power constraint)**

Let $Y = X + Z$ where $Z$ is Gaussian and independent of $X$. The goal is to maximize the differential entropy of $h(Y)$ given that $E(X^2) \leq P$. Since this is optimization of a continuous function over compact space, we can assume that the optimizer exists.

Let $X^\*$ be the maximizer, $v = h(X^\* + Z)$. Take two independent copies of $X^\*$ and denote them as $X_a, X_b$. Take two independent copies of $Z$ and denote them as $Z_a, Z_b$. Then we have, by independence, $h(X_a + Z_a, X_b + Z_b) = 2v$.

Create two rotated versions:

$$
\begin{align*}
X_+ = \frac{X_a + X_b}{\sqrt 2}, \quad X_- = \frac{X_a - X_b}{\sqrt 2}, \quad Z_+ = \frac{Z_a + Z_b}{\sqrt 2}, \quad Z_- = \frac{Z_a - Z_b}{\sqrt 2}
\end{align*}
$$

Noted that for a linear transformation $A$, $h(AX) = h(X) + \ln\|\det(A)\|$. Since the above rotation does not "stretch" the space, its determinant is one. We have $h(X_a + Z_a, X_b + Z_b) = h(X_+ + Z_+, X_- + Z_-) = h(X_+ + Z_+) + h(X_- + Z_-) - I(X_+ + Z_+; X_- + Z_-) \leq 2v$.

The last inequality is because that $X^*$ is a maximizer, we have $h(X_+ + Z_+), h(X_- + Z_-) \leq 2v$, which "squeezes" $I(X_+ + Z_+; X_- + Z_-) = 0$. Note that this implies $I(X_+; X_-) = 0$, that is, $X_+$ is independent of $X_-$. By Kac-Berstein's Theorem, we have $X_a$ and $X_b$ are Gaussian.



