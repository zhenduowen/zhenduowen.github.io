---
title: Terkelsen's Theorem of Interchanging Min-Max
date: 2025-06-16
author: Zhenduo
categories: [Optimization, Lagrangian Duality]
tags: [Optimization, Lagrangian Duality, Min-Max]
---

**Terkelsen's Theorem of Interchanging Min-Max**

>Theorem 3 of F. Terkelsen, “Some minimax theorems,” Mathematica Scandinavica, vol. 31, pp. 405–413, 1972.


Let $X$ be a compact connected space, let $Y$ be a set, and let $f:X \times Y \rightarrow \mathbb R$ be a function satisfying:

- (i) For any $y_1,y_2 \in Y$ , there exists $y_0 \in Y$ such that 

    $$
    f(x,y_0) \geq \frac{1}{2}(f(x,y_1) + f(x,y_2)), \forall x \in X
    $$

- (ii) Every finite intersection of sets of the form $\{ x \in X:f(x,y) \leq \alpha \}$ with $(y,\alpha) \in Y \times \mathbb R$ is closed and connected, then

    $$
    \sup_{y \in Y} \min_{x\in X} f(x,y) = \min_{x \in X} \sup_{y \in Y}f(x,y)
    $$

&nbsp;<span style="float: right;">■</span>

*Remark.* 

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

    It is an straight-forward and obvious relationship and so far I have not find a name for it in the literature. One may call it "Greedy Property of MinMax", that is, **perform maximization first always gives you a no-worse-than result.**

3. Note that one can freely choose to keep or drop some constrains in the definition of the feasible fields $X$ and $Y$, sometimes it gives a different structure to the problem setting. In the field of network information theory, dropping conditions out of the feasible field reduces the cardinality of optimizer.
