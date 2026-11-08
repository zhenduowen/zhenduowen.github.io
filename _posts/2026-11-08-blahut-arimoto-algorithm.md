---
title: Introduction to the Blahut–Arimoto Algorithm
description: Computing the rate–distortion function by alternating between soft reconstruction and marginal matching.
date: 2026-11-08
author: Zhenduo
categories: [Information Theory, Compression]
tags: [Information Theory, Rate Distortion, Blahut–Arimoto Algorithm]
published: false
---

The rate–distortion theorem tells us the minimum rate needed to reproduce a source to a prescribed accuracy. But even for a finite alphabet, the theorem leaves us with an optimization over conditional distributions. How do we actually find the optimizing distribution?

The **Blahut–Arimoto algorithm** answers this question through two simple operations: choose reconstructions using a tentative distribution, then replace that distribution by the frequencies the choices produce. The useful intuition is that a good reconstruction should be both **accurate for the current source symbol** and **reusable across different source symbols**. The algorithm balances these two requirements.

Raymond W. Yeung gives a detailed treatment in *Information Theory and Network Coding*, Chapter 9, especially Sections 9.1 and 9.2.2 [1](#ref-yeung). Here we focus on the intuition behind the rate–distortion algorithm and derive its updates. The algorithm can also be applied on computing channel capacity for finite alphabets.

Throughout, alphabets are finite, logarithms are base $2$, and information quantities are measured in bits.

## The optimization problem

Let $X\sim p$ be a memoryless source on $\mathcal X$, and let $\hat X$ take values in a fixed reconstruction alphabet $\widehat{\mathcal X}$. A nonnegative, finite distortion measure $d(x,\hat x)$ tells us how costly it is to reproduce $x$ as $\hat x$. We can discard source symbols of probability zero, so assume $p(x)>0$.

Our optimization variable is a conditional distribution, also called a *test channel*,

$$
W(\hat x\mid x)=P_{\hat X\mid X}(\hat x\mid x).
$$

It induces the reconstruction marginal

$$
q_W(\hat x)=\sum_x p(x)W(\hat x\mid x)
$$

and the average distortion

$$
\bar d(W)=\sum_{x,\hat x}p(x)W(\hat x\mid x)d(x,\hat x).
$$

**Definition (Rate–distortion function).** For a feasible distortion level $D$,

$$
\boxed{
R(D)=\min_{W:\,\bar d(W)\le D} I_p(W),
}
$$

where

$$
I_p(W)
=\sum_{x,\hat x}p(x)W(\hat x\mid x)
\log\frac{W(\hat x\mid x)}{q_W(\hat x)}.
$$

We use the convention that a term with zero numerator contributes zero. The rate–distortion theorem gives this minimum its operational meaning: it is the asymptotic number of bits per source symbol needed by long block codes. The test channel describes the desired joint statistics of source and reconstruction; computing it does not by itself construct such a code.

**Why should the reconstruction be randomized?** Always selecting the nearest reconstruction minimizes distortion, but it can reveal too much about $X$. At the other extreme, choosing $\hat X$ independently of $X$ gives zero mutual information, though usually with substantial distortion. The optimization searches between these extremes.

The expression

$$
I_p(W)=\sum_x p(x)D_{\mathrm{KL}}\bigl(W(\cdot\mid x)\Vert q_W\bigr)
$$

makes this tradeoff concrete. Low rate asks the rows $W(\cdot\mid x)$ to resemble a common distribution. Low distortion asks each row to favor reconstructions suited to its own $x$. These requirements generally pull in different directions.

## Replace the distortion constraint by a price

Instead of immediately prescribing $D$, fix a number $\beta\ge0$ and solve

$$
F(\beta)=\min_W L_\beta(W),
\qquad
L_\beta(W)=I_p(W)+\beta\bar d(W).
$$

Here $\beta$ is the price of distortion, measured in bits per unit of distortion. A large $\beta$ makes accuracy more valuable; a small $\beta$ makes it cheaper to sacrifice accuracy for a lower rate. The term $-\beta D$ in the constrained problem's Lagrangian is constant in $W$, so it does not affect this minimization.

Suppose $W_\beta$ minimizes this objective, and write

$$
D_\beta=\bar d(W_\beta),
\qquad
R_\beta=I_p(W_\beta).
$$

Then $R_\beta=R(D_\beta)$. Indeed, any test channel with distortion at most $D_\beta$ and rate strictly below $R_\beta$ would have a smaller value of $L_\beta$.

There is also a geometric interpretation. For every feasible $D$,

$$
R(D)\ge F(\beta)-\beta D,
$$

with equality at $D=D_\beta$. Thus the line $R=F(\beta)-\beta D$ supports the rate–distortion curve from below. At an interior differentiable point,

$$
R'(D_\beta)=-\beta.
$$

One run of the algorithm therefore computes a point associated with a chosen slope. It does not take an arbitrary target distortion and enforce it at every iteration. We will return to choosing $\beta$ later.

## The useful trick: give the marginal its own variable

The difficulty in $I_p(W)$ is that changing one row of $W$ also changes $q_W$, which appears in every row. The rows are coupled through their shared marginal.

Let us introduce a separate probability distribution $q$ on $\widehat{\mathcal X}$ and define

$$
J_\beta(W,q)
=\sum_x p(x)D_{\mathrm{KL}}\bigl(W(\cdot\mid x)\Vert q\bigr)
+\beta\bar d(W).
$$

For the moment, $q$ is only a guess for the marginal; it need not equal $q_W$.

**Proposition (The cost of a wrong marginal).**

$$
\boxed{
J_\beta(W,q)
=L_\beta(W)+D_{\mathrm{KL}}(q_W\Vert q).
}
$$

*Proof.* Split the logarithm into two parts:

$$
\begin{aligned}
\sum_{x,\hat x}p(x)W(\hat x\mid x)
\log\frac{W(\hat x\mid x)}{q(\hat x)}
&=\sum_{x,\hat x}p(x)W(\hat x\mid x)
\log\frac{W(\hat x\mid x)}{q_W(\hat x)}\\
&\quad+\sum_{\hat x}q_W(\hat x)
\log\frac{q_W(\hat x)}{q(\hat x)}\\
&=I_p(W)+D_{\mathrm{KL}}(q_W\Vert q).
\end{aligned}
$$

Adding the distortion term gives the identity. Initially we take $q$ strictly positive, so all expressions are well defined; the identity extends to the boundary with the usual KL conventions.

&nbsp;<span style="float: right;">■</span>

The extra variable has a precise meaning: **using a guessed marginal adds exactly a KL mismatch penalty**. For any fixed $W$, the best guess is $q=q_W$, and the penalty disappears. Consequently,

$$
F(\beta)=\min_W\min_q J_\beta(W,q).
$$

This looks like a larger problem, but each of its two parts is now easy. If $q$ is fixed, the rows of $W$ can be optimized separately. If $W$ is fixed, we simply compute its marginal.

## The two updates

### Fix the marginal and choose reconstructions

For a given source symbol $x$, we must choose a distribution $w(\hat x)$ minimizing

$$
D_{\mathrm{KL}}(w\Vert q)
+\beta\sum_{\hat x}w(\hat x)d(x,\hat x).
$$

Define

$$
Z_q(x)=\sum_{\hat x}q(\hat x)2^{-\beta d(x,\hat x)},
\qquad
w_q(\hat x\mid x)
=\frac{q(\hat x)2^{-\beta d(x,\hat x)}}{Z_q(x)}.
$$

Substituting this expression into the row objective gives

$$
D_{\mathrm{KL}}(w\Vert q)
+\beta\sum_{\hat x}w(\hat x)d(x,\hat x)
=D_{\mathrm{KL}}\bigl(w\Vert w_q(\cdot\mid x)\bigr)-\log Z_q(x).
$$

Since $Z_q(x)$ is fixed, nonnegativity of KL divergence identifies the minimizer immediately:

$$
\boxed{
W(\hat x\mid x)
=\frac{q(\hat x)2^{-\beta d(x,\hat x)}}
{\sum_{\hat x'}q(\hat x')2^{-\beta d(x,\hat x')}}.
}
$$

This is a *soft* reconstruction rule. Begin with the common baseline $q$, discount each reconstruction according to its distortion, and normalize. A reconstruction receives more weight when it is common under $q$, or when it represents the current $x$ accurately.

For two reconstructions $a$ and $b$,

$$
\frac{W(a\mid x)}{W(b\mid x)}
=\frac{q(a)}{q(b)}
\,2^{-\beta[d(x,a)-d(x,b)]}.
$$

This ratio is perhaps the most useful way to remember the update. If $a$ and $b$ have equal distortion, their relative weights remain those of $q$. If $a$ improves distortion by $\Delta$, its relative weight is multiplied by $2^{\beta\Delta}$. At $\beta=0$, every row equals $q$, so the reconstruction carries no information about $X$. As $\beta$ grows, the distortion preference becomes sharper.

### Fix the reconstruction rule and match the marginal

Once $W$ is fixed, our proposition says that the only $q$-dependent term is $D_{\mathrm{KL}}(q_W\Vert q)$. Hence the second update is

$$
\boxed{
q(\hat x)=\sum_xp(x)W(\hat x\mid x).
}
$$

We replace the guessed frequencies by the actual frequencies produced by the current reconstruction rule. Reconstructions used often receive more weight in the next round; those rarely used receive less.

The two updates seek consistency: the baseline used to choose reconstructions should agree with the marginal those choices produce. Each update also minimizes the same objective, which is what makes this consistency procedure useful for optimization.

## Why alternating the updates makes progress

Start with a strictly positive $q^{(0)}$, for example the uniform distribution. For $t=0,1,\ldots$, set

$$
\begin{aligned}
W^{(t+1)}(\hat x\mid x)
&=\frac{q^{(t)}(\hat x)2^{-\beta d(x,\hat x)}}
{\sum_{\hat x'}q^{(t)}(\hat x')2^{-\beta d(x,\hat x')}},\\
q^{(t+1)}(\hat x)
&=\sum_xp(x)W^{(t+1)}(\hat x\mid x).
\end{aligned}
$$

After each complete round, $q^{(t)}$ is the actual marginal of $W^{(t)}$. For $t\ge1$,

$$
\begin{aligned}
L_\beta(W^{(t+1)})
&=J_\beta(W^{(t+1)},q^{(t+1)})\\
&\le J_\beta(W^{(t+1)},q^{(t)})\\
&\le J_\beta(W^{(t)},q^{(t)})\\
&=L_\beta(W^{(t)}).
\end{aligned}
$$

The first inequality comes from matching the marginal; the second comes from optimizing the rows. Thus the penalized objective decreases monotonically. Neither rate nor distortion alone has to decrease at every iteration.

This also gives an upper-bound interpretation. At the current $W^{(t)}$, the function $J_\beta(W,q^{(t)})$ touches $L_\beta(W)$ and lies above it everywhere. Minimizing this simpler upper bound, then removing the marginal mismatch, cannot make the original objective worse.

Monotonicity alone does not prove convergence to the global optimum. For finite alphabets, finite distortion values, a fixed finite $\beta$, and a strictly positive initialization, the rate–distortion Blahut–Arimoto algorithm does converge in objective value to $F(\beta)$. A convergence proof needs more than the displayed descent inequalities. Yeung discusses the general convergence framework in Section 9.3 and proves the channel-capacity case; the analogous rate–distortion proof is omitted [1](#ref-yeung). The optimizing test channel need not be unique.

**Why insist on positive initialization?** If $q^{(0)}(\hat x)=0$, then every subsequent update assigns zero probability to that reconstruction. It can never re-enter the calculation, even if it is needed by the optimum. With positive initialization and finite distortions, probabilities stay positive in exact arithmetic at every finite iteration, although some may tend to zero in the limit.

## Comparison with classical convex optimization

**KKT conditions characterize the optimizer, but generally leave us with equations that still need to be solved numerically.** For fixed $p$, mutual information is convex in $W$, and average distortion is linear. Thus minimizing $L_\beta(W)$ over conditional distributions is a convex optimization problem. Blahut–Arimoto exploits the structure of this problem; general convex-optimization methods can also solve it.

### What do the KKT conditions give us?

Fix a finite $\beta\ge0$. At an optimizer $W^*$, write $q^*=q_{W^*}$. On its positive support, differentiating the objective and including a multiplier for each row-normalization constraint gives

$$
\log\frac{W^*(\hat x\mid x)}{q^*(\hat x)}
+\beta d(x,\hat x)+c_x=0,
$$

where $c_x$ is the row multiplier divided by $p(x)$. Solving for $W^*$ and normalizing the row yields

$$
\boxed{
W^*(\hat x\mid x)
=\frac{q^*(\hat x)2^{-\beta d(x,\hat x)}}
{\sum_{\hat x'}q^*(\hat x')2^{-\beta d(x,\hat x')}}.
}
$$

This is exactly the exponential form used in the first Blahut–Arimoto update. Yeung also derives that update using Lagrange multipliers [1](#ref-yeung).

The difficulty is that **$q^*$ is still unknown**. It must also satisfy

$$
q^*(\hat x)=\sum_xp(x)W^*(\hat x\mid x).
$$

These are coupled nonlinear equations. Knowing the form of the optimal conditional distribution does not determine its marginal. Additional KKT inequalities govern reconstruction symbols assigned zero probability. Symmetry sometimes makes the equations solvable analytically, but in general we still need a numerical method.

For a prescribed distortion $D$, the multiplier $\beta$ is also unknown, and complementary slackness requires

$$
\beta\ge0,\qquad
\bar d(W^*)\le D,\qquad
\beta\bigl(\bar d(W^*)-D\bigr)=0.
$$

When $D>D_{\min}$, a strictly feasible test channel exists, and Slater's condition gives the usual convex KKT characterization, with boundary points handled appropriately. At $D=D_{\min}$, a finite distortion multiplier need not exist. Here $D_{\min}=\sum_xp(x)\min_{\hat x}d(x,\hat x)$. For the general role of these conditions, see my earlier post on [KKT conditions]({% post_url 2026-08-03-KKT-conditions %}) and Boyd and Vandenberghe [2](#ref-boyd).

### A convex problem over the marginal alone

There is another useful consequence of the auxiliary-variable formulation. Minimize $J_\beta(W,q)$ over $W$ first. Our row calculation already gives the minimum as $-\log Z_q(x)$, so

$$
\boxed{
F(\beta)=\min_{q\in\Delta(\widehat{\mathcal X})}g_\beta(q),
\qquad
g_\beta(q)=-\sum_xp(x)\log Z_q(x),
}
$$

where $\Delta(\widehat{\mathcal X})$ is the probability simplex and

$$
Z_q(x)=\sum_{\hat x}q(\hat x)2^{-\beta d(x,\hat x)}.
$$

Each term is a negative logarithm of a positive affine function of $q$. Hence $g_\beta$ is convex. For finite distortion values and finite $\beta$, it is smooth throughout the simplex, including its boundary. Once a minimizing $q^*$ is found, the exponential formula recovers an optimal $W^*$ whose marginal is $q^*$.

### Other numerical methods

This gives several alternatives to Blahut–Arimoto:

- **Projected gradient or Frank–Wolfe methods** can minimize $g_\beta(q)$ over the simplex. They use the gradient to adjust the reconstruction marginal.
- **Interior-point methods** can solve the convex problem while enforcing its probability constraints. These methods are also useful when additional convex constraints are present.
- **Relative-entropy conic optimization** can handle the original constraint $\bar d(W)\le D$ directly, without an outer search over $\beta$.

For the last approach, write

$$
I_p(W)
=\frac{1}{\ln2}\sum_{x,\hat x}p(x)
\operatorname{rel\_entr}\bigl(W(\hat x\mid x),q_W(\hat x)\bigr),
$$

where $\operatorname{rel\_entr}(u,v)=u\ln(u/v)$ is jointly convex, with its usual extension to zero arguments. Since $q_W$ is affine in $W$, this is a convex objective with affine probability and distortion constraints. Modeling tools such as CVXPY provide this relative-entropy atom [3](#ref-cvxpy); the factor $1/\ln2$ converts its natural-logarithm convention to bits.

The appeal of Blahut–Arimoto is that both of its subproblems have explicit solutions. Every iteration only requires reweighting, normalization, and averaging, and the penalized objective decreases. A general convex solver offers more flexibility, while Blahut–Arimoto makes direct use of the information-theoretic structure.

## Computing a desired point on the curve

The procedure for one fixed $\beta$ is short:

```text
Choose q strictly positive on the reconstruction alphabet.
Repeat, with a maximum iteration limit:
    For each x:
        W(x_hat | x) <- q(x_hat) * 2^(-beta * d(x, x_hat))
        Normalize this row to sum to one.
    q_new(x_hat) <- sum_x p(x) * W(x_hat | x)
    D <- sum_{x, x_hat} p(x) * W(x_hat | x) * d(x, x_hat)
    R <- sum_{x, x_hat} p(x) * W(x_hat | x)
                         * log2(W(x_hat | x) / q_new(x_hat))
    Check convergence of R + beta * D and of q_new - q.
    q <- q_new
Return W, q, D, R, and whether the stopping criterion was met.
```

Use the **new marginal** to compute mutual information. Using the old $q$ in the logarithm instead adds the marginal mismatch penalty. Small changes between iterations are a practical stopping diagnostic, not a certified bound on the remaining optimization error.

To approximate the curve, run this procedure for several values of $\beta$. If a particular distortion is required, adjust $\beta$ in an outer search: increase it when distortion is too large, and decrease it when distortion is too small. Optimal distortion is nonincreasing in $\beta$; this follows by adding the two optimality inequalities for two choices of $\beta$. Bisection is useful when the selected distortion varies continuously and the target is bracketed.

There are a few boundary cases to keep in mind:

- The smallest feasible distortion is $D_{\min}=\sum_xp(x)\min_{\hat x}d(x,\hat x)$. Reaching it may require the limit $\beta\to\infty$.
- The zero-rate threshold is $D_0=\min_{\hat x}\sum_xp(x)d(x,\hat x)$. For $D\ge D_0$, a constant reconstruction suffices. At $\beta=0$, every independent reconstruction minimizes the objective, so an arbitrary initialization need not return the smallest zero-rate distortion $D_0$.
- A linear segment of $R(D)$ has one supporting slope but many distortion levels. A single run at that slope need not return every point on the segment; time-sharing between its endpoint operating points fills it in. At a corner, a range of slopes can select the same point.

For large $\beta$, implement the row normalization in the log domain, using log-sum-exp, to avoid numerical underflow. A full iteration costs $O(|\mathcal X|\,|\widehat{\mathcal X}|)$ arithmetic operations. In particular, do not round a small probability to zero merely because it looks negligible: the updates cannot revive a deleted reconstruction.

*Remark (Channel capacity).* Blahut–Arimoto methods also compute the capacity of a finite discrete memoryless channel, $C=\max_{P_X}I(X;Y)$. There the physical channel is fixed and the input distribution is optimized. In our rate–distortion problem, the source distribution is fixed and the test channel is optimized. Yeung treats the channel-capacity algorithm in Section 9.2.1 [1](#ref-yeung).

## References

<span id="ref-yeung"></span>

1. Raymond W. Yeung, *Information Theory and Network Coding*, Springer, 2008. Chapter 9, “The Blahut-Arimoto Algorithms,” pp. 211–228, especially Section 9.1, “Alternating Optimization,” and Section 9.2.2, “The Rate-Distortion Function,” pp. 219–222. [Author's book page](https://whyeungb.ie.cuhk.edu.hk/book/); [publisher's chapter](https://doi.org/10.1007/978-0-387-79234-7_9).

<span id="ref-boyd"></span>

2. Stephen Boyd and Lieven Vandenberghe, *Convex Optimization*, Cambridge University Press, 2004. Section 5.5.3, “KKT optimality conditions.” [Author-hosted book and supporting material](https://web.stanford.edu/~boyd/cvxbook/).

<span id="ref-cvxpy"></span>

3. CVXPY documentation, “Relative entropy: `rel_entr`.” [Definition and convexity of the atom](https://www.cvxpy.org/_modules/cvxpy/atoms/elementwise/rel_entr.html).
