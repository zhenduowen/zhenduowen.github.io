---
title: On Necessarity and Sufficiency of Karush-Kuhn-Tucker Conditions
description: A summary of the necessarity and sufficiency of Karush-Kuhn-Tucker(KKT) conditions. Credit to GPT 5.6
date: 2026-08-03
author: Zhenduo
categories: [Applied Mathematics, Optimization]
tags: [Optimization, KKT Conditions]
---

## When Are the KKT Conditions Necessary and Sufficient?

Consider the constrained optimization problem
$$
\begin{aligned}
\min_{x\in\mathbb R^n}\quad & f(x)\\
\text{subject to}\quad
& g_i(x)\le 0,\qquad i=1,\dots,m,\\
& h_j(x)=0,\qquad j=1,\dots,r,
\end{aligned}
$$
where $f$, $g_i$, and $h_j$ are continuously differentiable functions.

We first define the relevant concepts before stating the main results.

## 1. Basic definitions

A point $x$ is called feasible if
$$
g_i(x)\le 0,\qquad i=1,\dots,m,
$$
and
$$
h_j(x)=0,\qquad j=1,\dots,r.
$$

A feasible point $x^\star$ is a local minimizer if there exists $\delta>0$ such that
$$
f(x^\star)\le f(x)
$$
for every feasible $x$ satisfying
$$
\lVert x-x^\star\rVert<\delta.
$$

A feasible point $x^\star$ is a global minimizer if
$$
f(x^\star)\le f(x)
$$
for every feasible point $x$.

For a feasible point $x$, the active set is defined as
$$
\mathcal A(x)
\coloneqq
\left \lbrace 
i\in\{1,\dots,m\}:g_i(x)=0
\right \rbrace .
$$
Thus, an inequality constraint is active at $x$ when it holds with equality.

The Lagrangian is the function
$$
L(x,\lambda,\nu)
=
f(x)
+
\sum_{i=1}^m\lambda_i g_i(x)
+
\sum_{j=1}^r\nu_j h_j(x),
$$
where
$$
\lambda_i\ge 0
$$
are the multipliers associated with the inequality constraints, and
$$
\nu_j\in\mathbb R
$$
are the multipliers associated with the equality constraints.

## 2. The KKT conditions

A feasible point $x^\star$, together with multipliers $\lambda^\star$ and $\nu^\star$, satisfies the Karush–Kuhn–Tucker conditions if the following four conditions hold:

#### Primal feasibility

The point $x^\star$ satisfies the original constraints:
$$
g_i(x^\star)\le 0,
\qquad i=1,\dots,m,
$$
and
$$
h_j(x^\star)=0,
\qquad j=1,\dots,r.
$$

#### Dual feasibility

The inequality multipliers are nonnegative:
$$
\lambda_i^\star\ge 0,
\qquad i=1,\dots,m.
$$

#### Complementary slackness

For every inequality constraint,
$$
\lambda_i^\star g_i(x^\star)=0,
\qquad i=1,\dots,m.
$$

Therefore, if $g_i(x^\star)<0$, then necessarily
$$
\lambda_i^\star=0.
$$

#### Stationarity

The gradient of the Lagrangian with respect to $x$ vanishes:
$$
\nabla f(x^\star)
+
\sum_{i=1}^m
\lambda_i^\star\nabla g_i(x^\star)
+
\sum_{j=1}^r
\nu_j^\star\nabla h_j(x^\star)
=
0.
$$

The KKT conditions do not automatically hold at every constrained optimizer. Additional assumptions, called constraint qualifications, are needed.

## 3. Constraint qualifications

A constraint qualification is a regularity condition on the constraints near a feasible point. Its purpose is to exclude degenerate representations of the feasible set.

### 3.1 Linear independence constraint qualification

The linear independence constraint qualification, abbreviated as **LICQ**, holds at a feasible point $x^\star$ if the vectors
$$
\left \lbrace
\nabla g_i(x^\star):i\in\mathcal A(x^\star)
\right \rbrace 
\cup
\left \lbrace
\nabla h_j(x^\star):j=1,\dots,r
\right \rbrace
$$
are linearly independent.

Only the gradients of the active inequality constraints are included. An inactive inequality does not restrict infinitesimal movements around $x^\star$.

### 3.2 Mangasarian–Fromovitz constraint qualification

The Mangasarian–Fromovitz constraint qualification, abbreviated as **MFCQ**, holds at $x^\star$ if:

1. the equality-constraint gradients
$$
   \nabla h_1(x^\star),\dots,\nabla h_r(x^\star)
$$
   are linearly independent; and

2. there exists a direction $d\in\mathbb R^n$ such that
$$
   \nabla h_j(x^\star)^{\mathsf T}d=0,
   \qquad j=1,\dots,r,
$$
   and
$$
   \nabla g_i(x^\star)^{\mathsf T}d<0,
   \qquad i\in\mathcal A(x^\star).
$$

The direction $d$ preserves the equality constraints to first order and moves strictly inside every active inequality constraint.

LICQ implies MFCQ. Indeed, under LICQ, the linear system
$$
\nabla h_j(x^\star)^{\mathsf T}d=0,
\qquad
\nabla g_i(x^\star)^{\mathsf T}d=-1
$$
for all active $i$ has a solution because the corresponding constraint gradients are linearly independent.

MFCQ is therefore weaker than LICQ.

## 4. Necessity of the KKT conditions

### Theorem 1: KKT necessity under LICQ

Suppose that $x^\star$ is a local minimizer and that LICQ holds at $x^\star$. Then there exist multipliers
$$
\lambda_i^\star\ge 0,
\qquad i=1,\dots,m,
$$
and
$$
\nu_j^\star\in\mathbb R,
\qquad j=1,\dots,r,
$$
such that the KKT conditions hold.

### Explanation of the proof

At a local minimizer, there cannot be a feasible direction that decreases the objective.

To first order, a direction $d$ is compatible with the active constraints if
$$
\nabla h_j(x^\star)^{\mathsf T}d=0
$$
for every equality constraint and
$$
\nabla g_i(x^\star)^{\mathsf T}d\le 0
$$
for every active inequality constraint.

Under LICQ, the tangent cone to the feasible set coincides with the linearized cone determined by these first-order constraints. Therefore, local optimality implies
$$
\nabla f(x^\star)^{\mathsf T}d\ge 0
$$
for every direction $d$ satisfying
$$
\nabla h_j(x^\star)^{\mathsf T}d=0,
\qquad
\nabla g_i(x^\star)^{\mathsf T}d\le 0.
$$

A standard linear-algebraic alternative theorem, usually called Farkas’ lemma, then implies that there exist coefficients
$$
\lambda_i^\star\ge 0
$$
for the active inequalities and unrestricted coefficients $\nu_j^\star$ such that
$$
\nabla f(x^\star)
+
\sum_{i\in\mathcal A(x^\star)}
\lambda_i^\star\nabla g_i(x^\star)
+
\sum_{j=1}^r
\nu_j^\star\nabla h_j(x^\star)
=
0.
$$

Set
$$
\lambda_i^\star=0
$$
for every inactive inequality. Stationarity and dual feasibility then hold.

If $i$ is active, then $g_i(x^\star)=0$, so
$$
\lambda_i^\star g_i(x^\star)=0.
$$
If $i$ is inactive, then $\lambda_i^\star=0$, so the same equality holds. Thus complementary slackness also holds.

A rigorous proof of this tangent-cone characterization uses the implicit function theorem. A complete proof can be found in Chapter 12 of Nocedal and Wright, *Numerical Optimization*.

### Example 1: LICQ holds and KKT is necessary

Consider
$$
\begin{aligned}
\min_x\quad &(x-2)^2\\
\text{subject to}\quad &x-1\le 0.
\end{aligned}
$$

The feasible set is
$$
x\le 1.
$$
The constrained minimizer is
$$
x^\star=1.
$$

The constraint is active because
$$
g(x^\star)=x^\star-1=0.
$$
Its gradient is
$$
g'(x^\star)=1\neq 0,
$$
so LICQ holds.

The stationarity condition is
$$
2(x^\star-2)+\lambda^\star=0.
$$
Substituting $x^\star=1$ gives
$$
-2+\lambda^\star=0,
$$
and hence
$$
\lambda^\star=2.
$$

We also have
$$
\lambda^\star\ge 0,
\qquad
\lambda^\star g(x^\star)=2\cdot 0=0.
$$
Thus all KKT conditions hold.

### Counterexample 1: LICQ fails and KKT necessity fails

Consider
$$
\begin{aligned}
\min_x\quad &x\\
\text{subject to}\quad &x^2\le 0.
\end{aligned}
$$

The constraint implies
$$
x=0.
$$
Therefore, the unique feasible point
$$
x^\star=0
$$
is also the global minimizer.

However,
$$
g'(x^\star)=2x^\star=0.
$$
The active constraint gradient is zero, so LICQ fails.

The stationarity condition would require
$$
1+\lambda^\star(2x^\star)=0.
$$
At $x^\star=0$, this becomes
$$
1=0,
$$
which is impossible.

Thus, $x^\star$ is an optimizer, but no KKT multiplier exists.

The failure occurs because the constraint $x^2\le 0$ gives a degenerate description of the feasible set. The constraint excludes all nonzero $x$, but its gradient vanishes at the only feasible point.

### Theorem 2: KKT necessity under MFCQ

Suppose that $x^\star$ is a local minimizer and MFCQ holds at $x^\star$. Then the KKT conditions hold for some multipliers.

This theorem is more general than Theorem 1 because MFCQ is weaker than LICQ.

The proof again uses the tangent cone and Farkas’ lemma. MFCQ also implies that the tangent cone coincides with the linearized cone. A complete proof can also be found in Nocedal and Wright.

### Example 2: MFCQ holds while LICQ fails

Consider
$$
\begin{aligned}
\min_x\quad &-x\\
\text{subject to}\quad
&x\le 0,\\
&2x\le 0.
\end{aligned}
$$

The feasible set is simply
$$
x\le 0,
$$
and the minimizer is
$$
x^\star=0,
$$
because
$$
-x\ge 0
$$
for every feasible $x$.

Both constraints are active at $x^\star=0$. Their gradients are
$$
1
\qquad\text{and}\qquad
2.
$$
These gradients are linearly dependent, so LICQ fails.

However, MFCQ holds. Taking
$$
d=-1
$$
gives
$$
1\cdot d=-1<0
$$
and
$$
2\cdot d=-2<0.
$$

The stationarity condition is
$$
-1+\lambda_1^\star+2\lambda_2^\star=0.
$$
For example, one may take
$$
\lambda_1^\star=1,
\qquad
\lambda_2^\star=0.
$$

Thus the KKT conditions hold even though LICQ fails. This illustrates why LICQ is sufficient for KKT necessity but is not necessary.

## 5. Convexity and KKT sufficiency

We next define convexity.

A set $C\subseteq\mathbb R^n$ is convex if, for every $x,y\in C$ and every $t\in[0,1]$,
$$
tx+(1-t)y\in C.
$$

A differentiable function $f$ is convex on a convex set $C$ if
$$
f(tx+(1-t)y)
\le
tf(x)+(1-t)f(y)
$$
for every $x,y\in C$ and $t\in[0,1]$.

An equivalent first-order characterization is
$$
f(y)
\ge
f(x)+\nabla f(x)^{\mathsf T}(y-x).
$$

A function $h$ is affine if it has the form
$$
h(x)=a^{\mathsf T}x+b.
$$

The optimization problem is called a convex optimization problem if:

1. the objective $f$ is convex;
2. every inequality function $g_i$ is convex; and
3. every equality function $h_j$ is affine.

Under these assumptions, the feasible set is convex.

### Theorem 3: KKT conditions are sufficient in a convex problem

Suppose that $f$ and $g_i$ are convex and $h_j$ are affine. If a feasible point $x^\star$ satisfies the KKT conditions for some multipliers, then $x^\star$ is a global minimizer.

### Proof

Let $x$ be any feasible point.

Since $f$ is convex,
$$
f(x)
\ge
f(x^\star)
+
\nabla f(x^\star)^{\mathsf T}(x-x^\star).
$$

By stationarity,
$$
\nabla f(x^\star)
=
-
\sum_{i=1}^m
\lambda_i^\star\nabla g_i(x^\star)
-
\sum_{j=1}^r
\nu_j^\star\nabla h_j(x^\star).
$$

Therefore,
$$
\begin{aligned}
\nabla f(x^\star)^{\mathsf T}(x-x^\star)
={}&
-\sum_{i=1}^m
\lambda_i^\star
\nabla g_i(x^\star)^{\mathsf T}(x-x^\star)\\
&-
\sum_{j=1}^r
\nu_j^\star
\nabla h_j(x^\star)^{\mathsf T}(x-x^\star).
\end{aligned}
$$

Because $h_j$ is affine,
$$
h_j(x)-h_j(x^\star)
=
\nabla h_j(x^\star)^{\mathsf T}(x-x^\star).
$$
Both $x$ and $x^\star$ satisfy the equality constraints, so
$$
\nabla h_j(x^\star)^{\mathsf T}(x-x^\star)=0.
$$

Because $g_i$ is convex,
$$
g_i(x)
\ge
g_i(x^\star)
+
\nabla g_i(x^\star)^{\mathsf T}(x-x^\star).
$$
Consequently,
$$
\nabla g_i(x^\star)^{\mathsf T}(x-x^\star)
\le
g_i(x)-g_i(x^\star).
$$

Since $\lambda_i^\star\ge 0$,
$$
-\lambda_i^\star
\nabla g_i(x^\star)^{\mathsf T}(x-x^\star)
\ge
-\lambda_i^\star g_i(x)
+
\lambda_i^\star g_i(x^\star).
$$

Complementary slackness gives
$$
\lambda_i^\star g_i(x^\star)=0.
$$
Feasibility of $x$ gives
$$
g_i(x)\le 0.
$$
Therefore,
$$
-\lambda_i^\star g_i(x)\ge 0.
$$

It follows that
$$
\nabla f(x^\star)^{\mathsf T}(x-x^\star)\ge 0.
$$
Hence
$$
f(x)\ge f(x^\star).
$$

Because $x$ was an arbitrary feasible point, $x^\star$ is a global minimizer.

### Example 3: A KKT point is globally optimal in a convex problem

Consider
$$
\begin{aligned}
\min_x\quad &x^2\\
\text{subject to}\quad &1-x\le 0.
\end{aligned}
$$

The constraint is equivalent to
$$
x\ge 1.
$$

Both the objective
$$
f(x)=x^2
$$
and the constraint function
$$
g(x)=1-x
$$
are convex.

The optimizer is
$$
x^\star=1.
$$

The stationarity condition is
$$
2x^\star-\lambda^\star=0,
$$
so
$$
\lambda^\star=2.
$$

The remaining KKT conditions hold:
$$
1-x^\star=0,
\qquad
\lambda^\star=2\ge 0,
\qquad
\lambda^\star(1-x^\star)=0.
$$

The theorem guarantees that $x^\star=1$ is globally optimal.

### Counterexample 2: Without convexity, a KKT point need not be a minimizer

Consider
$$
\begin{aligned}
\min_x\quad &-x^2\\
\text{subject to}\quad
&x-1\le 0,\\
&-x-1\le 0.
\end{aligned}
$$

The feasible set is
$$
-1\le x\le 1.
$$

At
$$
x^\star=0,
$$
both constraints are inactive:
$$
x^\star-1=-1<0,
\qquad
-x^\star-1=-1<0.
$$
Complementary slackness therefore allows
$$
\lambda_1^\star=\lambda_2^\star=0.
$$

The derivative of the objective is
$$
f'(x)=-2x,
$$
so
$$
f'(0)=0.
$$
Thus $x^\star=0$ satisfies all KKT conditions.

Nevertheless,
$$
f(0)=0,
\qquad
f(1)=-1.
$$
Therefore, $x^\star=0$ is not a minimizer. It is actually a local maximum.

The failure occurs because the objective
$$
-x^2
$$
is concave rather than convex.

## 6. Slater’s condition

Slater’s condition applies to convex optimization problems.

Suppose that $f$ and $g_i$ are convex and $h_j$ are affine. Slater’s condition holds if there exists a point $\bar x$ such that
$$
g_i(\bar x)<0,
\qquad i=1,\dots,m,
$$
and
$$
h_j(\bar x)=0,
\qquad j=1,\dots,r.
$$

Such a point is called a strictly feasible point.

Slater’s condition concerns the existence of at least one point that lies strictly inside all inequality constraints while satisfying all equality constraints.

Its primary role is to guarantee that an optimizer has KKT multipliers.

### Theorem 4: KKT conditions are necessary and sufficient under convexity and Slater’s condition

Suppose that:

1. $f$ and $g_i$ are convex;
2. $h_j$ are affine;
3. Slater’s condition holds; and
4. the optimal value is finite and attained.

Then a feasible point $x^\star$ is globally optimal if and only if there exist multipliers $\lambda^\star,\nu^\star$ such that the KKT conditions hold.

### Proof of sufficiency

The implication
$$
\text{KKT conditions}
\quad\Longrightarrow\quad
\text{global optimality}
$$
is exactly Theorem 3 and does not require Slater’s condition.

### Explanation of necessity

The implication
$$
\text{global optimality}
\quad\Longrightarrow\quad
\text{KKT conditions}
$$
uses convex duality.

For multipliers $\lambda\ge 0$ and $\nu\in\mathbb R^r$, define the dual function
$$
q(\lambda,\nu)
\coloneqq
\inf_x L(x,\lambda,\nu).
$$

The dual problem is
$$
\sup_{\lambda\ge 0,\nu}q(\lambda,\nu).
$$

Weak duality always gives
$$
q(\lambda,\nu)\le f(x)
$$
for every feasible $x$.

Strong duality means that the optimal value of the dual problem equals the optimal value of the primal problem.

For finite-dimensional convex problems of the form considered here, Slater’s condition guarantees strong duality and the existence of optimal dual multipliers. Let $\lambda^\star,\nu^\star$ be optimal dual multipliers.

Let $x^\star$ be primal optimal. Since $x^\star$ is feasible and $\lambda^\star\ge 0$,
$$
L(x^\star,\lambda^\star,\nu^\star)
=
f(x^\star)
+
\sum_{i=1}^m\lambda_i^\star g_i(x^\star)
\le
f(x^\star).
$$
On the other hand, by the definition of the dual function,
$$
q(\lambda^\star,\nu^\star)
\le
L(x^\star,\lambda^\star,\nu^\star).
$$
Strong duality gives
$$
q(\lambda^\star,\nu^\star)=f(x^\star).
$$
Combining these relations yields
$$
q(\lambda^\star,\nu^\star)
=
L(x^\star,\lambda^\star,\nu^\star)
=
f(x^\star).
$$

The first equality shows that $x^\star$ minimizes
$$
L(x,\lambda^\star,\nu^\star)
$$
with respect to $x$. Differentiability therefore gives
$$
\nabla_xL(x^\star,\lambda^\star,\nu^\star)=0,
$$
which is stationarity.

The second equality gives
$$
\sum_{i=1}^m
\lambda_i^\star g_i(x^\star)=0.
$$
Each term is nonpositive because
$$
\lambda_i^\star\ge 0
\qquad\text{and}\qquad
g_i(x^\star)\le 0.
$$
Their sum can equal zero only if
$$
\lambda_i^\star g_i(x^\star)=0
$$
for every $i$. This is complementary slackness.

Thus all KKT conditions hold.

The proof that Slater’s condition implies strong duality uses a separating-hyperplane theorem. A complete proof appears in Sections 5.2–5.5 of Boyd and Vandenberghe, *Convex Optimization*.

### Example 4: Convexity and Slater’s condition both hold

Again consider
$$
\begin{aligned}
\min_x\quad &x^2\\
\text{subject to}\quad &1-x\le 0.
\end{aligned}
$$

The point
$$
\bar x=2
$$
is strictly feasible because
$$
1-\bar x=-1<0.
$$
Thus Slater’s condition holds.

The unique optimizer is
$$
x^\star=1,
$$
and the multiplier is
$$
\lambda^\star=2.
$$

Consequently, optimality is equivalent to the KKT conditions in this problem.

### Counterexample 3: Slater’s condition fails and KKT necessity fails

Consider
$$
\begin{aligned}
\min_x\quad &x\\
\text{subject to}\quad &x^2\le 0.
\end{aligned}
$$

This is a convex problem because
$$
f(x)=x
$$
is affine and
$$
g(x)=x^2
$$
is convex.

However, Slater’s condition fails. There is no $x$ satisfying
$$
x^2<0.
$$

The unique feasible point and optimizer is
$$
x^\star=0,
$$
but, as previously shown, stationarity would require
$$
1+\lambda^\star(2x^\star)=1=0.
$$
Therefore, no KKT multiplier exists.

This shows that convexity alone does not guarantee that KKT conditions are necessary. A constraint qualification such as Slater’s condition is required.

Slater’s condition is sufficient, but it is not always necessary. Some convex problems that fail Slater’s condition may still possess valid KKT multipliers.

## 7. Strict convexity and uniqueness

A function $f$ is strictly convex if, for every distinct $x,y$ and every $t\in(0,1)$,
$$
f(tx+(1-t)y)
<
tf(x)+(1-t)f(y).
$$

### Theorem 5: Strict convexity implies uniqueness

Suppose that the feasible set is convex and $f$ is strictly convex on the feasible set. Then there is at most one global minimizer.

### Proof

Suppose, for contradiction, that $x_1\neq x_2$ are both global minimizers.

Because the feasible set is convex,
$$
\frac{x_1+x_2}{2}
$$
is feasible.

Strict convexity gives
$$
f\left(\frac{x_1+x_2}{2}\right)
<
\frac12f(x_1)+\frac12f(x_2).
$$

Since $x_1$ and $x_2$ have the same optimal value $f^\star$,
$$
f\left(\frac{x_1+x_2}{2}\right)<f^\star,
$$
contradicting global optimality.

Therefore, the optimizer is unique.

The associated KKT multipliers need not be unique, particularly when some active-constraint gradients are linearly dependent.

### Counterexample 4: Without strict convexity, the optimizer need not be unique

Consider
$$
\begin{aligned}
\min_x\quad &0\\
\text{subject to}\quad &-1\le x\le 1.
\end{aligned}
$$

The objective is convex but not strictly convex. Every feasible point is globally optimal, so the optimizer is not unique.

## 8. Nonconvex problems

In a nonconvex problem, KKT conditions are generally only first-order necessary conditions, assuming a suitable constraint qualification.

A KKT point may be:

* a local minimum;
* a local maximum;
* a saddle point;
* or a stationary point with more complicated behavior.

KKT conditions by themselves do not establish global optimality in a nonconvex problem.

Second-order conditions may sometimes establish local optimality. Suppose the functions are twice continuously differentiable. The Hessian of the Lagrangian is
$$
\nabla_{xx}^2L(x^\star,\lambda^\star,\nu^\star).
$$

A standard second-order sufficient condition requires
$$
d^{\mathsf T}
\nabla_{xx}^2L(x^\star,\lambda^\star,\nu^\star)d
>
0
$$
for every nonzero feasible critical direction $d$.

The precise definition of a critical direction must distinguish active constraints having positive multipliers from those having zero multipliers. The complete result is given in Chapter 12 of Nocedal and Wright.

For an unconstrained problem, the condition reduces to
$$
\nabla f(x^\star)=0
$$
and
$$
d^{\mathsf T}\nabla^2f(x^\star)d>0
$$
for every nonzero $d$. Equivalently, $\nabla^2f(x^\star)$ is positive definite.

### Example 5: Second-order condition confirms a local minimum

Consider
$$
f(x)=x^2.
$$
At $x^\star=0$,
$$
f'(0)=0
$$
and
$$
f''(0)=2>0.
$$
Therefore, $x^\star=0$ is a strict local minimum.

### Counterexample 5: First-order stationarity is insufficient

Consider
$$
f(x)=-x^2.
$$
At $x^\star=0$,
$$
f'(0)=0,
$$
but
$$
f''(0)=-2<0.
$$
Thus $x^\star=0$ is a local maximum rather than a local minimum.

## 9. Optimization over probability distributions

Consider an optimization over a finite-alphabet probability distribution
$$
p=(p_1,\dots,p_k).
$$

The probability-simplex constraints are
$$
p_i\ge 0,
\qquad i=1,\dots,k,
$$
and
$$
\sum_{i=1}^k p_i=1.
$$

These constraints are affine. Therefore, the probability simplex is convex.

Additional marginal constraints, such as
$$
\sum_y p(x,y)=p_X(x),
$$
are also affine.

After eliminating any coordinates that are structurally forced to zero, if there exists a feasible distribution satisfying
$$
p_i>0
$$
for every remaining coordinate, then Slater’s condition holds relative to the affine equality constraints.

The phrase “relative to the affine equality constraints” is important. The simplex lies in the affine hyperplane
$$
\sum_i p_i=1,
$$
and therefore has empty interior in the full space $\mathbb R^k$. Its relevant interior is the interior measured within this affine hyperplane.

### KL-divergence objectives

For fixed distributions $Q_1$ and $Q_2$, suppose that all relevant probabilities are positive. Then
$$
\begin{aligned}
D(P\Vert Q_1)-D(P\Vert Q_2)
&=
\sum_x P(x)\log\frac{P(x)}{Q_1(x)}
-
\sum_x P(x)\log\frac{P(x)}{Q_2(x)}\\
&=
\sum_x P(x)\log\frac{Q_2(x)}{Q_1(x)}.
\end{aligned}
$$

The terms involving $\log P(x)$ cancel. Therefore,
$$
D(P\Vert Q_1)-D(P\Vert Q_2)
$$
is affine in $P$ when $Q_1$ and $Q_2$ are fixed.

Consequently, minimizing this difference over a convex feasible set is a convex optimization problem. Maximizing it is also a convex optimization problem after multiplying the objective by $-1$, because an affine function is both convex and concave.

However, if $Q_1$ or $Q_2$ depends on $P$, the cancellation does not generally produce an affine objective. The resulting problem may be nonconvex, and KKT conditions may then characterize only stationary points.

### Boundary issues

KL divergence is defined by
$$
D(P\Vert Q)
=
\sum_x P(x)\log\frac{P(x)}{Q(x)}.
$$

If
$$
P(x)>0
\qquad\text{and}\qquad
Q(x)=0
$$
for some $x$, then
$$
D(P\Vert Q)=+\infty.
$$

At boundary points where some probabilities vanish, ordinary derivatives may also fail to exist or may diverge.

There are two standard approaches:

1. restrict the optimization to the common support and work in its relative interior; or

2. treat KL divergence as an extended-valued convex function and use subgradients instead of ordinary gradients.

Thus, before applying differentiable KKT conditions to a probability-distribution problem, one should verify that the optimizer lies in a region where all logarithms and derivatives are well defined.

## 10. Summary

For a differentiable constrained minimization problem:

$$
\boxed{
\text{Local optimum}
+
\text{LICQ or MFCQ}
\Longrightarrow
\text{KKT conditions are necessary}.
}
$$

For a convex optimization problem:

$$
\boxed{
\text{KKT conditions}
\Longrightarrow
\text{global optimality}.
}
$$

For a convex problem satisfying Slater’s condition:

$$
\boxed{
x^\star\text{ is globally optimal}
\iff
x^\star\text{ satisfies the KKT conditions for some multipliers}.
}
$$

Thus, convexity and constraint qualifications play different roles:

* a suitable constraint qualification at a local minimizer makes the KKT conditions necessary;
* convexity makes the KKT conditions sufficient;
* convexity together with Slater’s condition makes the KKT conditions both necessary and sufficient.

In a nonconvex problem, KKT conditions are generally only necessary first-order conditions when a suitable constraint qualification holds; by themselves, they do not distinguish a minimum from a maximum or a saddle point.
