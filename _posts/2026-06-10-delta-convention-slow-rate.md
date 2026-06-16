---
title: Delta Convention and Slow Rate
description: Delta Convention, from information theory, and ``Slow Rate", from learning theory.
date: 2025-06-10
author: Zhenduo
categories: [Information Theory, Asymptotic Equipartition Property]
tags: [Information Theory, Asymptotic Equipartition Property, Method of Types, Typical Set]
published: true
---

# The Delta Convention and the Slow Rate

## 1. The Delta Convention

In Csiszár and Körner’s *Information Theory: Coding Theorems for Discrete Memoryless Systems* [1], the **Delta Convention** refers to choosing a sequence \(\delta_n\) such that

$$
\delta_n \to 0,
\quad
\sqrt n\,\delta_n \to \infty.
$$

Equivalently,

$$
\frac{1}{\sqrt n} = o(\delta_n).
$$

A typical example is

$$
\delta_n = n^{-1/3}.
$$

This convention is often used in typical-sequence and method-of-types arguments.

## 2. Why the Delta Convention Appears

Let \(X_1,\ldots,X_n\) be i.i.d. samples from a distribution \(P\), and let \(\hat P_n\) be the empirical distribution. For each symbol \(a\),

$$
\hat P_n(a)-P(a) = O_p\left(\frac1{\sqrt n}\right).
$$

Thus, the empirical distribution naturally fluctuates around \(P\) at scale

$$
\frac1{\sqrt n}.
$$

In typicality arguments, one wants a tolerance window \(\delta_n\) satisfying two requirements.

First,

$$
\delta_n \to 0,
$$

so that entropy and probability estimates become asymptotically sharp.

Second,

$$
\delta_n \gg \frac1{\sqrt n},
$$

so that the typical set still has probability tending to one.

Therefore, the Delta Convention can be summarized as

$$
\frac1{\sqrt n} \ll \delta_n \ll 1.
$$

It chooses a shrinking neighborhood around the true distribution, but one that is still wide enough to contain ordinary empirical fluctuations.

## 3. The Slow Rate in Learning Theory

In statistical learning theory, many generalization bounds have the form

$$
R(\hat f_n)-R(f^\star)= O\left(\frac1{\sqrt n}\right),
$$

where \(R(\hat f_n)\) is the risk of the learned predictor and \(R(f^\star)\) is the risk of the best predictor in the class.

This is often called the **slow rate**.

It appears in standard uniform-convergence bounds, such as VC-dimension bounds, Rademacher-complexity bounds, and empirical-process bounds.

A typical bound has the form

$$
\sup_{f\in \mathcal F}
\left|
R(f)-\hat R_n(f)
\right| = O\left(
\sqrt{\frac{\mathrm{complexity}(\mathcal F)}{n}}
\right).
$$

The \(1/\sqrt n\) factor appears because empirical risks are averages of \(n\) random variables. For a fixed function \(f\),

$$
\hat R_n(f) = \frac1n \sum_{i=1}^n \ell(f(X_i),Y_i),
$$

and the standard deviation of this average is typically of order

$$
\frac1{\sqrt n}.
$$

Uniform convergence extends this fixed-function fluctuation estimate to an entire function class \(\mathcal F\), usually at the cost of an additional complexity term.

## 4. Where the Slow Rate Comes From

The slow rate comes from the same basic phenomenon as the Central Limit Theorem.

For a sample average,

$$
\bar Z_n = \frac1n\sum_{i=1}^n Z_i,
$$

we have

$$
\mathrm{Var}(\bar Z_n) = \frac{\mathrm{Var}(Z)}{n}.
$$

Therefore,

$$
\sqrt{\mathrm{Var}(\bar Z_n)} = O\left(\frac1{\sqrt n}\right).
$$

Since empirical risk is also a sample average, its random fluctuation is naturally of order \(1/\sqrt n\).

A learning algorithm chooses \(\hat f_n\) based on empirical risk. If the empirical risk uniformly approximates the true risk within order \(1/\sqrt n\), then the excess risk of empirical risk minimization is also typically controlled at order

$$
O\left(\frac1{\sqrt n}\right).
$$

This is the basic origin of the slow rate.

## 5. Why Is It Called “Slow”?

It is called “slow” because, under stronger assumptions, one can sometimes obtain faster convergence rates such as

$$
O\left(\frac1n\right).
$$

These are called **fast rates**.

The difference is substantial. To achieve error at most \(\varepsilon\), a slow-rate bound

$$
O\left(\frac1{\sqrt n}\right)
$$

requires roughly

$$
n = O\left(\frac1{\varepsilon^2}\right)
$$

samples, while a fast-rate bound

$$
O\left(\frac1n\right)
$$

requires only

$$
n = O\left(\frac1{\varepsilon}\right)
$$

samples.

So the slow rate is not “slow” because it is unnatural. It is slow relative to the faster \(1/n\)-type rates that become available when the learning problem has additional structure.

Fast rates often require assumptions such as:

- strong convexity,
- exp-concavity,
- Bernstein conditions,
- Tsybakov margin conditions,
- low-noise classification,
- well-specified parametric models.

One useful intuition is:

- estimating a mean or empirical average usually has \(1/\sqrt n\) fluctuations;
- estimating an excess risk can sometimes be faster, because risk may behave quadratically around its optimum.

For example, suppose

$$
\hat \theta_n-\theta^\star = O_p\left(\frac1{\sqrt n}\right).
$$

If the risk has local quadratic curvature,

$$
R(\theta)-R(\theta^\star) \approx C\|\theta-\theta^\star\|^2,
$$

then the excess risk may scale as

$$
O_p\left(\frac1n\right).
$$

This explains why \(1/\sqrt n\) is the default rate, while \(1/n\) requires additional curvature, margin, or noise assumptions.

## 6. Comparison

Both the Delta Convention and the slow rate are related to the same statistical scale:

$$
\frac1{\sqrt n}.
$$

But they use this scale differently.

| Concept          | Role of \(1/\sqrt n\)                               |
| ---------------- | --------------------------------------------------- |
| Delta Convention | A fluctuation scale that \(\delta_n\) must dominate |
| Slow rate        | The actual convergence rate of many learning bounds |

In information theory,

$$
\delta_n
$$

is chosen slightly larger than \(1/\sqrt n\), so that typical sets have high probability while still shrinking.

In learning theory,

$$
\frac1{\sqrt n}
$$

is often the rate one proves for generalization error or excess risk.

Thus,

$$
\text{information theory: }
\frac1{\sqrt n} \ll \delta_n \ll 1,
$$

whereas

$$
\text{learning theory: }
R(\hat f_n)-R(f^\star) = O\left(\frac1{\sqrt n}\right).
$$

## Reference

[1] I. Csiszár and J. Körner, *Information Theory: Coding Theorems for Discrete Memoryless Systems*, 2nd ed., Cambridge University Press, 2011.