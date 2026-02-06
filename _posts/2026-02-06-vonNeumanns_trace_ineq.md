---
title: Von Neumann’s trace inequality and Ky Fan dominance
date: 2026-02-06
author: Zhenduo
categories: [Applied Mathematics, Linear Algebra]
tags: [Linera Algebra, Inequalities]
---

Singular values are the “energy levels” of a matrix: they’re basis-independent, nonnegative, and they control most matrix norms. Two classic results—**von Neumann’s trace inequality** and **Ky Fan dominance**—say that when you multiply matrices, the singular values of the product can’t “line up” in a way that beats pairing the largest singular values with the largest.

### Notation
For a matrix $$X\in\mathbb C^{m\times n}$$, let
$$
\sigma_1(X)\ge \sigma_2(X)\ge \cdots \ge \sigma_p(X)\ge 0, p=\min(m,n)
$$
be its singular values (sorted decreasing). Let the **Ky Fan $$k$$-norm** be
$$
\|X\|_{(k)} := \sum_{i=1}^k \sigma_i(X),
$$
and let the **nuclear norm** be $$\|X\|_*=\|X\|_{(p)}$$.

---

## 1) Formal statements

### Theorem 1 (von Neumann’s trace inequality)
Let $$A,B\in\mathbb C^{m\times n}$$. Then

$$
\bigl|\operatorname{tr}(A^*B)\bigr|\ \le\ \sum_{i=1}^{p} \sigma_i(A)\,\sigma_i(B),
p=\min(m,n).
$$

More generally, for any unitary $$U\in\mathbb C^{m\times m}$$ and $$V\in\mathbb C^{n\times n}$$,

$$
\Re[\operatorname{tr}(U^*AVB^*)] \le \sum_{i=1}^{p}\sigma_i(A)\sigma_i(B),
$$

and the absolute-value version follows.

**When is equality possible?**  
Equality holds when the singular vector bases of $$A$$ and $$B$$ are *aligned*: if
$$
A=U\Sigma_A V^*, B=U\Sigma_B V^*
$$
with the same $$U,V$$ and diagonal $$\Sigma_A,\Sigma_B$$ (up to phases/signs), then
$$
\operatorname{tr}(A^*B)=\sum_{i=1}^{p} \sigma_i(A)\sigma_i(B).
$$

---

### Theorem 2 (Ky Fan dominance / singular-value majorization for products)
Let $$A,B\in\mathbb C^{m\times n}$$. For every $$k=1,2,\dots,p$$,

$$
\sum_{i=1}^{k}\sigma_i(A^*B)\ \le\ \sum_{i=1}^{k}\sigma_i(A)\,\sigma_i(B),
p=\min(m,n).
$$

Here $$\sigma_i(A^*B)$$ are the singular values of the $$n\times n$$ matrix $$A^*B$$, sorted decreasing; note only the first $$p$$ can be nonzero.

This is often presented as a **weak majorization** statement:
$$
\bigl(\sigma_1(A^*B),\dots,\sigma_p(A^*B)\bigr)\ \prec_w\ \bigl(\sigma_1(A)\sigma_1(B),\dots,\sigma_p(A)\sigma_p(B)\bigr),
$$
meaning partial sums of the left are bounded by partial sums of the right.

---

## 2) Intuition: “Best alignment can’t beat sorted pairing”

### A) Trace inequality intuition (rank-1 “alignment” picture)
If $$A$$ and $$B$$ were both rank-1,
$$
A=\sigma_1(A)\,u v^*, B=\sigma_1(B)\,x y^*,
$$
then
$$
\operatorname{tr}(A^*B)=\sigma_1(A)\sigma_1(B)\,(u^*x)\,(y^*v).
$$
Because $$|u^*x|\le 1$$ and $$|y^*v|\le 1$$, the trace can’t exceed $$\sigma_1(A)\sigma_1(B)$$.  

For higher rank, think of $$A$$ and $$B$$ as sums of rank-1 SVD components. The trace is trying to “pair” components. The maximum happens when the **largest** components pair with each other, the second-largest pair, etc.—hence $$\sum_i \sigma_i(A)\sigma_i(B)$$.

### B) Ky Fan dominance intuition (variational characterization)
A key identity is that the Ky Fan $$k$$-norm is the best achievable “trace” against a rank-$$k$$ isometry:
$$
\|X\|_{(k)}=\max_{\substack{U\in\mathbb C^{m\times k},\ U^*U=I\\
V\in\mathbb C^{n\times k},\ V^*V=I}}\ \Re\,\operatorname{tr}(U^* X V).
$$
So $$\sum_{i=1}^k \sigma_i(A^*B)$$ is the largest possible trace you can extract from $$A^*B$$ using $$k$$-dimensional “test subspaces.”

Now apply von Neumann’s trace inequality to those compressed pieces:
$$
\Re\,\operatorname{tr}(U^*A^*B V)=\Re\,\operatorname{tr}\bigl((AU)^*(BV)\bigr)
\ \le\ \sum_{i=1}^k \sigma_i(AU)\,\sigma_i(BV),
$$
and use $$\sigma_i(AU)\le \sigma_i(A)$$ and $$\sigma_i(BV)\le \sigma_i(B)$$. Maximizing over $$U,V$$ yields the Ky Fan bound.

The “best” $$k$$-dimensional correlation between $$A$$ and $$B$$ cannot exceed what you’d get by pairing their top $$k$$ singular values.

## Proofs: von Neumann’s trace inequality and Ky Fan dominance

This section gives blog-friendly proofs. Throughout, singular values are sorted in decreasing order.


## Notation

For $$X\in\mathbb C^{m\times n}$$, let $$\sigma_1(X)\ge \cdots \ge \sigma_p(X)\ge 0$$ with $$p=\min(m,n)$$.  
Define the Ky Fan $$k$$-norm and nuclear norm:

$$
\|X\|_{(k)}:=\sum_{i=1}^k \sigma_i(X),\qquad \|X\|_*:=\|X\|_{(p)}=\sum_{i=1}^p \sigma_i(X).
$$

---

## Preliminaries (two variational facts)

### Lemma 1 (nuclear norm duality)
For any $$X\in\mathbb C^{m\times n}$$,

$$
\|X\|_*=\max_{\|W\|_2\le 1}\ \Re\,\operatorname{tr}(W^*X).
$$

Moreover, if $$X=U\Sigma V^*$$ is an SVD, then an optimizer is $$W=UV^*$$ (with appropriate padding if $$m\ne n$$).

**Proof.** Let $$X=U\Sigma V^*$$. For any $$W$$ with $$\|W\|_2\le 1$$,

$$
\Re\,\operatorname{tr}(W^*X)
=\Re\,\operatorname{tr}(V^*W^*U\,\Sigma)
=\Re\,\operatorname{tr}(Z\Sigma),
$$

where $$Z:=V^*W^*U$$ satisfies $$\|Z\|_2\le 1$$. Since $$\Sigma$$ is diagonal with nonnegative entries,
$$
\Re\,\operatorname{tr}(Z\Sigma)\le \sum_{i=1}^p \Sigma_{ii}=\sum_{i=1}^p \sigma_i(X)=\|X\|_*.
$$
Equality is achieved by taking $$Z=I$$, i.e. $$W=UV^*$$. □


### Lemma 2 (Ky Fan $$k$$-norm variational characterization)
For any $$X\in\mathbb C^{m\times n}$$ and $$1\le k\le p=\min(m,n)$$,
$$
\|X\|_{(k)}
=\max_{\substack{P\in\mathbb C^{m\times k},\ P^*P=I\\ Q\in\mathbb C^{n\times k},\ Q^*Q=I}}
\Re\,\operatorname{tr}(P^*XQ).
$$

**Proof sketch.** Let $$X=U\Sigma V^*$$. Choosing $$P=U_{(:,1:k)}$$ and $$Q=V_{(:,1:k)}$$ gives
$$
\Re\,\operatorname{tr}(P^*XQ)=\sum_{i=1}^k \sigma_i(X).
$$
For arbitrary semi-unitary $$P,Q$$, reduce to $$\Re\,\operatorname{tr}(P'^*\Sigma Q')$$ and bound by the sum of the top $$k$$ diagonal entries of $$\Sigma$$. □

---

## Theorem 1 (von Neumann’s trace inequality)

### Statement
For $$A,B\in\mathbb C^{m\times n}$$ with $$p=\min(m,n)$$,
$$
\bigl|\operatorname{tr}(A^*B)\bigr|\ \le\ \sum_{i=1}^{p}\sigma_i(A)\sigma_i(B).
$$

### Proof
Take SVDs $$A=U_A\Sigma_A V_A^*$$ and $$B=U_B\Sigma_B V_B^*$$.

**Step 1: reduce to diagonal–unitary–diagonal.** Using cyclicity of trace,
$$
\operatorname{tr}(A^*B)
=\operatorname{tr}\!\bigl(V_A\Sigma_A U_A^*U_B\Sigma_B V_B^*\bigr)
=\operatorname{tr}\!\bigl(\Sigma_A\,W\,\Sigma_B\,Z\bigr),
$$
where $$W:=U_A^*U_B$$ and $$Z:=V_B^*V_A$$ are unitary.

Define
$$
X:=\Sigma_A\,W\,\Sigma_B.
$$
Then $$\operatorname{tr}(A^*B)=\operatorname{tr}(XZ)$$.

**Step 2: use nuclear-norm duality.** Since $$Z$$ is unitary, $$\|Z\|_2=1$$. Lemma 1 gives
$$
|\operatorname{tr}(XZ)| \le \|X\|_*.
$$

**Step 3: bound $$\|X\|_*$$ by the sorted product.** One can show (and it also follows from Ky Fan dominance below) that
$$
\|\Sigma_A\,W\,\Sigma_B\|_* \le \sum_{i=1}^{p} (\Sigma_A)_{ii}(\Sigma_B)_{ii}
= \sum_{i=1}^{p} \sigma_i(A)\sigma_i(B).
$$

Combining Steps 2 and 3 yields
$$
|\operatorname{tr}(A^*B)|\le \sum_{i=1}^{p} \sigma_i(A)\sigma_i(B).
$$
□

**Equality (intuition).** Equality occurs when the singular vectors align so that the largest singular directions of $$A$$ pair with those of $$B$$ (i.e. they share left/right singular subspaces up to phases).

---

## Theorem 2 (Ky Fan dominance)

### Statement
Let $$A,B\in\mathbb C^{m\times n}$$ and $$p=\min(m,n)$$. For each $$k=1,2,\dots,p$$,
$$
\sum_{i=1}^{k}\sigma_i(A^*B)\ \le\ \sum_{i=1}^{k}\sigma_i(A)\sigma_i(B).
$$

### Proof
Let $$X:=A^*B\in\mathbb C^{n\times n}$$. By Lemma 2,
$$
\sum_{i=1}^k\sigma_i(A^*B)
=\max_{\substack{P\in\mathbb C^{n\times k},\ P^*P=I\\ Q\in\mathbb C^{n\times k},\ Q^*Q=I}}
\Re\,\operatorname{tr}(P^*A^*BQ).
$$
Use cyclicity to rewrite
$$
\operatorname{tr}(P^*A^*BQ)=\operatorname{tr}\!\bigl((AP)^*(BQ)\bigr).
$$

**Step 1: apply von Neumann to the compressed matrices.** Theorem 1 applied to the $$m\times k$$ matrices $$AP$$ and $$BQ$$ gives
$$
\Re\,\operatorname{tr}\!\bigl((AP)^*(BQ)\bigr)
\le \sum_{i=1}^k \sigma_i(AP)\sigma_i(BQ).
$$

**Step 2: bound singular values under restriction to a subspace.** Since $$P,Q$$ have orthonormal columns, they are isometries onto their ranges, and
$$
\sigma_i(AP)\le \sigma_i(A),\qquad \sigma_i(BQ)\le \sigma_i(B),\qquad i=1,\dots,k.
$$
Therefore,
$$
\sum_{i=1}^k \sigma_i(AP)\sigma_i(BQ)
\le \sum_{i=1}^k \sigma_i(A)\sigma_i(B).
$$

**Step 3: maximize over $$P,Q$$.** Combining the last two displays and taking the maximum over $$P,Q$$ yields
$$
\sum_{i=1}^k\sigma_i(A^*B)\le \sum_{i=1}^k\sigma_i(A)\sigma_i(B).
$$
□

---

## Quick justification: why $$\sigma_i(AP)\le \sigma_i(A)$$ when $$P^*P=I$$

Using the min–max characterization,
$$
\sigma_i(A)=\max_{\dim S=i}\ \min_{\substack{x\in S\\ \|x\|=1}}\|Ax\|.
$$
If $$P^*P=I$$, the map $$x\mapsto Px$$ embeds $$\mathbb C^k$$ isometrically into $$\mathbb C^n$$, so $$AP$$ is simply $$A$$ restricted to the subspace $$\operatorname{range}(P)$$. Restricting to a subspace cannot increase these extrema, hence $$\sigma_i(AP)\le \sigma_i(A)$$.

---
