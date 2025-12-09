---
title: Generating functions in Combinatorics
date: 2025-12-09
author: Zhenduo
categories: [Applied Mathematics, Combinatorics]
tags: [Combinatorics, Generating functions]
published: true
---

## 1. What is a generating function in Combinatorics?

Suppose you have a sequence of numbers  
$ a_0, a_1, a_2, a_3, \dots $

and you package them into a formal power series:
$$
A(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + \cdots
$$

- The coefficient of $x^n$ in $A(x)$, written $[x^n]A(x)$, is $a_n$.
- “Solving a combinatorics problem with generating functions” usually means:
  1. Build a generating function whose coefficients encode the counting problem.
  2. Manipulate that function algebraically. (The point of using generating functions is for this algebraic structure.)
  3. To get answer of the problem, read off the corresponding coefficient.
- Commonly, this method is applied to combinatorial problems with a fixed summation constraint, as $x^a \cdot x^b = x^{a+b}$.

---

## 2. Toy example: nonnegative integer solutions (stars and bars via GFs)

**Problem description.**  
How many solutions in nonnegative integers are there to
$$
a_1 + a_2 + \cdots + a_k = n, \quad a_i \ge 0?
$$

(This is saying the stars and bars problem: “Put $n$ identical balls into $k$ labeled boxes.”)

You might know the answer is $\binom{n+k-1}{k-1}$. Let’s *re-derive* that with generating functions.

---

### Step 1: Build a generating function for one variable

Consider just **one** variable $a_1$, which can be $0, 1, 2, \dots$.

We encode the choices for $a_1$ as:
$$
1 + x + x^2 + x^3 + \cdots
$$

Why?

- If we choose $a_1 = 0$, contribute $x^0 = 1$.
- If $a_1 = 1$, contribute $x^1$.
- If $a_1 = 2$, contribute $x^2$.
- Etc.

So the generating function
$$
G_1(x) = 1 + x + x^2 + x^3 + \cdots
$$
has coefficient of $x^m$ equal to $1$, meaning:

> There is exactly 1 way to choose $a_1$ so that it contributes $m$ to the sum (namely $a_1 = m$).

---

### Step 2: Combine $k$ independent variables

Now we have $a_1, a_2, \dots, a_k$, each behaving like that.

- Choices for $a_1$ are encoded by $1 + x + x^2 + \cdots$.
- Choices for $a_2$ are encoded by another copy of $1 + x + x^2 + \cdots$.
- …

When choices are **independent**, their generating functions **multiply**.

So the combined generating function is:
$$
G(x) =
\underbrace{(1 + x + x^2 + x^3 + \cdots)}_{\text{for } a_1}
\cdot
\underbrace{(1 + x + x^2 + x^3 + \cdots)}_{\text{for } a_2}
\ldots
\underbrace{(1 + x + x^2 + x^3 + \cdots)}_{\text{for } a_k}
=
(1 + x + x^2 + \cdots)^k.
$$

What does the coefficient of $x^n$ in $G(x)$ mean?

- Expanding the product, a typical term looks like
  $$
  x^{a_1} x^{a_2} \cdots x^{a_k} = x^{a_1 + \cdots + a_k},
  $$
  where $a_i$ is the exponent picked from the $i$-th factor.
- So the total exponent $n$ corresponds exactly to a choice of numbers $a_1,\dots,a_k$ with sum $n$.

Thus:

> The coefficient $[x^n] G(x)$ = number of nonnegative integer solutions to $a_1 + \dots + a_k = n$.

So we just need to simplify $G(x)$ and read off the coefficient.

---

### Step 3: Simplify the generating function

We know
$$
1 + x + x^2 + x^3 + \cdots = \frac{1}{1 - x} \quad\text{(geometric series)}.
$$

So
$$
G(x) = (1 + x + x^2 + \cdots)^k = \left(\frac{1}{1 - x}\right)^k = (1 - x)^{-k}.
$$

So our problem becomes:

> Find the coefficient of $x^n$ in $(1 - x)^{-k}$.

---

### Step 4: Use the binomial series

There is a binomial identity (valid as a formal power series):
$$
(1 - x)^{-k} = \sum_{n=0}^{\infty} \binom{n + k - 1}{k - 1} x^n.
$$

(Think of $(1 - x)^{-1} = 1 + x + x^2 + \cdots$. Take derivative on this expression gets the generalization.)

Therefore, the number of solutions is:
$$
{\binom{n + k - 1}{k - 1}}.
$$

---

## 3. Another tiny example: steps of size 1 or 2 (Fibonacci)

Just to see another style.

**Problem.**  
Number of ways to write $n$ as an ordered sum of 1s and 2s (compositions with parts 1 or 2, order matters).  
Example: for $n=4$,

- $1+1+1+1$
- $1+1+2$
- $1+2+1$
- $2+1+1$
- $2+2$

→ 5 ways.

This sequence is Fibonacci; let’s see the GF.

Each step is either:

- size 1 → contribute factor $x^1$,
- size 2 → contribute factor $x^2$.

A path for total size $n$ is a sequence of such steps; the weight is the product of their $x^\text{size}$.

The generating function for “a single step” is $S(x) = x + x^2$, as each step we can choose to add one or add two (this gives $x$ and $x^2$), and there is only one way to add one or add two (this gives the coefficients are both one).

- If uses zero step, this gives $1$.

- If uses one step, this gives $S(x)$.

- If uses two steps, this gives $S(x) \cdot S(x) = S(x)^2$.

A path is a sequence of 0 or more steps, so the generating function for “all paths” is
$$
F(x) = 1 + S(x) + S(x)^2 + S(x)^3 + \cdots = \frac{1}{1 - S(x)} = \frac{1}{1 - (x + x^2)}.
$$

So
$$
F(x) = \frac{1}{1 - x - x^2}.
$$

If we expand
$$
F(x) = \sum_{n\ge 0} f_n x^n,
$$
then $f_n$ is the number of ways to write $n$ as a sum of 1s and 2s. From the algebraic relation
$$
(1 - x - x^2) F(x) = 0 \quad\Rightarrow\quad
F(x) - x F(x) - x^2 F(x) = 0,
$$
equating coefficients gives the recurrence
$$
f_n = f_{n-1} + f_{n-2},
$$
with appropriate initial conditions, this gives the Fibonacci series.

---
