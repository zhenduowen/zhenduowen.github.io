---
title: Achievability Proof via Output Statistics of Random Binning
description: An introduction to the OSRB framework of Yassaee, Aref, and Gohari, its central idea, a two-bit example, and what the framework can achieve.
date: 2026-11-09
author: Zhenduo
categories: [Information Theory, General Techniques for Information Theory]
tags: [Information Theory, Random Binning, Channel Coding, Slepian-Wolf Coding, OSRB]
---

## Introduction

How can a source-coding construction become a channel code? The paper [*Achievability Proof via Output Statistics of Random Binning*](https://arxiv.org/pdf/1203.0730), by **Mohammad Hossein Yassaee, Mohammad Reza Aref, and Amin Gohari**, gives a systematic answer through the **output statistics of random binning (OSRB)** framework.

> The central idea is to begin with a source distribution that is easy to analyze, assign bin labels to source sequences, and then use the conditional distribution of the source given its labels as an encoder. If the labels are nearly independent and uniform, replacing them by an actual message and independent shared randomness changes the joint distribution only slightly.

This post introduces that reversal through a two-bit example, then explains what OSRB can do. The theoretical framework and results are due to Yassaee, Aref, and Gohari; I am afraid that I do not understand the details of this method, so here I am just dabbling. Also, **GPT 6.1 Sol Ultra-thinking-level assisted with the writing of this exposition**.

Throughout, alphabets are finite, logarithms are base $2$, and rates are measured in bits per symbol.

## A two-bit example

Take two independent fair bits $A,B$, and consider the deterministic channel

$$
X=(A,B),\qquad Y=A.
$$

The channel reveals the first input bit and discards the second.

First consider a **source experiment**. Generate $X=(A,B)$ uniformly and give it two labels,

$$
M=A,\qquad F=B.
$$

| Source $X$ | Label $M$ | Label $F$ | Observation $Y$ |
| ---------- | --------: | --------: | --------------: |
| $(0,0)$    |         0 |         0 |               0 |
| $(0,1)$    |         0 |         1 |               0 |
| $(1,0)$    |         1 |         0 |               1 |
| $(1,1)$    |         1 |         1 |               1 |

Each row has probability $1/4$. Two properties are immediate: $M,F$ are independent fair bits, and $X$ can be recovered from $(Y,F)$.

Now **reverse the experiment**. Begin with a message $M$ and an independent shared bit $F$. Given $(M,F)=(m,f)$, generate the channel input using the source experiment's conditional distribution:

$$
P_{X\mid M,F}(x\mid m,f)=\mathbf 1\{x=(m,f)\}.
$$

Thus the encoder sends $X=(m,f)$. The channel produces $Y=m$, and the receiver recovers $X=(Y,F)$ and hence $M$.

For a uniform message, the two experiments have exactly the same joint distribution. Their operational meanings differ: in the source experiment, $M$ is computed from $X$; in the communication experiment, $M$ is supplied to the encoder, which generates $X$.

Finally, fix $F=0$. The resulting code is

$$
0\longmapsto(0,0),\qquad 1\longmapsto(1,0),
$$

and transmission remains error-free. Fixing $F$ changes the input distribution, but preserves the decoding performance we need.

These labels were specially chosen. The example illustrates the reversal, rather than proving an asymptotic random-binning claim. Random binning supplies approximate versions of the same properties for general memoryless sources.

## What can OSRB do?

**OSRB is a framework for proving that communication schemes exist and determining the rates they can achieve.** Its main value is a reusable proof method for network information theory, where several terminals, messages, and decoding requirements can make direct codebook analysis complicated.

The guiding question is:

> Can we first describe a joint distribution with the properties we want, then construct a communication scheme that approximately reproduces it?

OSRB answers this using three steps:

1. **Build a source experiment.** Choose correlated random variables and assign bin labels. Analyze which labels can be recovered and which are approximately uniform or independent.
2. **Turn it into a communication scheme.** Treat selected labels as messages and use conditional distributions as encoders.
3. **Transfer the guarantees.** Show that the two experiments have close joint distributions, then remove any temporary shared randomness when the problem permits it.

The two-bit example illustrates these steps with exact equality of distributions. For a general memoryless channel, random binning gives approximate equality under suitable rate conditions. If $R$ is the message rate and $R_F$ is the rate of the auxiliary label $F$, the channel-coding construction combines

$$
R+R_F<H(X),\qquad R_F>H(X\mid Y).
$$

The first condition makes the labels approximately independent and uniform; the second allows recovery of $X^n$ from $F,Y^n$. A choice of $R_F$ satisfying both exists whenever

$$
R<H(X)-H(X\mid Y)=I(X;Y).
$$

Here $I(X;Y)$ is the mutual information between the channel input and output under a chosen input distribution. Thus OSRB recovers the usual channel-coding achievability condition. The full construction appears in [Section 4.2 of the paper](https://arxiv.org/pdf/1203.0730).

The same approach supports several kinds of requirements:

| Goal                               | Property the construction must establish                                    |
| ---------------------------------- | --------------------------------------------------------------------------- |
| Reliable communication             | Receivers recover the intended messages                                     |
| Lossy compression                  | Reconstructions meet a distortion target                                    |
| Coordination or channel simulation | Generated variables approximate a prescribed joint distribution             |
| Secure communication               | Messages remain approximately independent of an eavesdropper's observations |

The authors apply the framework to these settings, including broadcast and relay networks, and derive new strong-secrecy achievable regions. See the [paper](https://arxiv.org/abs/1203.0730) for the precise models and guarantees.

Its distinctive strength is **controlling joint distributions**, which lets a proof handle decoding, dependence, and secrecy within one approach. An achievable region still needs a matching converse to establish optimality, so OSRB does not automatically determine the capacity of every network. The conditional encoders provide theoretical constructions without necessarily giving computationally efficient implementations.
