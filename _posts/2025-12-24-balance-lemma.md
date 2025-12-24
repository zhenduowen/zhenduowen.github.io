---
title: Balance Lemma in Coding Theory
date: 2025-12-24
author: Zhenduo
categories: [Applied Mathematics, Linear Algebra]
tags: [Linera Algebra, Rank Nullity Theorem, Balance Lemma]
published: true
---


**Lemma (Balance of a non-trivial linear Boolean function)**

Let  

$$
f : \mathbb{F}_2^n \to \mathbb{F}_2 ,\qquad f(\mathbf{x}) = \langle \mathbf{a} , \mathbf{x} \rangle = a_1 x_1 \oplus \dots \oplus a_n x_n ,\qquad \mathbf{a} \neq 0,
$$

be any non-zero linear functional on the $n$–dimensional binary vector space.  
Then

$$
\bigl| \{ \mathbf{x} \in \mathbb{F}_2^n : f(\mathbf{x}) = 0 \} \bigr|
= \bigl| \{ \mathbf{x} \in \mathbb{F}_2^n : f(\mathbf{x}) = 1 \} \bigr|
= 2^{n-1}.
$$

Equivalently, every non-trivial linear Boolean function is *balanced*: it outputs $0$ and $1$ equally often.


*Proof 1 – Dimension/Kernel–Image argument*

1. Because $f$ is linear, its kernel  
   $$
   \ker(f) := \{ \mathbf{x} \in \mathbb{F}_2^n : f(\mathbf{x}) = 0 \} 
   $$  
   is a subspace of $\mathbb{F}_2^n$.

2. Since $f$ is **not** the zero map, its image is the whole field $\mathbb{F}_2$, so  
   $\dim (\operatorname{im} f) = 1$.

3. The rank–nullity theorem gives  
   $\dim (\ker f) = n - \dim (\operatorname{im} f) = n - 1$.

4. A subspace of dimension $n-1$ over $\mathbb{F}_2$ contains $2^{n-1}$ vectors, so  
   $|\ker f| = 2^{n-1}$.

5. Pick any $\mathbf{v} \notin \ker f$ (such a $\mathbf{v}$ exists because $\mathbf{a} \neq 0$).  
   For every $\mathbf{x} \in \ker f$, the map $\mathbf{x} \mapsto \mathbf{x} \oplus \mathbf{v}$ is a bijection from $\ker f$ onto the set  
   $$
   \lbrace \mathbf{x} \in \mathbb{F}_2^n : f(\mathbf{x}) = 1 \rbrace
   $$
   Hence, this second set also has $2^{n-1}$ elements.

Therefore, each of the two output values appears exactly $2^{n-1}$ times.



*Proof 2 – Explicit bijection (often used in coding texts)*

Fix $\mathbf{v}$ with $f(\mathbf{v}) = 1$.   
- Define $\varphi : \ker f \to \mathbb{F}_2^n$ by $\varphi(\mathbf{x}) = \mathbf{x} \oplus \mathbf{v}$.  
Then $f(\varphi(\mathbf{x})) = f(\mathbf{x}) \oplus f(\mathbf{v}) = 0 \oplus 1 = 1$, so $\varphi$ lands in the $1$-set.  
- Because $\varphi$ is its own inverse, it is a bijection (inverse function exists) between the $0$-set and the $1$-set, giving the same cardinalities $2^{n-1}$.

&nbsp;<span style="float: right;">■</span>

## Application to the binary simplex code

For $m \ge 2$, let

$$
S(m) = \bigl\{ \bigl( \langle \mathbf{a} , \mathbf{x} \rangle \bigr)_{\mathbf{x} \in \mathbb{F}_2^m \setminus \{0\}} : \mathbf{a} \in \mathbb{F}_2^m \bigr\} \subset \mathbb{F}_2^n, \qquad \text{where } n = 2^m - 1.
$$

(The coordinate positions are the non-zero column vectors $\mathbf{x}$, and the entry is the inner product $\mathbf{a} \cdot \mathbf{x}$.)

* The map $\mathbf{a} \mapsto \bigl( \langle \mathbf{a} , \mathbf{x} \rangle \bigr)$ is linear and injective on $\mathbb{F}_2^m \setminus \lbrace 0 \rbrace$, so $S(m)$ is an $[n,m]$ linear code; it is exactly the **dual** of the $[2^m-1, 2^m-m-1, 3]$ binary Hamming code and is called the *simplex code*.

* For any non-zero $\mathbf{a}$, the word 
$$
\mathbf{c}_{\mathbf{a}} = \bigl( \langle \mathbf{a} , \mathbf{x} \rangle \bigr)
$$
is simply the evaluation of the non-trivial linear functional $f_{\mathbf{a}}(\mathbf{x}) = \langle \mathbf{a} , \mathbf{x} \rangle$ on all non-zero $\mathbf{x}$.  

  By the lemma, $f_{\mathbf{a}}$ outputs $1$ on exactly half of the $2^m$ inputs.  
  Excluding the single input $\mathbf{x}=0$ (where $f_{\mathbf{a}}(0)=0$) removes one zero but no ones, so

  $$
  \operatorname{wt}(\mathbf{c}_{\mathbf{a}}) = 2^{m-1}. \qquad \text{(the constant weight of the simplex code)}
  $$

Thus, every non-zero codeword of the simplex code has the same weight $2^{m-1}$, which is why its minimum distance is $2^{m-1}$. The balance lemma above is the key ingredient in this proof.

---