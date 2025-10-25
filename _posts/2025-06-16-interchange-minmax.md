---
title: Theorems of Interchanging Min-Max
date: 2025-06-16
author: Zhenduo
categories: [Applied Mathematics, Optimization]
tags: [Optimization, Lagrangian Duality, Min-Max, Game Theory, Nash Equilibrium]
---

This blog introduces several theorems of interchanging Min-Max, also known as Minimax Theorems. I found these theorems useful and interesting in recent works. Before diving into the theorems, there are several preliminary facts:

1. To swap the notation between $x$ and $y$, use the following relationship: $\max_x f(x) = -\min_x -f(x)$, we have

    $$
    \begin{align*}
        &\sup_{y \in Y} \min_{x \in X}f(x,y) = -\inf_{y \in Y} \max_{x\in X} -f(x,y)
        \\&\min_{x \in X} \sup_{y \in Y}f(x,y) = -\max_{x \in X} \inf_{y\in Y}-f(x,y)
    \end{align*}
    $$

2. Trivially, we have the following observation, for any fixed $\overline x \in X$ and $\overline y \in Y$, we have  

    $$
    \inf_{x \in X} f(x, \overline y) \leq f(\overline x, \overline y) \leq \sup_{y \in Y} f(\overline x, y)
    $$

    Thus, take $\inf_{x \in X}$ and $\sup_{y \in Y}$ again on both sides:

    $$
    \begin{align*}
    & \Rightarrow \inf_{x \in X} f(x, \overline y)  \leq \inf_{x \in X}\sup_{y \in Y} f(x, y)  
    \\& \Rightarrow \sup_{y \in Y}\inf_{x \in X} f(x, y)  \leq \inf_{x \in X}\sup_{y \in Y} f(x, y)
    \end{align*}
    $$

    We have seen this relationship in constructing *Lagrangian Duality* <a href="{{zhenduowen.github.io}}/assets/files/notes/engg5501_handout7_optimality_conditions_and_lagrangian_conditions.pdf">(See Lecture 7 Section 4 from CUHK ENGG5501)</a>. This relationship is also where *the Weak Duality* comes from.

    It is also known as **the Max-Min Inequality**. One may call it "Greedy Property of MinMax", that is, **perform maximization first always gives you a no-worse-than result.**

**von Neumann's Minimax theorem**

Let $X$ and $Y$ be two standard simplex, then,

> John von Neumann and Oskar Morgenstern. Theory of Games and Economic Behavior. Princeton University Press. 1947.

$$
\max_{x \in X} \min_{y \in Y} x^T A y = \min_{y \in Y} \max_{x \in X}  x^T A y
$$

&nbsp;<span style="float: right;">■</span>

In game theory, the matrix $A$ in von Neumann's Minimax theorem represents a payoff matrix for a two-person, zero-sum game. The detailed background and John Nash's proof of this theorem (based on Brouwer fixed point theorem) is included in <a href="{{zhenduowen.github.io}}/assets/files/notes/rutgers_zeiberg_em18_von_neumann_minimax_thm.pdf">a note by Prof. Doron Zeilberger at Rutgers University</a>.


**Sion's Minimax Theorem**
> M. Sion. On General Minimax Theorems. Pacific Journal of Mathematics, 8(1):171–176, 1958.

Let $X$ be a convex subset of a linear topological space and $Y$ be a compact convex subset of a linear topological space. If $f$ is real-valued function on $X \times Y$ with:
- (i) $f(\cdot, y): X \rightarrow \mathbb R$ is upper-semicontinuous and quasi-concave on $X$, for every fixed $y \in Y$, and
- (ii) $f(x, \cdot): Y \rightarrow \mathbb R$ is lower-semicontinuous and quasi-convex on $Y$, for every fixed $x \in X$.

Then,

$$
\sup_{x \in X} \min_{y \in Y} f(x,y) = \min_{y \in Y} \sup_{x \in X}  f(x,y) 
$$

&nbsp;<span style="float: right;">■</span>

*Remark.*
1. Linear topological space is a vector space in which vector addition and scalar multiplication are continuous functions.

2. Quasi-convex means lower level set $\lbrace y: f(x, y) \leq t\rbrace$ is convex for all $x \in X$ and $t \in \mathbb R$. Similarly, quasi-concave means every lower level set is convex. Therefore, convex fubction is quasi-convex and concave function is quasi-concave. 

3. Lower-semicontinuous ensures the lower level sets are closed. Similarly, upper-semicontinuous ensures the upper level sets are closed. The detailed proof can be found at <a href = "https://math.stackexchange.com/questions/4649099/equivalence-of-closed-level-sets-and-lower-semi-continuity"> Equivalence of closed level sets and lower semi continuity</a> on StackExchange.

4. A special case of Sion's Minimax Theorem, which strengthens the requirements to concavity and convexity of the objective function, is stated in Theorem 9 in <a href="{{zhenduowen.github.io}}/assets/files/notes/engg5501_handout7_optimality_conditions_and_lagrangian_conditions.pdf"> Lecture 7 from CUHK ENGG5501</a>.

**Terkelsen's Minimax Theorem**

>Theorem 3 of F. Terkelsen, “Some minimax theorems,” Mathematica Scandinavica, vol. 31, pp. 405–413, 1972.

Let $X$ be a compact and connected space, let $Y$ be a set, and let $f:X \times Y \rightarrow \mathbb R$ be a function satisfying:

- (i) For any $y_1,y_2 \in Y$ , there exists $y_0 \in Y$ such that

    $$
    f(x,y_0) \geq \frac{1}{2}(f(x,y_1) + f(x,y_2)), \forall x \in X
    $$

- (ii) Every finite intersection of sets of the form $\lbrace x \in X:f(x,y) \leq \alpha \rbrace$ with $(y,\alpha) \in Y \times \mathbb R$ is closed and connected, then

    $$
    \sup_{y \in Y} \min_{x\in X} f(x,y) = \min_{x \in X} \sup_{y \in Y}f(x,y)
    $$

&nbsp;<span style="float: right;">■</span>

*Remark.*

1. Note that one can freely choose to keep or drop some constrains in the definition of the feasible fields $X$ and $Y$, sometimes it gives a different structure to the problem setting. In the field of network information theory, moving conditions out of the feasible field reduces the cardinality of optimizer.
