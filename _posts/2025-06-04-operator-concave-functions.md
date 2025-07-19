---
title: Operator Concave Functions
date: 2025-06-04
author: Zhenduo
categories: [Linear Algebra, Positive Semidefinite Matrices]
tags: [Linear Algebra, PSD]
---
**Definition. (Hemitian Matrices)** A linear operator $T$ is said to be Hemitian (denoted by $T \in \mathcal H$) if $\langle Tx, x \rangle \in \mathbb R$ for all $x$ in the Hilbert space.



**Definition. (Positive Matrices)** A linear operator $T$ is said to be positive (denoted by $T \succeq 0$) if $\langle Tx, x \rangle \geq 0 $ for all $x$ in the Hilbert space.



**Definition. (Operator Monotonic Function)**

A real-valued continuous function $f$ is called an operator-monotone function if 

$$
A \succeq B \succeq 0 \Rightarrow f(A) \succeq f(B).
$$

&nbsp;<span style="float: right;">■</span>

K. Löwner has completely characterized all operator-monotone functions as the class of Pick functions. 

**Theorem. (K. Löwner)**

A real-valued continuous function $f$ on $(0, \infty)$ is operator monotone (for positive operators) if and only if it has a representation

$$
f(t) = at + b + \int_{s=0}^{\infty} \frac{t}{t+s} d\mu(s),
$$

where $a \geq 0$ and $b$ are two arbitrary real constants. 

&nbsp;<span style="float: right;">■</span>

*Remark.*

- This representation shows that $f(t) = t^\alpha$ is operator monotone if $\alpha \in [0, 1]$ and it is not operator monotone if $\alpha > 1$. This is known as the Löwner–Heinz inequality: 

$$
A \geq B \geq 0 \implies A^\alpha \geq B^\alpha \quad \text{for all } \alpha \in [0, 1].
$$

- Operator concave functions form a smaller set than the concave functions.

**Definition. Operator Concave Functions**

A real-valued continuous function $f$ on $(0, \infty)$ is operator concave if

$$
f(\lambda A + \overline \lambda B) \succeq \lambda f(A) + \overline \lambda f(B), \quad \forall A,B \in \mathcal H, \lambda \in [0,1], \overline \lambda = 1 - \lambda
$$

&nbsp;<span style="float: right;">■</span>

**Corollary 1.**
Any operator monotone function on $[0,\infty)$ with $f(0) = 0$ is also operator concave.

*Proof.*
Apply K. Löwner's characterization and $f(0) = 0$, the result is immediate.

&nbsp;<span style="float: right;">■</span>


**Corollary 2.**

Let $f$ be an operator monotone function on $[0,\infty)$ with $f(0) = 0$, then for any $A,B \succ 0$, we have,

$$
\| f(A) - f(B) \| \leq f(\| A - B \|)
$$

where $\\| \cdot \\|$ is the spectral norm.

*Proof.*

In the scalar case, w.l.o.g assume $a > b > 0$, then the desired inequality is equivalent to $f(a) \leq f(a - b) + f(b)$. This is implied by concavity as $f(a) \leq \frac{a-b}{a} f(a) + \frac{b}{a}f(a) \leq f(\frac{a-b}{a} a) + f(\frac{b}{a}a) $, the last inequality comes from Jensen's inequality and $f(0) = 0$.

Then, consider $A \prec B + \\| A - B\\| I$, note that $ B , \\| A - B\\| I$ commute. Thus, they are simultaneously diagonalizable. Functions on these two operators can then be defined as functions over the diagonal entries. Thus, we have $f( B + \\| A - B\\| I) \preceq  f(B) + f(\\| A - B\\| I)$.

The last step is $f(\\| A - B\\| I) = f(\\| A - B\\|) \otimes I$. Now we have the result

$$
f(A) - f(B) \preceq f(\| A - B\|) \otimes I,
$$

which gives the desired inequality.

&nbsp;<span style="float: right;">■</span>
