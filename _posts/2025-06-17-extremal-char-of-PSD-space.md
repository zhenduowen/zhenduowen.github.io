---
title: On a Extremal Characterization of Positive Semidefinite Matrices
date: 2025-06-17
author: Zhenduo
categories: [Applied Mathematics, Linear Algebra]
tags: [Linera Algebra, Positive Semidefinite Matrices]
---
**Theorem 1.**

> Theorem 1.3.3 in Bhatia, R. (2009). Positive definite matrices. Princeton University Press.

Let $A,B$ be strictly positive matrices. Then the block matrix $$\begin{bmatrix}A &X \\ X^H &B\end{bmatrix} \succeq 0$$ if and only if $$A \succeq X B^{-1} X^H$$.

*Proof.*

We have the congruence.

$$

\begin{align*}
\begin{bmatrix}
A &X \\
X^H &B
\end{bmatrix}
&\sim
\begin{bmatrix}
I &-XB^{-1} \\
O &I
\end{bmatrix}
\begin{bmatrix}
A &X \\
X^H &B
\end{bmatrix}
\begin{bmatrix}
I &O \\
-B^{-1}X^H &I
\end{bmatrix}
\\&=
\begin{bmatrix}
A - X B^{-1} X^H &O \\
O &B
\end{bmatrix}.
\end{align*}

$$

The last matrix is positive if and only if its upper left block is positive.

&nbsp;<span style="float: right;">■</span>

The same congruence is used in constructing the Schur Complement. Here we state two corollaries, the proof follows immediately from Theorem 1.

**Corollary 1. (A extremal characterization)**

> Proposition 1.5.4 in Bhatia, R. (2009). Positive definite matrices. Princeton University Press.

Let $B \succeq 0$ and $X$ be any matrix, then 

$$
X B^{-1} X^H = \min \left \lbrace A: \begin{bmatrix}
A &X \\
X^H &B
\end{bmatrix} \succeq 0 \right \rbrace.
$$


**Corollary 2.**
> Exercise 1.5.1 in Bhatia, R. (2009). Positive definite matrices. Princeton University Press.

The map $(B, X) \rightarrow X B^{-1} X^H$, where $B$ is strictly positive and outputs a positive matrix. Then the map is jointly convex over the inputs. That is,

$$
\left( \frac{X_1 + X_2}{2} \right)\left( \frac{B_1 + B_2}{2} \right)^{-1}\left( \frac{X_1 + X_2}{2} \right)^H \preceq \frac{X_1 B_1^{-1}X_1^H + X_2 B_2^{-1}X_2^H}{2}.
$$