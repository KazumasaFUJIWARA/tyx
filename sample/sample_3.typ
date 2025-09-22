#import "article.typ": *

// % vim: set foldmarker=[[[,]]]
// \documentclass[reqno]{amsart}
// %\usepackage{xcolor}
// \usepackage{mathtools,amssymb, xcolor}
// \mathtoolsset{showonlyrefs}
// %[[[ env setting
// \newtheorem{Theorem}{Theorem}[section]
// \newtheorem{Definition}[Theorem]{Definition}
// \newtheorem{Corollary}[Theorem]{Corollary}
// \newtheorem{Lemma}[Theorem]{Lemma}
// \newtheorem{Proposition}[Theorem]{Proposition}
// \newtheorem{Remark}{Remark}[section]
// %\addtolength{\textwidth}{5.cm}
// %\addtolength{\textheight}{4cm}
// %]]]

// \begin{document}
// %[[[ metadata
// \title{Global existence for DWQ caused by Sign changing  phenomena}
// \author[K.Fujiwara]{Kazumasa Fujiwara }
// \address[K. Fujiwara]{
// 	Faculty of Advanced Science and Technology,
// 	Ryukoku University,
// 	1-5 Yokotani,Seta Oe-cho,Otsu,Shiga,
// 	520-2194, Japan
// }

// \email{fujiwara.kazumasa@math.ryukoku.ac.jp}

// \author[V.Georgiev]{Vladimir Georgiev}
// \address[V.Georgiev]{
// Department of Mathematics,
// University of Pisa,
// Largo Bruno Pontecorvo 5,
// I - 56127 Pisa, Italy}
// \address{
// Faculty of Science and Engineering, Waseda University,
// 3-4-1, Okubo, Shinjuku-ku, Tokyo 169-8555, Japan}
// \address{
// Institute of Mathematics and Informatics,  Bulgarian Academy of Sciences, Acad. Georgi Bonchev Str., Block 8, Sofia, 1113, Bulgaria
// }
// \email{georgiev@dm.unipi.it}

// \subjclass{35B40,35B33, 35B51}
// \keywords{
// damped wave equations,
// Fujita  critical exponent,
// power-type nonlinearity,
// decay estimate
// }
// %]]]

// \begin{abstract}
// In this manuscript, we study initial data
// that guarantee global-in-time solutions to the Cauchy problem
// for the semilinear damped wave equation
// with a power-type nonlinearity.
// Our proof relies on a comparison principle derived from
// fundamental properties of wave equations.
// In particular, we exhibit initial data
// with negative position and positive velocity
// that produce global solutions through a sign-changing mechanism,
// even though these data do not satisfy
// the standard assumptions of the comparison argument.
// 

// \maketitle

// %[[[
= Introduction
= Introduction
// %[[[ In this note,
In this note,
we consider the behavior of solutions
to the Cauchy problem for the semilinear damped wave equation
	$
	c a s e s(
	∂_t^2 u+∂_t u-Δ u=|u|^p,  &= t>0, x ∈ ℝ^n, \
	u(0)=u_0, ∂_t u(0)=u_1,  &= x ∈ ℝ^n .
	)
	$ //[formula type:align]
The aim of this manuscript
is to establish the global existence of solutions
under the initial conditions
	$
	&= ( //[c o m m a n d t y p e:l e f t]
	u_0, u_1) //[c o m m a n d t y p e:r i g h t]
	=( //[c o m m a n d t y p e:l e f t]
	ε_0 φ, ε_1 φ) //[c o m m a n d t y p e:r i g h t]
	, \
	&= 0 < ε_0 < |ε_1| = - ε_1.
	$ //[formula type:align]
with
$n = 1$
,
$( //[command type:left]
	ε_0, ε_1) //[command type:right]
 ∈ ℝ^2$
small,
and
$φ$
being a regular non-negative function.
// %]]]

// %[[[ The Cauchy problem
@eq:DW //[ref type:eqref]
has been extensively studied.
The Cauchy problem
@eq:DW //[ref type:eqref]
has been extensively studied
(see
@M76 //[ref type:cite]
,
@TY01 //[ref type:cite]
,
@N03 //[ref type:cite]
,
@MN03 //[ref type:cite]
,
@HKN04 //[ref type:cite]
,
@INZ06 //[ref type:cite]
,
@DA15 //[ref type:cite]
,
@DLR15 //[ref type:cite]
@IIOW19 //[ref type:cite]
,
@FIW19 //[ref type:cite]
,
@LT19 //[ref type:cite]
,
@IS19 //[ref type:cite]
,
@CR21 //[ref type:cite]
,
@KK22 //[ref type:cite]
,
and references therein).
A key step for analyzing the nonlinear problem
@eq:DW //[ref type:eqref]
is to first
understand the corresponding linear (free) problem:
	$
	c a s e s(
	∂_t^2 u + ∂_t u - Δ u = 0,\
	u(0) = u_0,
	∂_t u(0) = u_1.
	)
	$ //[formula type:align]
// %]]]
 
// %[[[ An explicit representation of solutions to
@eq:linear_damped_wave //[ref type:eqref]
An explicit representation of solutions to
@eq:linear_damped_wave //[ref type:eqref]
is derived through the substitution
$u(t,x)=e^{-t/2}w(t,x)$
,
which transforms
@eq:linear_damped_wave //[ref type:eqref]
into the wave-type equation
	$
∂_t^2 w - Δ w = (1)/(4) w,
	$ //[formula type:align]
which highlights the wave structure; for details, see Chapter VI, Section 6 in
@CH89 //[ref type:cite]
.
In particular,
@eq:transformed_wave_equation //[ref type:eqref]
yields the following
comparison principle for
@eq:DW //[ref type:eqref]
in one and two dimensional case:
if
$\overline{u_0} ≥ \underline{u_0} $
and
$\overline{u_1} + \overline{u_0}/2 ≥ \underline{u_1} + \underline{u_0}/2$
,
then the solutions
$\overline{u}$
of
@eq:DW //[ref type:eqref]
with
$\overline{u_0}, \overline{u_1}$
and
$\underline{u}$
with
$\underline{u_0}, \underline{u_1}$
satisfy
$\overline{u}(t,x) ≥ \underline{u}(t,x)$
for all
$t ≥ 0$
and
$x$
.
This comparison principle will be a key tool in what follows.
Hereafter, we denote by
$S(t)f$
the solution to
@eq:linear_damped_wave //[ref type:eqref]
corresponding to the data
$(u_0,u_1)=(0,f)$
.
// %]]]

// %[[[ Owing to the damping term
$∂_t u$
,
Owing to the damping term
$∂_t u$
,
the free solution to
@eq:DW //[ref type:eqref]
is
asymptotically equivalent to the solution of the free heat equation:
	$
	c a s e s(
	∂_t v - Δ v = 0,\
	v(0) = u_0 + u_1.
	)
	$ //[formula type:align]
For simplicity, we denote by
$e^{t Δ} f$
the solution to
@eq:free_heat //[ref type:eqref]
corresponding to the data
$v(0)=f$
.
Marcati and Nishihara
@MN03 //[ref type:cite]
and Nishihara
@N03 //[ref type:cite]
established the asymptotic equivalence
in the one- and three-dimensional cases, respectively.
Namely, for a sufficiently regular function
$f$
,
the following asymptotic relation holds:
	$
	S(t) f
	∼ e^(t Δ) f + e^(-t/2) W(t) f.
	$ //[formula type:align]
We refer to
@IIOW19 //[ref type:cite]
for more general results.
We note that, even before the explicit proofs by Marcati and Nishihara,
this idea had been used in the perturbative analysis of solutions to
@eq:DW //[ref type:eqref]
;
see, for example,
@LZ95 //[ref type:cite]
.
// %]]]

// %[[[ Returning to the Cauchy problem
@eq:DW //[ref type:eqref]
,
Returning to the Cauchy problem
@eq:DW //[ref type:eqref]
,
the local existence of solutions to
@eq:DW //[ref type:eqref]
is known under standard regularity assumptions.
For example, a classical result can be found in
@s90 //[ref type:cite]
.
Moreover, the discussion in
@MN03 //[ref type:cite]
implies that
$S(t)$
satisfies the same
$L^p$
–
$L^q$
type estimates
as
$e^{t Δ}$
.
Therefore, the following local existence result holds:
#lemma(title: "Local existence", id: "lemma:local_existence")[
Assume that
$(u_0,u_1) ∈ W^{1,∞} ∩ W^{1,1} × L^∞ ∩ L^1$ and $p > 1$ and $n =1$.
There exists
$T_1=T_1(u_0,u_1)$
such that @eq:DW //[ref type:eqref] possesses a unique mild solution
$u ∈ C( //[command type:left]
	[ //[command type:left]
	0, T_1) //[command type:right]
 ;W^{1,∞} ∩ W^{1,1}) //[command type:right]
$
satisfying the estimate
	$ sup_{0 ≤ t ≤ T_1} \|u(t) \|_{ L^{∞}}
	≲ ( \|u_0 \|_{L^∞} + \|u_1 \|_{L^∞}). $ //[formula type:align]
] //[Lemma]

Here
$W^{1,q}$
for
$1 ≤ q ≤ ∞$
denotes the usual Sobolev space,
a collection of measurable functions
$f$
such that both
$f$
and its weak derivative
$f^'$
belong to
$L^q$
.
We also note that
$p=1+2/n$
is the so-called Fujita critical exponent,
which gives the threshold for blow-up of positive solutions to
@eq:DW //[ref type:eqref]
and for the existence of global solutions to the Fujita-type heat equation:
	$
∂_t v - Δ v = |v|^p.
	$ //[formula type:align]
For details, see
@F66,H73,KST77 //[ref type:cite]
.
We also remark that when
$n ∈ ℕ$
,
$p > 1+2/n$
,
and the initial data are sufficiently small,
then solutions to
@eq:DW //[ref type:eqref]
exist globally in time.
Our subsequent analysis is based on Lemma
@lemma:local_existence //[ref type:ref]
.
// %]]]

// %[[[ Although the solution to
@eq:linear_damped_wave //[ref type:eqref]
Although the solution to
@eq:linear_damped_wave //[ref type:eqref]
can be constructed explicitly from
@eq:transformed_wave_equation //[ref type:eqref]
,
the asymptotic equivalence
@eq:asymptotic_equivalence //[ref type:eqref]
is a powerful tool for analyzing solutions to
@eq:DW //[ref type:eqref]
.
Roughly speaking, one may analyze solutions
$u$
to
@eq:DW //[ref type:eqref]
by treating
$u$
as if it were
$e^{t Δ}(u_0 + u_1)$
—that is,
as if
$u$
behaved like the heat flow generated by the initial mass
$u_0+u_1$
.
For example, Li and Zhou
@LZ95 //[ref type:cite]
showed that
when
$n = 1, 2$
and
$1 < p ≤ 3$
,
if
	$
∫ u_0 + u_1 d x > 0,
	$ //[formula type:align]
then, irrespective of the size of the initial data,
the solution
$u$
to
@eq:DW //[ref type:eqref]
blows up in finite time.
Moreover, they derived sharp estimates for the lifespan in terms of the size of the initial data.
In
@LZ95 //[ref type:cite]
, the authors rigorously estimated the infimum of the solution
$u$
in a parabolic region,
as if, roughly speaking,
$u$
behaved like
$e^{t Δ} (u_0 + u_1)$
,
and introduced an ODE governing the infimum of
$u$
.
Later,
Zhang
@Z01 //[ref type:cite]
,
Ikeda and Wakasugi
@IW15 //[ref type:cite]
,
and Ikeda and Sobajima
@IS19 //[ref type:cite]
proved finite-time blow-up of
the spatial mean of solutions to
@eq:DW //[ref type:eqref]
and derived lifespan estimates
in more general spatial settings,
still under the initial condition
@eq:initial_mean_condition //[ref type:eqref]
.
Their approach is based on the weak formulation of
@eq:DW //[ref type:eqref]
and is more closely tied to the scaling properties of
@eq:DW //[ref type:eqref]
than to the asymptotic equivalence
@eq:asymptotic_equivalence //[ref type:eqref]
.
Recently, the present authors
@FG25a //[ref type:cite]
showed the finite-time blow-up of solutions to
@eq:DW //[ref type:eqref]
and obtained sharp lifespan estimates
under the mean-zero initial condition
	$
	∫ u_0 + u_1 d x = 0,
	u_0, u_1 ¬≡ 0.
	$ //[formula type:align]
The approach of
@FG25a //[ref type:cite]
is inspired by that of Li and Zhou
@LZ95 //[ref type:cite]
.
We note that
the mean-zero condition
@eq:initial_mean_condition_ours //[ref type:eqref]
cannot be handled by a direct application of a weak formulation approach.
We also refer to
@IO16, FIW19, IS19 //[ref type:cite]
for related topics.
// %]]]

// %[[[ The arguments above do not yield
The arguments above do not yield
the sharp initial conditions for blow-up.
In particular, for any
$μ_0, μ_1 ∈ ℝ$
,
by combining the finite propagation speed
with the arguments above,
for any
$μ_0, μ_1 ∈ ℝ$
,
there exist smooth initial data
$(u_0, u_1)$
satisfying
	$
	
	∫ u_0 d x = μ_0,
	
	∫ u_1 d x = μ_1,
	
	$ //[formula type:display]

such that the corresponding solution blows up in finite time.
More precisely,
let
$ψ$
be a smooth function supported in a compact set
and its integral is
$1$
.
Let
$L$
be a large positive number.
If
	$
	u_0(x)  &= ψ(x) + (μ_0-1) ψ(x-L), \
	u_1(x)  &= μ_1 ψ(x-L),
	$ //[formula type:align*]
then one can show
$u(t,x) = u_b(t,x) + u_g(t,x-L)$
till some time,
where
$u_b$
is the blow-up solution with initial data
$(u_0, u_1) = (ψ,0)$
and
$u_g$
is the solution with initial data
$(u_0, u_1) = ((μ_0-1)ψ, μ_1 ψ)$
.
Since the argument above implies that
$∫ u_b + ∂_t u_b dx$
blows up in finite time
and
$∫ u_g + ∂_t u_g dx$
is increasing,
there exists a time
$t_0$
such that
	$
	
	∫ u(t_0) + ∂_t u(t_0) d x
	= ∫ u_b(t_0) + ∂_t u_b(t_0) d x + ∫ u_g(t_0) + ∂_t u_g(t_0) d x
	> 0.
	
	$ //[formula type:display]

Therefore, the solution
$u$
blows up in finite time
by the same argument from
$t=t_0$
.
// %]]]

// %[[[ Nevertheless,
Nevertheless,
it is also known that
there exist nontrivial global solutions to
@eq:DW //[ref type:eqref]
.
Li and Zhou
@LZ95 //[ref type:cite]
also showed that,
when
$n = 1, 2$
and even when
$1 < p ≤ 3$
,
global existence for small initial data holds for
@eq:DW //[ref type:eqref]
under the following pointwise condition (for all
$x$
):
	$
	u_0(x) = 0,
	u_1(x) ≤ 0.
	$ //[formula type:align]
This was further extended to
	$
	u_0(x) ≤ 0,
	u_1(x) + \f r a c 1 2 u_0(x) ≤ 0.
	$ //[formula type:align]
For details, see
@FG25b //[ref type:cite]
.
The conditions
@eq:initial_condition_Li_Zhou //[ref type:eqref]
and
@eq:initial_condition_Li_Zhou_general //[ref type:eqref]
are used to implement a comparison argument
based on the nonlinear version of
the transformation associated with
@eq:transformed_wave_equation //[ref type:eqref]
.
Indeed, under
@eq:initial_condition_Li_Zhou //[ref type:eqref]
and
@eq:initial_condition_Li_Zhou_general //[ref type:eqref]
,
solutions are shown to be negative at any time and point.
On the other hand, in other cases,
it is unclear whether
there is an initial condition
with which global solutions exist.
// %]]]

// %[[[ The expectation of global existence for
@eq:DW //[ref type:eqref]
,
The expectation of global existence for
@eq:DW //[ref type:eqref]
,
even with a positive initial position,
may be supported by a result of Pinsky
@P16 //[ref type:cite]
.
In
@P16 //[ref type:cite]
, it is shown that
there exist both global and blow-up solutions of
@eq:fujita_equation //[ref type:eqref]
for certain sign-changing initial data.
The proof relies on a comparison argument
that is not directly applicable to
@eq:DW //[ref type:eqref]
without imposing the initial condition
@eq:initial_condition_Li_Zhou_general //[ref type:eqref]
.
On the other hand,
since global solutions to
@eq:DW //[ref type:eqref]
are known to behave similarly to global solutions of
@eq:fujita_equation //[ref type:eqref]
under certain initial conditions,
the gap in the assumptions required by the comparison argument
appears to be merely technical.
// %]]]

// %[[[ The aim of this manuscript
The aim of this manuscript
is to generalize a sufficient condition
for global existence of solutions to
@eq:DW //[ref type:eqref]
.
For simplicity, we restrict our attention to the one-dimensional case.
In particular,
we show that the blow-up conditions based on the spatial integrals of the initial data,
namely
@eq:initial_mean_condition //[ref type:eqref]
and
@eq:initial_mean_condition_ours //[ref type:eqref]
,
cannot be relaxed without taking into account the shape of the initial data,
provided that the spatial integral of the initial position is positive.
More precisely, we ask the following question:
Does there exist a constant
$c_0 > 0$
such that, for
	$
	
	0 < ε_0 < c_0 |ε_1| ≪ 1,
	
	$ //[formula type:display]

there exists a smooth, positive function
$φ$
such that
the solution with initial data
$(u_0,u_1) = (ε_0 φ, ε_1 φ)$
exists globally in time?
To the best of the authors' knowledge,
global existence for
@eq:DW //[ref type:eqref]
has only been established via comparison arguments.
Accordingly, we employ the following simple sufficient condition for global existence:
there exist a constant
$c_0 > 0$
and a smooth, positive function
$φ$
such that, for
	$
	
	ε_0 < c_0 |ε_1| ≪ 1,
	
	$ //[formula type:display]

the solution
$u$
with initial data
$(u_0,u_1) = (ε_0 φ, ε_1 φ)$
satisfies
	$
u(t,x) ≤ 0,\ \ ∂_t u(t,x) + (1)/(2)u(t,x) ≤ 0
	$ //[formula type:align]
for all
$x$
at some time
$t$
.
Once
@eq:aim //[ref type:eqref]
is verified,
Theorem 1.2 in
@FG25a //[ref type:cite]
yields global existence.
Decay in this case is studied in
@FG25b //[ref type:cite]
.

The following is the main statement of this manuscript,
answering the question above:
#theorem(id: "theorem:main")[
Let
	$ 0 < ε_0 < -ε_1 ≪ 1.
	\label{eq:condition_ratio} $ //[formula type:align]
Then there exists a sufficiently small number $ρ$ and
a positive function $φ ∈ W^{2,1} ∩ W^{2,∞}$
satisfying the following pointwise control
	$ \label{eq:shape_assumption} \tag{H1}
	|φ^'(x)| + |φ^{''} (x)| ≤ ρ  φ(x) , \ \ \forall x ≥ 0 $ //[formula type:align]
and the mild solution $u ∈ C([0,T_0) × ℝ)$ to @eq:DW //[ref type:eqref]
with initial data $(u_0,u_1) = (ε_0 φ, ε_1 φ)$
exists and satisfies the pointwise estimates @eq:aim //[ref type:eqref]
at time
	$ t(ε_0/|ε_1|)+δ ∈ (0,2), $ //[formula type:display]
where $δ>0$ is sufficiently small
and $t=t(ε_0/|ε_1|)$ is the unique positive solution 
of 
	$ \label{eq.deft}
	(ε_0)/(|ε_1|) =  (4t)/((4-t)(2+t)). $ //[formula type:align]
] //[Theorem]
We give some remarks on Theorem
@theorem:main //[ref type:ref]
.
First,
the condition
@eq:condition_ratio //[ref type:eqref]
is optimal.
Indeed, for
$ε_0 + ε_1 ≥ 0$
,
we can apply Theorem 1.1 in
@FG25a //[ref type:cite]
and deduce blow-up.
Second,
for any positive
$ρ$
,
there exists a function
$φ ∈ W^{2,1} ∩ W^{2,∞}$
satisfying
@eq:shape_assumption //[ref type:eqref]
.
Indeed, let
$N$
be an integer,
$a >1$
, and
	$
	
	φ(x) = (N^2+x^2)^(-a/2)
	
	$ //[formula type:display]

then
$φ ∈ W^{2,1} ∩ W^{2,∞}$
and
	$
	|φ^'(x)|  &= ≤ (a)/(N) φ(x),\
	|φ^('')(x)|  &= ≤ (a(a+1))/(N^2) φ(x),
	$ //[formula type:align*]
so
$ρ = a/N + a(a+1)/N^2 \to 0$
as
$N \to ∞.$
Third,
the condition
@eq:shape_assumption //[ref type:eqref]
plays an important role
in obtaining the pointwise estimate
@eq:aim //[ref type:eqref]
.
In particular,
@eq:shape_assumption //[ref type:eqref]
implies that
solutions
$u$
are estimated by
$φ$
pointwisely up to a certain time,
and this pointwise control implies the conclusion.
Finally,
the function
	$
	
	a(t) = (4t)/((4-t)(2+t))
	
	$ //[formula type:display]

is strictly increasing for
$t ∈ (0,2)$
, with
$a(0)=0$
and
$a(2)=1$
.
Therefore, the unique positive solution
$t ∈ (0,2)$
of
@eq.deft //[ref type:eqref]
is well-defined.
The smallness of
$δ$
is determined by
	$
	
	δ < b(t)-a(t),
	
	$ //[formula type:display]

where
	$
	
	b(t) = (8t)/((2+t)^2).
	
	$ //[formula type:display]

The proof that
$b(t)>a(t)$
for
$t ∈ (0,2)$
is elementary
and can be found at the end of the proof of Theorem
@theorem:main //[ref type:ref]
.

We note that
it is still unclear whether
there exists a global solution to
@eq:DW //[ref type:eqref]
in the case where
$(u_0,u_1) = (ε_0 φ, ε_1 φ)$
with smooth positive
$φ$
and
$ε_0$
and
$ε_1$
are sufficiently small and satisfy
	$
	
	ε_0 < 0, 
	ε_1 > 0, 
	ε_0 + ε_1 < 0, 
	\m b o x{a n d} \
	ε_1 + ε_0/2 > 0.
	
	$ //[formula type:display]

In the next section, we collect some preliminary estimates.
Theorem
@theorem:main //[ref type:ref]
is shown in the last section.
// %]]]
= Preliminary
We, at first, show the estimate
for the solution to the Cauchy problem for a nonhomogeneous wave equation.
#lemma(id: "lemma:estimate_of_transformed_wave")[
Let $g ∈ W^{1,∞}$ and $f, w ∈ L^∞(0,2;L^∞)$.
Then there exists a unique $L^∞$ valued mild solution $v$
to the following Cauchy problem:
	$ \begin{cases}
	∂_t^2 v + ∂_t v - ∂_x^2 v  = f w+g ∂_x w,\\
	v(0,x)= ε_0,\\
	∂_t v(0,x)= ε_1.
	$ //[formula type:display]
Moreover, $v$ enjoys the following estimate:
	$ \|v(t)\|_{L^∞}
	& ≤ ε_0 e^{-t} + (ε_0 + ε_1) (1-e^{-t})\\
	& + C t ( //[command type:bigg]
	
		\|f\|_{L^∞(0,t; L^∞)} + \| g \|_{W^{1,∞}}
	) //[command type:bigg]
 \|w\|_{L^∞(0,t; L^∞)}.
	\label{1dmax} $ //[formula type:align]
] //[Lemma]
#proof[
We recall that a standard Duhamel formula implies that
	$ v(t,x)
	&= ε_0 e^{-t}
	+ ( ε_0 + ε_1 )(1-e^{-t})\\
	&+ ∫_0^t S(t-τ) f(τ) w(τ)(x) dτ
	+ ∫_0^t S(t-τ) g ∂_x w(τ,x) dτ, $ //[formula type:align*]
where
	$ S(t) h(x)
	= (1)/(2) e^{-t/2} ∫_{-t}^{t} I_0 ( //[command type:bigg]
	(sqrt(t^2-y^2))/(2) ) //[command type:bigg]
 h(x+y) d y. $ //[formula type:display]
We note that by denoting $ω = sqrt(t^2-y^2)$ we have
	$ e^{-t/2} I_0 ( //[command type:bigg]
	(ω)/(2) ) //[command type:bigg]

	≤ ⟨ ω ⟩^{-1/2} e^{(ω - t/2)}
	≤ C ⟨ t ⟩^{-1/2} e^{-y^2/8t}. $ //[formula type:display]
Therfore, a straightforward calculation shows that
	$ \| S(t-τ) f(τ) w(τ) \|_{L^∞}
	≤ C \| f(τ) \|_{L^∞} \| w(τ) \|_{L^∞}. $ //[formula type:display]
We note that by writing $σ = t-τ$ we have
	$ e^{σ/2} S(σ) g ∂_x w(τ)(x)
	&= ∫_{-σ}^{σ} I_0 ( //[command type:bigg]
	(sqrt(σ^2-y^2))/(2) ) //[command type:bigg]
 g(x+y) ∂_x w(τ, x+y) dy\\
	&= g(x+σ) w(τ,x+σ) - g(x-σ) w(τ,x-σ)\\
	&- ∫_{-σ}^{σ} I_0 ( //[command type:bigg]
	(sqrt(σ^2-y^2))/(2) ) //[command type:bigg]
 \dot g(x+y) w(τ,x+y) dy\\
	&+ ∫_{-σ}^{σ} I_1 ( //[command type:bigg]
	(sqrt(σ^2-y^2))/(2) ) //[command type:bigg]
 (y)/(sqrt(σ^2-y^2)) g(x+y) w(τ,x+y) dy. $ //[formula type:align*]
We note that by writing $ω = sqrt(σ^2-y^2)$,
we have
	$ \bigg| e^{-σ/2} (y)/(ω) I_1(ω/2) \bigg|
	≤ C (y)/(⟨ ω ⟩^{3/2)} e^{(ω - σ)/2}
	≤ C ⟨ σ ⟩^{-1/2} e^{-y^2/8σ}. $ //[formula type:display]
Thereore, we have
	$ \| S(t-τ) g(τ) ∂_x w(τ) \|_{L^∞}
	≤ C \| g \|_{W^{1,∞}} \| w(τ) \|_{L^∞} $ //[formula type:display]
and this implies @1dmax //[ref type:eqref].
] //[proof]
By using Lemma
@lemma:estimate_of_transformed_wave //[ref type:ref]
,
we mesure the difference between
$u(t)$
and initial position
$φ$
under a certain condition by using their ratio.
#lemma(title: "Refined local estimates")[
\label{lemma:estaimte_of_u_devided}
Let $ε_0$ and $ε_1$ are real constans sufficiently close to $0$
satisfying $0 < ε_0 < - ε_1$.
Let $t ∈ (0,T_0)$ and $ρ >0$ satisfy
	$ C ( |ε_1|^{p-1} + ρ ) t < 1
	\label{eq:condition_for_u_devided} $ //[formula type:align]
with a positive constant $C$.
Assume that $φ ∈ W^{2,1} ∩ W^{2,∞}$
satisfy @eq:shape_assumption //[ref type:eqref].
If the mild solution $u$ of Lemma @lemma:local_existence //[ref type:ref]
with initial data $(u_0,u_1) = (ε_0,ε_1)$
satsify 
	$ \| |u|^{p-2}u\|_{L^∞(0,T_0; L^∞)}
	+ \bigg\|(\ddot φ)/(φ) \bigg\|_{L^∞}
	+ \bigg\|(\dot φ^2)/(φ^2) \bigg\|_{L^∞}
	≤ C ( ε_1^{p-1} + ρ ). $ //[formula type:display]
Then $u$ enjoys the following estimate for $t ∈ (0,T_0)$:
	$ \label{eq2mm}
	\left\| (u(t))/(φ) \right\|_{ L^{∞}}
	≤ \frac{|ε_0 e^{-t} + (ε_1 + ε_0)(1-e^{-t})|}{1-C ( |ε_1|^{p-1} + ρ ) t}. $ //[formula type:align]
] //[Lemma]
#proof[
We make the substitution
	$ v(t,x) = (u(t,x))/(φ(x)), $ //[formula type:display]
so we have
	$ ∂_t^2 v + ∂_t v - ∂_x^2 v
	= (|u|^p)/(φ)
	+ 2 (\dot φ ∂_x u)/(φ^2)
	+ (\ddot φ)/(φ^2) u
	- 2 (\dot φ^2)/(φ^3) u $ //[formula type:align*]
Since
	$ ∂_x u = v \dot φ  + φ ∂_x v $ //[formula type:display]
we arrive at
	$ ∂_t^2 v + ∂_t v - ∂_x^2 v \\
	= ( //[command type:bigg]
	|u|^{p-2} u + (\ddot φ)/(φ) ) //[command type:bigg]
 v
	+ 2 (\dot φ)/(φ) ∂_x v $ //[formula type:display]
Therefore, the Cauchy problem can be rewritten as
	$ \begin{cases}
	∂_t^2 v + ∂_t v - ∂_x^2 v  = f v+g∂_xv, \\
	v(0,x)=ε_0 , & x ∈ ℝ, \\
	∂_t v(0,x) =ε_1 , & x ∈ ℝ.
	$ //[formula type:align*]
with 
	$ f = |u|^{p-2}u  + (\ddot φ)/(φ),
	
	g =  2  (\dot φ)/(φ). $ //[formula type:display]
Noting
	$ \dot g = 2 (\ddot φ)/(φ) - 2 (\dot φ^2)/(φ^2) $ //[formula type:display]	
and applying Lemma @lemma:local_existence //[ref type:ref]
and the assumption @eq:shape_assumption //[ref type:eqref],
$ \|f\|_{L^∞(0,T_0; L^∞)}
≤ C_1 ( |ε_1|^{p-1} + ρ ) $ //[formula type:display]
and $\|g\|_{W^{1,∞}} ≤ C_1 ρ$
with some positive constants $C_1$.
] //[proof]
Next estimate plays an important role
to estimate the solution on the basis of initial data.
#lemma(title: "Hermite–Hadamard", id: "l3")[
Let $φ$ be $C^1(ℝ; [0,∞))$,
such that there is a positive constant $ρ$ so that
$ \label{eq.bb1}
 &  |\dot φ(x)| ≤ ρ  φ(x) , \ \ \forall x ≥ 0. $ //[formula type:align]
Then we have
$ \label{eq.HH1}
      & ( φ(α) + φ(β))/(2) ≤  (1)/(β - α) ∫_{α}^{β} φ(σ) d σ + (ρ)/(2) ∫_{α}^β φ(σ) d σ $ //[formula type:align]
and
$ \label{eq.HH1mm}
      & ( φ(α) + φ(β))/(2) ≥  (1)/(β - α) ∫_{α}^{β} φ(σ) d σ -(ρ)/(2) ∫_{α}^β φ(σ) d σ $ //[formula type:align]
for $0  ≤  α < β < ∞.$
] //[Lemma]
#proof[
We use the following identity, obtained in @DA98 //[ref type:cite]
(see Lemma 2.1 in @DA98 //[ref type:cite])
	$ ( φ(α) + φ(β))/(2) - (1)/(β - α) ∫_{α}^{β} φ(σ) d σ
	= (β -  α)/(2) ∫_0^1 (1-2t) \dot φ(t α + (1-t)β) dt. $ //[formula type:display]
Then we can write
	$ ( φ(α) + φ(β))/(2) - (1)/(β - α) ∫_{α}^{β} φ(σ) d σ
	& = (β - α)/(2) ∫_0^1 (1-2t) \dot φ(t α + (1-t)β) dt \\
	& ≤ (β - α)/(2) ∫_{0}^1  | \dot φ(t α + (1-t)β)| dt \\
	&  = (1)/(2)∫_{α}^{β} |\dot φ(σ)| d σ. $ //[formula type:align*]
Assuming @eq.bb1 //[ref type:eqref], we get
@eq.HH1 //[ref type:eqref].

It is easy to extend this estimate also to the cases $α < 0 < β$ and $α < β <0$
using the additional assumption that $φ$ is an even function.
In fact, when $α < 0 < β$ we define the interval $J\subset [0,∞)$ with ends $-α$ and $β$ and then we can apply @eq.HH1 //[ref type:eqref] so we have
	$ \label{eq.HH1m}
	( φ(α) + φ(β))/(2)
	= ( φ(-α) + φ(β))/(2)
	≤  (1)/(|J|) ∫_{J} φ(σ) d σ
	+ (ρ)/(2) ∫_{J } φ(σ) d σ. $ //[formula type:align]
This completes the proof.
] //[proof]
We finalize this section
by collecting some estimates of calculs to control nonlinaerity.
Consider the function
	$
	C(t,r,ρ,ε_1)
	= sup_(τ ∈ [0,t]) G(τ,r,ρ,ε_1),
	$ //[formula type:align]
where
	$
	
	G(τ,r,ρ,ε_1)
	= ( | r + e^(-τ) - 1 |)/(1-C ( |ε_1|^(p-1) + ρ ) τ)
	
	$ //[formula type:display]

under the assumption
@eq:condition_for_u_devided //[ref type:eqref]
is satisfied.
Here
$ρ$
is a positive number and
$ε_1$
is a negative number
which are close to
$0$
.
#lemma(id: "l.61")[
We have the relation
	$ C(t,r,ρ, ε_1)
	= \begin{cases}
	G(t,r,ρ, ε_1) & \text{if }   r < r_1(t), \\
	r & \text{if }   r ∈ [r_1(t), r_2(t)], \\
	G(min(t,- log(1-r)),r,ρ, ε_1) & \text{if }   r > r_2(t),
	$ //[formula type:display]
where
	$ r_1(t)
	&= \frac{1+C | ε_1|^{p-1} t + C ρ t}{2 + t},\\
	r_2(t)
	&= \frac{1-e^{-τ}}{C ( |ε_1|^{p-1} + ρ ) τ}. $ //[formula type:align*]
] //[Lemma]
#proof[
We split the proof into three cases,
$r < r_1(t)$, $r ∈ [r_1(t), r_2(t)]$ and $r > r_2(t)$.

We note that $r_1$ is a increasing function and $r_2$ is a decreasing function.
The monotonicity of $r_2$ follows from the fact that
	$ \frac{1-e^{-τ}}{τ}
	= ∫_0^1 e^{-τ σ} d σ. $ //[formula type:display]
Therfore, $r ∈ [r_1(t), r_2(t)]$ implies that
	$ r ∈ \bigcap_{τ ∈ [0,t]} [r_1(τ), r_2(τ)]. $ //[formula type:display]
Since $C δ t < 1$, we note that $1-e^{-τ} ∈ [r_1(τ), r_2(τ)]$ for any $τ ∈ [0,t]$.
In the case where $r ∈ [r_1(τ), 1-e^{-τ}]$, we have
	$ &G(τ,r,ρ, ε_1) ≤ r\\
	\Leftrightarrow & \frac{ 1 - e^{-τ} - r}{1-C ( |ε_1|^{p-1} + ρ ) τ} ≤ r\\
	\Leftrightarrow & 1 - e^{-τ} - r ≤ r (1-C ( |ε_1|^{p-1} + ρ ) τ)\\
	\Leftrightarrow & r ≥ \frac{1-e^{-τ}}{2-C ( |ε_1|^{p-1} + ρ ) τ} = r_1(τ). $ //[formula type:align*]
Similarly, in the case where $r ∈ [1-e^{-τ}, r_2(τ)]$, we have
	$ &G(τ,r,ρ, ε_1) ≤ r\\
	\Leftrightarrow & \frac{ r - 1 + e^{-τ}}{1-C ( |ε_1|^{p-1} + ρ ) τ} ≤ r\\
	\Leftrightarrow & r - 1 + e^{-τ} ≤ r (1-C ( |ε_1|^{p-1} + ρ ) τ)\\
	\Leftrightarrow & r ≤ \frac{1-e^{-τ}}{C ( |ε_1|^{p-1} + ρ ) τ} = r_2(τ). $ //[formula type:align*]
These computations imples that $C(t,r,ρ, ε_1) = r$ for $r ∈ [r_1(t), r_2(t)]$.

In the case where $r < r_1(t)$,
$C(t,r,ρ, ε_1) = G(t,r,ρ, ε_1)$ because $C(⋅,r,ρ, ε_1)$ is increasing.

In the case where $r > r_2(t)$,
we compute
	$ ∂_τ G(τ,r,ρ, ε_1)
	&= - \frac{ e^{-τ}}{1-C ( |ε_1|^{p-1} + ρ ) τ}
	+ \frac{ C ( |ε_1|^{p-1} + ρ ) (r + e^{-τ} - 1) }{(1-C ( |ε_1|^{p-1} + ρ ) τ)^2}\\
	&= \frac{ C ( |ε_1|^{p-1} + ρ ) (r + ( τ + 1 ) e^{-τ} - 1) - e^{-τ} }{(1-C ( |ε_1|^{p-1} + ρ ) τ)^2}\\
	&= e^{-τ} \frac{ C ( |ε_1|^{p-1} + ρ ) ( τ + 1) - 1 - (1-r) C ( |ε_1|^{p-1} + ρ ) e^τ }{(1-C ( |ε_1|^{p-1} + ρ ) τ)^2}. $ //[formula type:align*]
So $∂_τ G(0,r,ρ, ε_1) < 0$.
Moreover, we also compute
	$ &∂_τ \{ C ( |ε_1|^{p-1} + ρ ) ( τ + 1) - 1 - (1-r) C ( |ε_1|^{p-1} + ρ ) e^τ \}\\
	&= C ( |ε_1|^{p-1} + ρ ) (1 - (1-r) e^τ). $ //[formula type:align*]
This implise that
	$ C(t,r,ρ, ε_1) = G(min(t,- log(1-r)),r,ρ, ε_1). $ //[formula type:display]
] //[proof]
#corollary(id: "c62")[
We have the relation
	$ C(t,r,0,1/4) =
	\begin{cases}
	(t(1-r/2)-r )/((1-t^2/4))
	& \mbox{if}   r < r_t,\\
	r
	& \mbox{if}   r ≥ r_t,
	$ //[formula type:align]
where
	$ r_t
	= (4t)/(8+2t-t^2)
	= (4t)/((4-t)(2+t)). $ //[formula type:display]
] //[Corollary]
// %[[[
= Comparison principle
= Proof of Theorem \ref{theorem:main
}
// %[[[ Proposition Comparison Principle
$w = e^{t/2} u$
is a solution to the Cauchy problem
	$
	c a s e s(
	∂_t^2 w - Δ w = ( //[c o m m a n d t y p e:l e f t]
	(1)/(4) + u|u|^(p-2) ) //[c o m m a n d t y p e:r i g h t]
	w,
	&= t ∈ (0,T_0), \ x ∈ ℝ,\
	w(0)=ε_0 φ(x),
	&= x ∈ ℝ,\
	∂_t w(0) =ε_1φ(x)+(ε_0)/(2)φ(x),
	&= x ∈ ℝ.
	)
	$ //[formula type:align]
The D'Alembert formula implies
	$
	&= w(t) = ε_0 (d)/(d t) W(t) (φ)(x) + ( //[c o m m a n d t y p e:l e f t]
	ε_1 + (ε_0)/(2) ) //[c o m m a n d t y p e:r i g h t]
	W(t)(φ)(x)\
	&= + ∫_(0^t W(t-τ)( //[c o m m a n d t y p e:l e f t])
	( //[c o m m a n d t y p e:l e f t]
	(1)/(4)+u(τ)|u(τ)|^(p-2)) //[c o m m a n d t y p e:r i g h t]
	w(τ) ) //[c o m m a n d t y p e:r i g h t]
	(x) dτ
	$ //[formula type:align*]
where
	$
	
	W(t)(f)(x) = (1)/(2) ∫_((x-t)^){x+t} f(τ) dτ,
	
	$ //[formula type:display]

so
	$
	&= ∂_t w(t,x) =  ε_0 ( //[c o m m a n d t y p e:l e f t]
	(d)/(d t)) //[c o m m a n d t y p e:r i g h t]
	^2 W(t) (φ)(x) + ( //[c o m m a n d t y p e:l e f t]
	ε_1 + (ε_0)/(2) ) //[c o m m a n d t y p e:r i g h t]
	(d)/(d t) W(t)(φ)(x)\
	&= + ∫_(0^t (d)/(d t) W(t-τ)( //[c o m m a n d t y p e:l e f t])
	( //[c o m m a n d t y p e:l e f t]
	(1)/(4)+u(τ)|u(τ)|^(p-2)) //[c o m m a n d t y p e:r i g h t]
	w(τ) ) //[c o m m a n d t y p e:r i g h t]
	(x) dτ
	$ //[formula type:align*]
Set
	$
	
	r = ε_0/|ε_1|
	
	$ //[formula type:display]

and
$r∈ [0,1)$
follows from the assumption
@eq:condition_ratio //[ref type:eqref]
.

The idea of the proof is to define the set
\begin{equation}\label{eq.dA}
𝒜
= \{r ∈ [0,1); \exists (t,ε_0, ε_1, φ), \  w(t,x) ≤ 0,\  ∂_t w(t,x) ≤ 0 \ \mbox{for a.e.} \ \  x ∈ ℝ \}

and show that
$𝒜$
covers the whole interval
$[0,1),$
i.e.
\begin{equation}\label{Asup}
    \begin{aligned}
        𝒜 \supset [0,1).
    
We start with a sufficient condition that guaranties
$∂_t w(t,x) ≤ 0$
for almost every
$x ∈ ℝ.$
#lemma[
\label{lemma:condition_for_negative_speed}
Let the assumption of Lemma @lemma:estaimte_of_u_devided //[ref type:ref]
be satisfied.
Let $ρ$ be the parameter from assumption @eq:shape_assumption //[ref type:eqref]
and $c_0$ be a number close to $1/4.$
If $C(t,r,ρ,c_0)$ defined by @eq.dC //[ref type:eqref] satisfies the estimate
	\begin{equation}\label{eq.a1}
	(c_0)/(2) C(t,r,ρ,c_0)
	≤ ( //[command type:bigg]
	1 - r ( //[command type:bigg]
	ρ + (1)/(2) ) //[command type:bigg]
 ) //[command type:bigg]
 ( //[command type:bigg]
	(1)/(2t) - \frac ρ 2 ) //[command type:bigg]

then $∂_t w(t,x) ≤ 0$ for a.e. $x ∈ ℝ.$
] //[Lemma]
#proof[
The D'Alembert formula gives
\begin{equation}
    \begin{aligned}
   &∂_t w(t,x)\\
	&= ε_0 (φ^'(x+t)- φ^'(x-t))/(2) 
	+ ( //[command type:left]
	ε_1 + (ε_0)/(2) ) //[command type:right]
 (φ(x+t) + φ(x-t))/(2) \\
    & + ∫_0^t (d)/(dt) W(t-τ)( //[command type:left]
	( //[command type:left]
	(1)/(4)+u(τ)|u(τ)|^{p-2}) //[command type:right]
 w(τ) ) //[command type:right]
 (x) dτ.
    
Then using @eq2mm //[ref type:eqref] in  Lemma @lemma:estimate_of_transformed_wave //[ref type:ref],
we obtain 
	$ &∫_0^t (d)/(dt) W(t-τ)( //[command type:left]
	( //[command type:left]
	(1)/(4)+u(τ)|u(τ)|^{p-2}) //[command type:right]
 w(τ) ) //[command type:right]
 (x) dτ \\
	& ≤ c_0 ∫_0^t (d)/(dt) W(t-τ) ( w(τ) ) (x) dτ \\
	&=  (c_0)/(2)∫_0^t ( //[command type:left]
	w(τ, x+t-τ) +  w(τ, x-t+τ) ) //[command type:right]
 dτ \\
	& ≤ (c_0)/(2)max_{0≤ τ ≤ t} ( |ε_0 + τ(ε_1 + ε_0/2)|)/((1-c_0 τ^2-2c_0ρ τ^2 - 3 ρ τ))
	∫_0^t ( //[command type:left]
	φ(x+t-τ) +  φ( x-t+τ) ) //[command type:right]
 dτ\\
	& ≤ (c_0)/(2)| ε_1 | C(t,r) ∫_{-t}^t  φ(x+σ) dσ. $ //[formula type:align*]

Using  @eq:shape_assumption //[ref type:eqref], we obtain
	$ &∂_t w(t,x)\\
	&≤ ε_0 (φ^'(x+t)- φ^'(x-t))/(2) 
	+ ( //[command type:left]
	ε_1 + (ε_0)/(2) ) //[command type:right]
 (φ(x+t) + φ(x-t))/(2) \\
	& + (c_0)/(2) |ε_1| C(t,r) ∫_{-t}^t  φ(x+σ) dτ\\
	& ≤ ( //[command type:left]
	ε_0 ρ + ε_1 + (ε_0)/(2)) //[command type:right]
(φ(x+t) + φ(x-t))/(2)
	+ (c_0)/(2)| ε_1 | C(t,r)
	∫_{-t}^t  φ(x+σ) dσ. $ //[formula type:align*]

Lemma @l3 //[ref type:ref] implies
	$ \label{eq.HH1m1}
	(φ(x+t) + φ(x-t))/(2)
	≥  ( //[command type:left]
	(1)/(2t) - \frac ρ 2 ) //[command type:right]

	∫_{-t}^t  φ(x+σ) dτ. $ //[formula type:align]

Then we estimate
	$ \label{HH2}
	∂_t w(t,x)
	&≤ |ε_1| A(t,r) ∫_{-t}^t  φ(x+σ) dτ, $ //[formula type:align]
where 
	$ A(t,r) =
	- ( //[command type:bigg]
	1 - r ( //[command type:bigg]
	ρ + (1)/(2) ) //[command type:bigg]
 ) //[command type:bigg]
 ( //[command type:bigg]
	(1)/(2t) - \frac ρ 2 ) //[command type:bigg]

	+ (c_0)/(2) C(t,r, ρ,c_0). $ //[formula type:display]
Therefore, the condition @eq.a1 //[ref type:eqref] implies $A(t,r) ≤ 0$
and hence $∂_t w(t,x) ≤ 0$ a.e.
This completes the proof.
] //[proof]
#lemma[
\label{lemma:condition_for_negative_position}
Let the assumption of Lemma @lemma:estaimte_of_u_devided //[ref type:ref]
be satisfied.
If the inequality
	\begin{equation}\label{eq.a2}
   (c_0)/(2)t  C(t,r,ρ,c_0)
	≤ \frac 1 2 - ( //[command type:bigg]
	(2ρ+1)/(4) + (1)/(2t)) //[command type:bigg]
 r
	
holds, then
$ w (t,x) ≤ 0$ for a.e. $x ∈ ℝ$.
Here $C(t,r,ρ,c_0)$ is defined in @eq.dC //[ref type:eqref].
] //[Lemma]
#proof[
We have
     $ &w(t,x)\\
	&≤ ε_0 (φ(x+t)+ φ(x-t))/(2) 
	+ ( //[command type:left]
	ε_1 + (ε_0)/(2) ) //[command type:right]
 ∫_{-t}^{t}(φ(x+τ))/(2) dτ \\
	& + (c_0)/(2)|ε_1| C(t,r) ∫_0^t ∫_{τ-t}^{t-τ}φ(x+σ) dσ dτ\\
	&≤
	- |ε_1|
	\bigg\{
		\frac 1 2
		- ( //[command type:bigg]
	(2ρ+1)/(4) + (1)/(2t)) //[command type:bigg]
 r
		- (c_0)/(2) t  C(t,r)
	\bigg\}
	∫_{-t}^t φ(x+σ) dσ. $ //[formula type:align*]
] //[proof]
In view of the above Lemmas
@lemma:estaimte_of_u_devided //[ref type:ref]
,
@lemma:condition_for_negative_speed //[ref type:ref]
,
and
@lemma:condition_for_negative_position //[ref type:ref]
,
$𝒜$
contains the following set.
	$
	
	ℬ
	= \{r ∈ [0,1); \e x i s t s (t,c_0,ρ)\
	\m a t h r m{s a t i s f y i n g}\
	\e q r e f{e q:c o n d i t i o n_fo r_u_d e v i d e d},\
	\e q r e f{e q.a1},\
	\m a t h r m{a n d}\ \e q r e f{e q.a2}\}
	
	$ //[formula type:display]

Indeed, if
$r ∈ ℬ$
, then
there exits
$(ε_0, ε_1, φ)$
such that
$r=ε_0/|ε_1|$
and the assumptions
@eq:condition_for_u_devided //[ref type:eqref]
is satisfied.
Therefore,
$r ∈ 𝒜$
.

The definition
@eq.dC //[ref type:eqref]
and Corollary
@c62 //[ref type:ref]
imply
	\begin{equation}
	C(t,r,0,1/4) =
	\begin{cases}
	(t(1-r/2)-r )/((1-t^2/4))
	& \mbox{if} \ r < 4t/(8+2t-t^2),\\
	r
	& \mbox{if} \ r > 4t/(8+2t-t^2).
	
Therefore, a sufficient condition for
$r ∈ ℬ$
is that whether
$r ∈ [0,1)$
satisfies
that there exists
$t ∈ (0,2)$
such that
{\color{blue} A sufficient condition for
$r∈ B$
is that
$r ∈ (0,1)$
and there exists
$t$
such that 
}

the following two inequalities hold:
	\begin{equation}\label{sys1}
	\begin{cases}
	(1)/(8)  ( //[command type:left]
	(t(1-r/2)-r )/((1-t^2/4))  ) //[command type:right]

	< ( //[command type:bigg]
	1 - (r)/(2)  ) //[command type:bigg]
 ( //[command type:bigg]
	(1)/(2t) ) //[command type:bigg]
,\\
	(1)/(8) t  ( //[command type:left]
	(t(1-r/2)-r )/((1-t^2/4))  ) //[command type:right]

	< 1 - ( //[command type:bigg]
	(1)/(2) + (1)/(2t)) //[command type:bigg]
 r,\\
	r
	< (4t)/((4-t)(2+t))
	
and
	\begin{equation}\label{sys2}
	\begin{cases}
	(1)/(8)  r
	< ( //[command type:bigg]
	1 - (r)/(2)  ) //[command type:bigg]
 ( //[command type:bigg]
	(1)/(2t) ) //[command type:bigg]
,\\
	(1)/(8) t  r
	< \frac 1 2 - ( //[command type:bigg]
	(1)/(4) + (1)/(2t)) //[command type:bigg]
 r,\\
	r > (4t)/((4-t)(2+t)).
	
In particular, if
$r ∈ [0,1)$
admits some
$t ∈ (0,2)$
such that
$(t,r)$
satisfies either
@sys1 //[ref type:eqref]
or
@sys2 //[ref type:eqref]
,
then one can choose
$c_0$
sufficiently close to
$1/4$
and
$ρ>0$
sufficiently small
so that the assumptions
@eq:condition_for_u_devided //[ref type:eqref]
,
@eq.a1 //[ref type:eqref]
and
@eq.a2 //[ref type:eqref]
in Lemmas
@lemma:condition_for_negative_speed //[ref type:ref]
and
@lemma:condition_for_negative_position //[ref type:ref]
are satisfied.
Consequently,
$ℬ$
contains the following set:
	$
	
	𝒞
	= \{r ∈ [0,1); \e x i s t s t, \ (t,r) \ \m b o x{i s a s o l u t i o n t o \e q r e f{s y s2}}\}.
	
	$ //[formula type:display]

Finally, we show that
$𝒞 \supset [0,1)$
.
The system
@sys2 //[ref type:eqref]
is equivalent to
	$
	c a s e s(
	r <   (4)/(2+t),\
	r < (8t)/((2+t)^2),\
	r > (4t)/((4-t)(2+t)).
	)
	$ //[formula type:align]
A positive solution
$r$
can be found iff
	$
	
	(4t)/((4-t)(2+t)) < min ( //[c o m m a n d t y p e:l e f t]
	(4)/(2+t), (8t)/((2+t)^2)  ) //[c o m m a n d t y p e:r i g h t]
 .
	
	$ //[formula type:display]

Note that for
$t ∈ [0,4)$
	$
	
	(4t)/((4-t)(2+t)) < (4)/(2+t)
	
	$ //[formula type:display]

is equivalent to
$t <2$
and
	$
	
	(4t)/((4-t)(2+t)) < (8t)/((2+t)^2)
	
	$ //[formula type:display]

is equivalent to
$t <2.$
Therefore the interval
	$
	I(t)  &= (a(t),b(t)), \
	a(t)  &= (4t)/((4-t)(2+t)) , \
	b(t)  &= min ( //[c o m m a n d t y p e:l e f t]
	(4)/(2+t), (8t)/((2+t)^2)  ) //[c o m m a n d t y p e:r i g h t]
	$ //[formula type:align*]
is nonempty for any
$t ∈ (0,2).$
Note that
	$
	
	(8t)/((2+t)^2) < (4)/(2+t)
	
	$ //[formula type:display]

for
$t ∈ (0,2).$
Therefore,
	$
	
	b(t) = (8t)/((2+t)^2).
	
	$ //[formula type:display]

The function
$a$
is increasing on
$[0,4)$
, because
	$
	
	a(t)
	= (4)/(4-t)( //[c o m m a n d t y p e:b i g g]
	1 - (2)/(t+2) ) //[c o m m a n d t y p e:b i g g]
.
	
	$ //[formula type:display]

Moreover,
$a(0)=0 $
and
$ a(2)=b(2)=1$
imply that
	$
	
	𝒜 \s u p s e t ℬ \s u p s e t 𝒞 \s u p s e t [0,1).
	
	$ //[formula type:display]

This completes the proof.
\bibliographystyle{plain}

// %\bibliography{L1Dec}
// %\bibliography{DIA}
\bibliography{GlobalSOLNEG/DIA}
// %\bibliography{../DIA}
// %\bibliography{GlobalSOLNEG/DIA}

// %]]]

// %\bibliographystyle{plain}
// %\bibliography{DAMP}
