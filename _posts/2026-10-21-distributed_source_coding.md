---
title: Slepian-Wolf and Wyner-Ziv Coding
description: An introduction to the well-known Slepian-Wolf and Wyner-Ziv Coding for distributed source coding in information theory.
date: 2026-10-21
author: Zhenduo
categories: [Information Theory, Compression]
tags: [Lossy Compression, Source Coding, Slepian-Wolf Coding, Wyner-Ziv Coding, Quantization, Binning]
---

## Slepian–Wolf coding

**Slepian–Wolf coding exploits correlation at the decoder even when the sources are encoded separately.** Suppose $(X^n,Y^n)$ consists of $n$ independent copies of a finite-alphabet pair $(X,Y)$. Two encoders observe $X^n$ and $Y^n$, respectively, and send messages

$$
M_X=f_n(X^n),
\qquad
M_Y=h_n(Y^n).
$$

A common decoder estimates both sequences from $(M_X,M_Y)$. We seek rates $(R_X,R_Y)$ for which the block error probability

$$
P_e^{(n)}
=
\Pr\!\left[
(\hat X^n,\hat Y^n)\ne(X^n,Y^n)
\right]
$$

tends to zero. The central question is how much the decoder can gain from the correlation between the sources.

**The Slepian–Wolf theorem characterizes this gain through three entropy constraints.** The achievable rate region is

$$
\boxed{
\begin{aligned}
R_X&\ge H(X|Y),\\
R_Y&\ge H(Y|X),\\
R_X+R_Y&\ge H(X,Y).
\end{aligned}
}
$$

The individual constraints account for the uncertainty remaining about one source when the other is known; the sum-rate constraint accounts for their joint uncertainty. Random binning achieves all three constraints by eliminating three corresponding kinds of decoding ambiguity [1, Section 10.3; 2, Chapter 13].

Throughout, logarithms are base two and integer roundings are suppressed. A jointly typical pair is one whose empirical joint distribution is close to $P_{XY}$. Terms denoted by $\delta$ are positive typicality corrections that vanish as the tolerances shrink; achievable boundary points are obtained by taking closures.

### Achievability

1. **Assign bin labels to source sequences.** Independently assign each $x^n\in\mathcal X^n$ a uniform label

   $$
   b_X(x^n)\in\{1,\ldots,2^{nR_X}\}.
   $$

   Independently construct a second assignment

   $$
   b_Y(y^n)\in\{1,\ldots,2^{nR_Y}\}.
   $$

   Sequences with the same label form a bin. Fix these assignments and reveal them to the encoders and decoder, so that each transmitted label identifies a known set of possible source sequences.

2. **Encode using only the locally observed sequence.** The encoders send

   $$
   M_X=b_X(X^n),
   \qquad
   M_Y=b_Y(Y^n).
   $$

   Neither encoder needs to observe the other source. Correlation will be used in decoding rather than in computing the messages.

3. **Decode by joint typicality within the received bins.** Given $(m_X,m_Y)$, the decoder searches for a unique pair $(\tilde x^n,\tilde y^n)$ satisfying

   $$
   \begin{aligned}
   b_X(\tilde x^n)&=m_X,\\
   b_Y(\tilde y^n)&=m_Y,\\
   (\tilde x^n,\tilde y^n)
   &\in\mathcal T_\epsilon^{(n)}(P_{XY}).
   \end{aligned}
   $$

   It outputs that pair if it is unique and declares an error otherwise. Thus the bin labels restrict the search, while joint typicality uses the source correlation to resolve the remaining ambiguity.

**The error analysis reduces to counting incorrect candidates and their bin-collision probabilities.** The true pair is jointly typical with probability approaching one. Conditional on a typical true pair $(x^n,y^n)$, an incorrect jointly typical candidate belongs to one of three classes:

| Incorrect candidate                                      | Upper bound on its class size | Probability of matching the required bin labels |
| -------------------------------------------------------- | ----------------------------: | ----------------------------------------------: |
| $(\tilde x^n,y^n)$, with $\tilde x^n\ne x^n$             |   $2^{n(H(X \mid Y)+\delta)}$ |                                     $2^{-nR_X}$ |
| $(x^n,\tilde y^n)$, with $\tilde y^n\ne y^n$             |   $2^{n(H(Y \mid X)+\delta)}$ |                                     $2^{-nR_Y}$ |
| $(\tilde x^n,\tilde y^n)$, with both sequences incorrect |        $2^{n(H(X,Y)+\delta)}$ |                               $2^{-n(R_X+R_Y)}$ |

A union bound therefore gives the following error bound, averaged over the bin assignments:

$$
\begin{aligned}
P_e^{(n)}
\le {}&
\Pr[(X^n,Y^n)\notin\mathcal T_\epsilon^{(n)}]
\\
&+2^{-n(R_X-H(X|Y)-\delta)}
\\
&+2^{-n(R_Y-H(Y|X)-\delta)}
\\
&+2^{-n(R_X+R_Y-H(X,Y)-\delta)}.
\end{aligned}
$$

Every term vanishes when the three rate inequalities hold with positive margins. Since the average error vanishes, there exists a sequence of fixed bin assignments with vanishing error, proving achievability.

### Converse

**The converse follows from the uncertainty that remains after decoding.** For any reliable code, Fano's inequality gives

$$
H(X^n,Y^n|M_X,M_Y)\le n\varepsilon_n,
\qquad
\varepsilon_n\to0.
$$

Because $M_X$ is a function of $X^n$ and $M_Y$ is a function of $Y^n$,

$$
\begin{aligned}
nR_X
&\ge H(M_X|Y^n)\\
&=I(X^n;M_X|Y^n)\\
&=nH(X|Y)-H(X^n|M_X,Y^n)\\
&\ge nH(X|Y)-n\varepsilon_n.
\end{aligned}
$$

Interchanging $X$ and $Y$ gives the second individual-rate bound. For the sum rate,

$$
\begin{aligned}
n(R_X+R_Y)
&\ge H(M_X,M_Y)\\
&=I(X^n,Y^n;M_X,M_Y)\\
&\ge nH(X,Y)-n\varepsilon_n.
\end{aligned}
$$

Dividing by $n$ and taking limits gives exactly the three inequalities in the theorem.

## Wyner–Ziv coding

### A special case of Slepian-Wolf problem setup

Let $(X^n,Y^n)$ consist of independent copies of a finite-alphabet pair $(X,Y)$. The encoder observes $X^n$ and sends a message $M$; the decoder observes $(M,Y^n)$ and produces $\hat X^n$. All logarithms are base two, and $R$ denotes the communication rate in bits per source symbol, so the message alphabet has approximately $2^{nR}$ elements. We first require exact recovery with probability approaching one, and then allow a prescribed reconstruction distortion.

The lossless problem is the decoder-side-information specialization of Slepian–Wolf coding. For a typical observation $y^n$, the decoder needs to distinguish only the sequences jointly typical with it, whose number is approximately $2^{nH(X|Y)}$. Although the encoder does not observe $y^n$, it can assign bin labels that allow the decoder to distinguish these sequences. This leads to a code operating at any rate $R>H(X|Y)$.

To construct the code, independently assign every $x^n\in\mathcal X^n$ a uniform label

$$
b(x^n)\in\{1,\ldots,\lceil2^{nR}\rceil\}.
$$

The assignment is known to both terminals. The encoder sends $M=b(X^n)$, and the decoder searches the indicated bin for a unique sequence satisfying

$$
b(\hat x^n)=M,
\qquad
(\hat x^n,Y^n)\in\mathcal T_\epsilon^{(n)}(P_{XY}).
$$

Here joint typicality means that the empirical joint distribution is close to $P_{XY}$, with zero-probability pairs excluded. The decoder outputs the unique sequence if it exists and declares an error otherwise. Thus the message specifies a set of candidates, and the side information distinguishes the transmitted sequence within that set.

The decoder succeeds when the true pair is typical and no incorrect candidate has the same bin label. Fix $\eta>0$ with $H(X|Y)+\eta<R$, and choose the typicality tolerance small enough that, for each typical $y^n$, the number of candidates is at most $2^{n(H(X|Y)+\eta)}$. Each incorrect candidate shares the true sequence's label with probability at most $2^{-nR}$. Averaging over the bin assignments and applying a union bound gives

$$
P_e^{(n)}
\le
\Pr[(X^n,Y^n)\notin\mathcal T_\epsilon^{(n)}(P_{XY})]
+2^{-n(R-H(X|Y)-\eta)}
\longrightarrow0.
$$

Since the average error tends to zero, there exists a sequence of fixed binning maps with the same reliability guarantee.

The converse follows from Fano's inequality. For any reliable code, $H(X^n|M,Y^n)\le n\varepsilon_n$ with $\varepsilon_n\to0$, so, suppressing integer-rounding terms,

$$
\begin{aligned}
nR
&\ge H(M)\ge I(X^n;M|Y^n)\\
&=nH(X|Y)-H(X^n|M,Y^n)\\
&\ge nH(X|Y)-n\varepsilon_n.
\end{aligned}
$$

The optimal lossless rate is therefore $H(X|Y)$ [1, Section 10.3; 2, Theorem 13.2]. The encoder need not send enough bits to identify $X^n$ without side information; its message only needs to resolve the uncertainty remaining at the decoder.

### Extend to lossy

Wyner–Ziv coding changes what the decoder must recover. When reconstruction error is allowed, the decoder can recover a description of $X^n$ and combine it with $Y^n$ to form an approximation. For a bounded distortion measure $0\le d(x,\hat x)\le d_{\max}$, the requirement is

$$
\limsup_{n\to\infty}
\frac1n\sum_{i=1}^n\mathbb E[d(X_i,\hat X_i)]
\le D.
$$

We therefore first choose a description that meets this distortion requirement, and then determine how much communication is needed to recover it.

A conditional distribution $P_{U|X}$ specifies the desired relationship between the source and its description, while a function $g$ specifies how the decoder uses the description. Choose a finite-alphabet $U$ and $g:\mathcal U\times\mathcal Y\to\hat{\mathcal X}$ satisfying

$$
P_{UXY}=P_{XY}P_{U|X},
\qquad
\mathbb E[d(X,g(U,Y))]\le D.
$$

The factorization gives $U-X-Y$: the description depends on the source, while the reconstruction may depend on both the description and the side information. The block code will realize these prescribed joint statistics by selecting a codeword jointly typical with $X^n$.

The codebook must contain enough codewords for this selection to succeed. For a typical $x^n$, an independent codeword drawn from $P_U^n$ is jointly typical with $x^n$ with probability of exponential order $2^{-nI(X;U)}$. Fix a margin $\eta>0$ and generate

$$
K=\left\lceil2^{n(I(X;U)+\eta)}\right\rceil
$$

codewords $U^n(1),\ldots,U^n(K)$ independently according to $P_U^n$, independently of $(X^n,Y^n)$. Thus the codebook satisfies the covering requirement $\frac1n\log K>I(X;U)$ with a positive margin. Given $x^n$, the encoder selects the smallest index $J$ for which

$$
(x^n,U^n(J))\in\mathcal T_{\epsilon'}^{(n)}(P_{XU}).
$$

This selection is the quantization step: it assigns the source sequence a description from the codebook.

The covering guarantee follows directly from the independent generation of the codewords. Choose the encoding tolerance sufficiently small that, for every sufficiently typical $x^n$ and all large $n$,

$$
\Pr[(x^n,U^n(j))\in\mathcal T_{\epsilon'}^{(n)}(P_{XU})]
\ge 2^{-n(I(X;U)+\eta/2)}.
$$

The probability that all $K$ codewords fail the test is then at most

$$
\begin{aligned}
\left(1-2^{-n(I(X;U)+\eta/2)}\right)^K
&\le \exp\!\left\{-K2^{-n(I(X;U)+\eta/2)}\right\}\\
&\le \exp\!\left\{-2^{n\eta/2}\right\}.
\end{aligned}
$$

Together with the vanishing probability of an atypical source sequence, this proves that a jointly typical description is available with probability approaching one.

The selected index can now be communicated using the same binning mechanism as in the lossless code. Sending $J$ itself would require $\lceil\log K\rceil$ bits, approximately $n(I(X;U)+\eta)$. Instead, assign each index an independent uniform bin label

$$
b(j)\in\{1,\ldots,\lceil2^{nR}\rceil\},
$$

and send $M=b(J)$. Here $K$ counts the available descriptions, whereas $R$ measures the transmitted bits per source symbol. The two operations are

$$
X^n
\xrightarrow{\text{quantization}}
J
\xrightarrow{\text{binning}}
M.
$$

The codebook and the bin assignments are known to both terminals, and the rule selecting $J$ does not consult the bin labels. If quantization fails, the encoder sends a separate failure message; this adds only $o(1)$ to the rate.

The decoder uses $Y^n$ to identify the selected description within the received bin. Given a nonfailure message $m$, it searches for a unique index $\hat J$ satisfying

$$
b(\hat J)=m,
\qquad
(U^n(\hat J),Y^n)\in\mathcal T_\epsilon^{(n)}(P_{UY}).
$$

If such an index exists, it reconstructs $\hat X_i=g(U_i(\hat J),Y_i)$ for every $i$; otherwise it uses a fixed default reconstruction. The decoder uses the same binning and typicality test as in the lossless construction, now searching among codeword indices rather than source sequences.

The selected codeword passes this test because selection preserves the conditional distribution of the side information. Given $X^n$ and the codebook, $J$ is already determined without observing $Y^n$. Hence the conditional law of $Y^n$ remains $\prod_{i=1}^nP_{Y|X}(y_i|x_i)$. Conditional typicality therefore extends the selected typical pair $(X^n,U^n(J))$ to a typical triple $(X^n,U^n(J),Y^n)$. Choosing the decoding tolerance appropriately larger than the encoding tolerance makes $(U^n(J),Y^n)$ pass the decoder's test with probability approaching one.

The remaining error is that another index in the same bin also passes the test. Condition on the codebook, the source sequences, and successful selection of $J$. Since this selection ignores the bin labels, each $k\ne J$ shares $J$'s label with probability at most $2^{-nR}$. Apply a union bound and then drop the restrictions that encoding succeeded and $k\ne J$. This yields

$$
\begin{aligned}
&\Pr[\text{encoding succeeds and an incorrect index in the received bin passes}]
\\& \le
2^{-nR}\sum_{k=1}^{K}
\Pr[(U^n(k),Y^n)\in\mathcal T_\epsilon^{(n)}(P_{UY})].
\end{aligned}
$$

For each fixed $k$, the generated codeword $U^n(k)$ is unconditionally independent of $Y^n$. Taking the tolerances sufficiently small gives

$$
\Pr[(U^n(k),Y^n)\in\mathcal T_\epsilon^{(n)}(P_{UY})]
\le 2^{-n(I(U;Y)-\eta/2)}.
$$

The probability of an incorrect candidate is consequently at most

$$
K\,2^{-n(R+I(U;Y)-\eta/2)},
$$

which tends to zero whenever

$$
R>I(X;U)-I(U;Y)+2\eta.
$$

This is the same candidate-counting principle used in the lossless proof. The codebook contains approximately $2^{nI(X;U)}$ descriptions, and only a fraction of exponential order $2^{-nI(U;Y)}$ pass the side-information test. Binning must distinguish the descriptions that remain, so its asymptotic rate is the difference $I(X;U)-I(U;Y)$.

Joint typicality and successful decoding also give the distortion guarantee. On their intersection, the empirical distortion is at most $\mathbb E[d(X,g(U,Y))]+\eta$ for sufficiently small tolerances. On the complementary event it is at most $d_{\max}$. Therefore,

$$
\frac1n\sum_{i=1}^n\mathbb E[d(X_i,\hat X_i)]
\le
D+\eta+d_{\max}\Pr[\text{a covering, typicality, or decoding failure}].
$$

The failure probability vanishes under the preceding rate condition. For each fixed positive rate gap, choose $\eta$ and the typicality tolerances sufficiently small, and then let $n\to\infty$. Letting the margins vanish and selecting suitable fixed codebooks and bin assignments proves achievability at every rate strictly above $I(X;U)-I(U;Y)$.

The Markov condition expresses this difference as a conditional mutual information:

$$
\begin{aligned}
I(X;U)-I(U;Y)
&=H(U|Y)-H(U|X)\\
&=H(U|Y)-H(U|X,Y)\\
&=I(X;U|Y).
\end{aligned}
$$

Optimizing over the description and reconstruction rule gives the achievable direction of the following result [1, Theorem 11.3; 2, Theorems 16.5–16.6].

**Theorem (Wyner–Ziv).** For finite alphabets and bounded distortion, the minimum communication rate with side information available only at the decoder is

$$
\boxed{
R_{\mathrm{WZ}}(D)
=\min_{\substack{P_{U|X},\,g:\\
\mathbb E[d(X,g(U,Y))]\le D}}
I(X;U|Y),
}
$$

where the joint distribution is $P_{UXY}=P_{XY}P_{U|X}$ and $U$ ranges over finite alphabets.

**Converse.** Consider any code $M=f_n(X^n)$, $\hat X^n=\varphi_n(M,Y^n)$. To represent its $i$th reconstruction as a function of an auxiliary variable and $Y_i$, put all the decoder's other observations into

$$
U_i=(M,Y^{i-1},Y_{i+1}^n).
$$

Then $\hat X_i$ is a function of $(U_i,Y_i)$. Memorylessness makes $Y_i$ conditionally independent of $(M,Y^{i-1},Y_{i+1}^n)$ given $X_i$, so $U_i-X_i-Y_i$. These are exactly the reconstruction and Markov conditions required by the theorem.

The communication rate bounds the information supplied by these auxiliaries. Using the memoryless source law and then subadditivity of conditional entropy,

$$
\begin{aligned}
nR
&\ge H(M)\ge I(X^n;M|Y^n)\\
&=nH(X|Y)-H(X^n|M,Y^n)\\
&\ge\sum_{i=1}^n
\left[H(X_i|Y_i)-H(X_i|M,Y^n)\right]\\
&=\sum_{i=1}^n I(X_i;U_i|Y_i).
\end{aligned}
$$

Let $T$ be independent and uniform on $\{1,\ldots,n\}$, and set $(X,Y,U)=(X_T,Y_T,(U_T,T))$. The inclusion of $T$ in $U$ records which coordinate is being reconstructed, giving

$$
U-X-Y,
\qquad
R\ge I(X;U|Y),
$$

and a reconstruction function satisfying

$$
\mathbb E[d(X,g(U,Y))]
=\frac1n\sum_{i=1}^n\mathbb E[d(X_i,\hat X_i)].
$$

Thus every block code induces an admissible description whose conditional mutual information is no larger than its rate. Minimization and passage to the asymptotic closure establish the converse.

## Why introduce $P_{U|X}$ in lossy coding?

The auxiliary distribution $P_{U|X}$ describes a new design choice in lossy coding: *what information about $X$ should the encoder convey so that the decoder can reconstruct it to the required accuracy?* The variable $U$ represents that information. Its relationship with $X$ determines how useful the description is, while its relationship with $Y$ determines how much communication is needed.

In the lossless construction, the object to be recovered is already specified: the decoder must identify $X^n$ itself. We can regard this as choosing $U=X$. Once distortion is allowed, the decoder need not recover $X^n$ exactly, so we can choose a description that contains less information. The purpose of optimizing over $P_{U|X}$ is to find such a description.

**What does the Wyner-Ziv coding do is to introduce quantization $P_{U|X}$ for reconstruction, and losslessly compress this U with the binning method in the lossless setup.**

To see why a conditional distribution appears, first consider ordinary lossy compression without side information. There, the description can be the reconstruction itself, and the rate–distortion theorem optimizes over

$$
P_{\hat X|X}
\quad\text{subject to}\quad
\mathbb E[d(X,\hat X)]\le D.
$$

The conditional distribution specifies which reconstructions are associated with which source symbols, and the distortion constraint determines whether this association is acceptable. Thus, even ordinary lossy coding requires choosing a statistical relationship between the source and its reconstruction.

**In Wyner–Ziv coding, the communicated description and the final reconstruction have different roles because the decoder also uses $Y$.** We represent the description by $U$ and write the reconstruction as

$$
\hat X=g(U,Y).
$$

The encoder selects the description using its observation of $X$, while the decoder combines that description with its observation of $Y$. These two restrictions are expressed by the intended single-letter distribution

$$
P_{UXY\hat X}(u,x,y,\hat x)
=
P_{XY}(x,y)\,
P_{U|X}(u|x)\,
\mathbf 1\{\hat x=g(u,y)\}.
$$

In particular, the description satisfies $U-X-Y$, but the reconstruction need not satisfy $\hat X-X-Y$: it can depend directly on the decoder’s side information.

This distinction explains why we generally cannot replace $U$ by $\hat X$. If $Y$ alone provides an adequate reconstruction, the encoder can send nothing. We then choose $U$ to be constant and reconstruct using

$$
\hat X=g(Y).
$$

The communicated description is constant, even though the reconstruction varies with $Y$. Introducing $U$ allows the theorem to represent exactly this separation between what is communicated and what is reconstructed.

**The conditional distribution $P_{U|X}$ tells the code construction which descriptions are suitable for a given source sequence.** After choosing it, we obtain the target joint distribution

$$
P_{XU}(x,u)=P_X(x)P_{U|X}(u|x).
$$

The encoder then searches its codebook for a sequence $u^n(j)$ such that

$$
(x^n,u^n(j))
\in\mathcal T_\epsilon^{(n)}(P_{XU}).
$$

This means that the empirical relationship between the source sequence and the selected description approximates the prescribed relationship $P_{XU}$. For example, among coordinates where the source symbol equals $x$, the frequencies of the description symbols approximate $P_{U|X}(\cdot|x)$. The auxiliary distribution therefore gives a precise criterion for selecting a description; the function $g$ determines whether that description yields sufficiently small distortion.

A conditional distribution here does **not** require the encoder to generate each $U_i$ independently by sampling from $P_{U|X}(\cdot|X_i)$. The actual block encoder may be deterministic—for example, it selects the first jointly typical codeword. The distribution specifies the desired empirical statistics of the selected pair, rather than prescribing a symbol-by-symbol randomized encoder.

Finally, choosing $P_{U|X}$ determines both costs in the construction. Finding a suitable description requires a codebook of approximately $2^{nI(X;U)}$ codewords. The decoder’s side information then permits binning to reduce the communication rate to

$$
I(X;U)-I(U;Y)=I(X;U|Y).
$$

We therefore optimize jointly over **which description to convey**, represented by $P_{U|X}$, and **how to reconstruct from it**, represented by $g$:

$$
R_{\mathrm{WZ}}(D)
=
\min_{\substack{
P_{U|X},\,g:\\
\mathbb E[d(X,g(U,Y))]\le D
}}
I(X;U|Y).
$$

References:

[1] A. El Gamal and Y.-H. Kim, *Network Information Theory*, Cambridge University Press, 2012. Section 10.3, pp. 260–264; Section 11.3, especially the achievability and converse proofs on pp. 282–285.

[2] I. Csiszár and J. Körner, *Information Theory: Coding Theorems for Discrete Memoryless Systems*, 2nd edition, Cambridge University Press, 2011. Theorem 13.2, pp. 244–245; Theorems 16.5–16.6, pp. 363–368. Their Wyner–Ziv treatment interchanges the source and side-information variable names relative to the notation here.
