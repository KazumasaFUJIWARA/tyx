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
// \end{abstract}

// \maketitle

// %[[[
# Introduction
# Introduction
// %[[[ In this note,
In this note,
we consider the behavior of solutions
to the Cauchy problem for the semilinear damped wave equation
	$
	cases(
	\partial_(t)^(2) u+\partial_(t) u-\Delta u=|u|^p\, &= t>0\, x \in \mathbb R^(n)\, \
	u(0)=u_(0)\, \partial_(t) u(0)=u_(1)\, &= x \in \mathbb R^(n) .
	)
	$ //[formula type:align]
The aim of this manuscript
is to establish the global existence of solutions
under the initial conditions
	$
		 &= \left(u_(0), u_(1)\right)=\left(\varepsilon_(0) \varphi, \varepsilon_(1) \varphi\right), \
	 &= 0 < \varepsilon_(0) < |\varepsilon_(1)| = - \varepsilon_(1).
	$ //[formula type:align]
with
$n = 1$
,
$\left(\varepsilon_(0), \varepsilon_(1)\right) \in \mathbb{R}^2$
small,
and
$\varphi$
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
	cases(
	\partial_(t)^(2) u + \partial_(t) u - \Delta u = 0\,\
	u(0) = u_(0)\, \partial_(t) u(0) = u_(1).
	)
	$ //[formula type:align]
// %]]]
 
// %[[[ An explicit representation of solutions to
@eq:linear_damped_wave //[ref type:eqref]
An explicit representation of solutions to
@eq:linear_damped_wave //[ref type:eqref]
is derived through the substitution
$u(t,x)=e^(-t/2)w(t,x)$
,
which transforms
@eq:linear_damped_wave //[ref type:eqref]
into the wave-type equation
	$
	\partial_(t)^(2) w - \Delta w = (1)/(4) w,
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
$\overline{u_(0)} ≥ \underline{u_(0)} $
and
$\overline{u_(1)} + \overline{u_(0)}/2 ≥ \underline{u_(1)} + \underline{u_(0)}/2$
,
then the solutions
$\overline{u}$
of
@eq:DW //[ref type:eqref]
with
$\overline{u_(0)}, \overline{u_(1)}$
and
$\underline{u}$
with
$\underline{u_(0)}, \underline{u_(1)}$
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
$(u_(0),u_(1))=(0,f)$
.
// %]]]

// %[[[ Owing to the damping term
$\partial_(t) u$
,
Owing to the damping term
$\partial_(t) u$
,
the free solution to
@eq:DW //[ref type:eqref]
is
asymptotically equivalent to the solution of the free heat equation:
	$
	cases(
	\partial_(t) v - \Delta v = 0\,\
	v(0) = u_(0) + u_(1).
	)
	$ //[formula type:align]
For simplicity, we denote by
$e^(t \Delta) f$
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
	\sim e^(t \Delta) f + e^(-t/2) W(t) f.
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
$L^(p)$
–
$L^(q)$
type estimates
as
$e^(t \Delta)$
.
Therefore, the following local existence result holds:
#lemma(title: "Local existence", id: "lemma:local_existence")[
Assume that
$(u_0,u_1) \in W^{1,\infty} \cap W^{1,1} \times L^\infty \cap L^1$ and $p > 1$ and $n =1$.
There exists
$T_1=T_1(u_0,u_1)$
such that @eq:DW //[ref type:eqref] possesses a unique mild solution
$u \in C\left(\left[0, T_1\right) ;W^{1,\infty} \cap W^{1,1}\right)$
satisfying the estimate
	\begin{align}\label{eq2}
	\sup _{0 \leq t \leq T_1} \|u(t) \|_{ L^{\infty}}
	\lesssim ( \|u_0 \|_{L^\infty} + \|u_1 \|_{L^\infty}).
	\end{align}
] //[Lemma]
$(u_(0),u_(1)) \in W^(1,∞) \cap W^(1,1) × L^∞ \cap L^(1)$
and
$p > 1$
and
$n =1$
.
There exists
$T_(1)=T_(1)(u_(0),u_(1))$
such that
@eq:DW //[ref type:eqref]
possesses a unique mild solution
$u \in C\left(\left[0, T_(1)\right) ;W^(1,∞) \cap W^(1,1)\right)$
satisfying the estimate
	$
		\sup _{0 ≤ t ≤ T_(1)} \|u(t) \|_{ L^(∞)}
	\lesssim ( \|u_(0) \|_{L^∞} + \|u_(1) \|_{L^∞}).
	$ //[formula type:align]
\end{Lemma}
\noindent
Here
$W^(1,q)$
for
$1 ≤ q ≤ ∞$
denotes the usual Sobolev space,
a collection of measurable functions
$f$
such that both
$f$
and its weak derivative
$f^\prime$
belong to
$L^(q)$
.
We also note that
$p=1+2/n$
is the so-called Fujita critical exponent,
which gives the threshold for blow-up of positive solutions to
@eq:DW //[ref type:eqref]
and for the existence of global solutions to the Fujita-type heat equation:
	$
	\partial_(t) v - \Delta v = |v|^p.
	$ //[formula type:align]
For details, see
@F66,H73,KST77 //[ref type:cite]
.
We also remark that when
$n \in \mathbb N$
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
$e^(t \Delta)(u_(0) + u_(1))$
—that is,
as if
$u$
behaved like the heat flow generated by the initial mass
$u_(0)+u_(1)$
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
	∫ u_(0) + u_(1) dx > 0,
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
$e^(t \Delta) (u_(0) + u_(1))$
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
		∫ u_(0) + u_(1) dx = 0,
	\quad
	u_(0), u_(1) \not≡ 0.
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
$\mu_(0), \mu_(1) \in \mathbb{R}$
,
by combining the finite propagation speed
with the arguments above,
for any
$\mu_(0), \mu_(1) \in \mathbb{R}$
,
there exist smooth initial data
$(u_(0), u_(1))$
satisfying
$
	
	∫ u_(0) dx = \mu_(0),
	\quad
	∫ u_(1) dx = \mu_(1),
	
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
		u_(0)(x) &= = ψ(x) + (\mu_(0)-1) ψ(x-L), \
	u_(1)(x) &= = \mu_(1) ψ(x-L),
	$ //[formula type:align*]
then one can show
$u(t,x) = u_(b)(t,x) + u_(g)(t,x-L)$
till some time,
where
$u_(b)$
is the blow-up solution with initial data
$(u_(0), u_(1)) = (ψ,0)$
and
$u_(g)$
is the solution with initial data
$(u_(0), u_(1)) = ((\mu_(0)-1)ψ, \mu_(1) ψ)$
.
Since the argument above implies that
$∫ u_(b) + \partial_(t) u_(b) dx$
blows up in finite time
and
$∫ u_(g) + \partial_(t) u_(g) dx$
is increasing,
there exists a time
$t_(0)$
such that
$
	
	∫ u(t_(0)) + \partial_(t) u(t_(0)) dx
	= ∫ u_(b)(t_(0)) + \partial_(t) u_(b)(t_(0)) dx + ∫ u_(g)(t_(0)) + \partial_(t) u_(g)(t_(0)) dx
	> 0.
	
$ //[formula type:display]
Therefore, the solution
$u$
blows up in finite time
by the same argument from
$t=t_(0)$
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
		u_(0)(x) = 0,
	\quad
	u_(1)(x) ≤ 0.
	$ //[formula type:align]
This was further extended to
	$
		u_(0)(x) ≤ 0,
	u_(1)(x) + \frac 1 2 u_(0)(x) ≤ 0.
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
$c_(0) > 0$
such that, for
$
	
	0 < \varepsilon_(0) < c_(0) |\varepsilon_(1)| \ll 1,
	
$ //[formula type:display]
there exists a smooth, positive function
$\varphi$
such that
the solution with initial data
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
exists globally in time?
To the best of the authors' knowledge,
global existence for
@eq:DW //[ref type:eqref]
has only been established via comparison arguments.
Accordingly, we employ the following simple sufficient condition for global existence:
there exist a constant
$c_(0) > 0$
and a smooth, positive function
$\varphi$
such that, for
$
	
	\varepsilon_(0) < c_(0) |\varepsilon_(1)| \ll 1,
	
$ //[formula type:display]
the solution
$u$
with initial data
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
satisfies
	$
	u(t,x) ≤ 0,\ \ \partial_(t) u(t,x) + (1)/(2)u(t,x) ≤ 0
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
	\begin{align}
	0 < \varepsilon_0 < -\varepsilon_1 \ll 1.
	\label{eq:condition_ratio}
	\end{align}
Then there exists a sufficiently small number $\rho$ and
a positive function $\varphi \in W^{2,1} \cap W^{2,\infty}$
satisfying the following pointwise control
	\begin{align}\label{eq:shape_assumption} \tag{H1}
	|\varphi^\prime(x)| + |\varphi^{\prime\prime} (x)| \leq \rho  \varphi(x) , \ \ \forall x \geq 0
	\end{align}
and the mild solution $u \in C([0,T_0) \times \mathbb{R})$ to @eq:DW //[ref type:eqref]
with initial data $(u_0,u_1) = (\varepsilon_0 \varphi, \varepsilon_1 \varphi)$
exists and satisfies the pointwise estimates @eq:aim //[ref type:eqref]
at time
	\[
	t(\varepsilon_0/|\varepsilon_1|)+\delta \in (0,2),
	\]
where $\delta>0$ is sufficiently small
and $t=t(\varepsilon_0/|\varepsilon_1|)$ is the unique positive solution 
of 
	\begin{align}\label{eq.deft}
	\frac{\varepsilon_0}{|\varepsilon_1|} =  \frac{4t}{(4-t)(2+t)}.
	\end{align}
] //[Theorem]
	$
	0 < \varepsilon_(0) < -\varepsilon_(1) \ll 1.
	$ //[formula type:align]
Then there exists a sufficiently small number
$ρ$
and
a positive function
$\varphi \in W^(2,1) \cap W^(2,∞)$
satisfying the following pointwise control
	$
		\tag{H1}
	|\varphi^\prime(x)| + |\varphi^(\prime\prime) (x)| ≤ ρ  \varphi(x) , \ \ \forall x ≥ 0
	$ //[formula type:align]
and the mild solution
$u \in C([0,T_(0)) × \mathbb{R})$
to
@eq:DW //[ref type:eqref]
with initial data
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
exists and satisfies the pointwise estimates
@eq:aim //[ref type:eqref]
at time
$
	
	t(\varepsilon_(0)/|\varepsilon_(1)|)+δ \in (0,2),
	
$ //[formula type:display]
where
$δ>0$
is sufficiently small
and
$t=t(\varepsilon_(0)/|\varepsilon_(1)|)$
is the unique positive solution 
of
	$
	(\varepsilon_(0))/(|\varepsilon_(1)|) =  (4t)/((4-t)(2+t)).
	$ //[formula type:align]
\end{Theorem}

We give some remarks on Theorem
@theorem:main //[ref type:ref]
.
First,
the condition
@eq:condition_ratio //[ref type:eqref]
is optimal.
Indeed, for
$\varepsilon_(0) + \varepsilon_(1) ≥ 0$
,
we can apply Theorem 1.1 in
@FG25a //[ref type:cite]
and deduce blow-up.
Second,
for any positive
$ρ$
,
there exists a function
$\varphi \in W^(2,1) \cap W^(2,∞)$
satisfying
@eq:shape_assumption //[ref type:eqref]
.
Indeed, let
$N$
be an integer,
$a >1$
, and
$
	
	\varphi(x) = (N^(2)+x^(2))^{-a/2}
	
$ //[formula type:display]
then
$\varphi \in W^(2,1) \cap W^(2,∞)$
and
	$
		|\varphi^\prime(x)| &= ≤ (a)/(N) \varphi(x),\
	|\varphi^(\prime\prime)(x)| &= ≤ (a(a+1))/(N^(2)) \varphi(x),
	$ //[formula type:align*]
so
$ρ = a/N + a(a+1)/N^(2) \to 0$
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
$\varphi$
pointwisely up to a certain time,
and this pointwise control implies the conclusion.
Finally,
the function
$
	
	a(t) = (4t)/((4-t)(2+t))
	
$ //[formula type:display]
is strictly increasing for
$t \in (0,2)$
, with
$a(0)=0$
and
$a(2)=1$
.
Therefore, the unique positive solution
$t \in (0,2)$
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
$t \in (0,2)$
is elementary
and can be found at the end of the proof of Theorem
@theorem:main //[ref type:ref]
.

We note that
it is still unclear whether
there exists a global solution to
@eq:DW //[ref type:eqref]
in the case where
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
with smooth positive
$\varphi$
and
$\varepsilon_(0)$
and
$\varepsilon_(1)$
are sufficiently small and satisfy
$
	
	\varepsilon_(0) < 0,\quad
	\varepsilon_(1) > 0,\quad
	\varepsilon_(0) + \varepsilon_(1) < 0,\quad
	\mbox{and} \
	\varepsilon_(1) + \varepsilon_(0)/2 > 0.
	
$ //[formula type:display]
In the next section, we collect some preliminary estimates.
Theorem
@theorem:main //[ref type:ref]
is shown in the last section.
// %]]]
# Preliminary
We, at first, show the estimate
for the solution to the Cauchy problem for a nonhomogeneous wave equation.
#lemma(id: "lemma:estimate_of_transformed_wave")[
Let $g \in W^{1,\infty}$ and $f, w \in L^\infty(0,2;L^\infty)$.
Then there exists a unique $L^\infty$ valued mild solution $v$
to the following Cauchy problem:
	\[
	\begin{cases}
	\partial_t^2 v + \partial_t v - \partial_x^2 v  = f w+g \partial_x w,\\
	v(0,x)= \varepsilon_0,\\
	\partial_t v(0,x)= \varepsilon_1.
	\end{cases}
	\]
Moreover, $v$ enjoys the following estimate:
	\begin{align}
	\|v(t)\|_{L^\infty}
	& \leq \varepsilon_0 e^{-t} + (\varepsilon_0 + \varepsilon_1) (1-e^{-t})\\
	& + C t \bigg(
		\|f\|_{L^\infty(0,t; L^\infty)} + \| g \|_{W^{1,\infty}}
	\bigg) \|w\|_{L^\infty(0,t; L^\infty)}.
	\label{1dmax}
	\end{align}
] //[Lemma]
$g \in W^(1,∞)$
and
$f, w \in L^∞(0,2;L^∞)$
.
Then there exists a unique
$L^∞$
valued mild solution
$v$
to the following Cauchy problem:
$
	
	cases( \partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v  = f w+g \partial_(x) w,\\
	v(0,x)= \varepsilon_(0),\\
	\partial_(t) v(0,x)= \varepsilon_(1).
	)
	
$ //[formula type:display]
Moreover,
$v$
enjoys the following estimate:
	$
		\|v(t)\|_{L^∞}
	 &= ≤ \varepsilon_(0) e^(-t) + (\varepsilon_(0) + \varepsilon_(1)) (1-e^(-t))\
	 &= + C t \bigg(
	\|f\|_{L^∞(0,t; L^∞)} + \| g \|_{W^(1,∞)}
	\bigg) \|w\|_{L^∞(0,t; L^∞)}.
	$ //[formula type:align]
\end{Lemma}
// Unknown node type: NodeType.PROOF
	$
		v(t,x)
	 &= = \varepsilon_(0) e^(-t)
	+ ( \varepsilon_(0) + \varepsilon_(1) )(1-e^(-t))\
	 &= + \int_(0)^(t) S(t-τ) f(τ) w(τ)(x) dτ
	+ \int_(0)^(t) S(t-τ) g \partial_(x) w(τ,x) dτ,
	$ //[formula type:align*]
where
$
	
	S(t) h(x)
	= (1)/(2) e^(-t/2) \int_(-t)^{t} I_(0) \bigg( \frac{\sqrt{t^(2)-y^(2)}}{2} \bigg) h(x+y) d y.
	
$ //[formula type:display]
We note that by denoting
$ω = \sqrt{t^(2)-y^(2)}$
we have
$
	
	e^(-t/2) I_(0) \bigg( (ω)/(2) \bigg)
	≤ \langle ω \rangle^(-1/2) e^((ω - t/2))
	≤ C \langle t \rangle^(-1/2) e^(-y^(2)/8t).
	
$ //[formula type:display]
Therfore, a straightforward calculation shows that
$
	
	\| S(t-τ) f(τ) w(τ) \|_{L^∞}
	≤ C \| f(τ) \|_{L^∞} \| w(τ) \|_{L^∞}.
	
$ //[formula type:display]
We note that by writing
$σ = t-τ$
we have
	$
		e^(σ/2) S(σ) g \partial_(x) w(τ)(x)
	 &= = \int_(-σ)^{σ} I_(0) \bigg( \frac{\sqrt{σ^(2)-y^(2)}}{2} \bigg) g(x+y) \partial_(x) w(τ, x+y) dy\
	 &= = g(x+σ) w(τ,x+σ) - g(x-σ) w(τ,x-σ)\
	 &= - \int_(-σ)^{σ} I_(0) \bigg( \frac{\sqrt{σ^(2)-y^(2)}}{2} \bigg) \dot g(x+y) w(τ,x+y) dy\
	 &= + \int_(-σ)^{σ} I_(1) \bigg( \frac{\sqrt{σ^(2)-y^(2)}}{2} \bigg) (y)/(\sqrt{σ^(2)-y^(2))} g(x+y) w(τ,x+y) dy.
	$ //[formula type:align*]
We note that by writing
$ω = \sqrt{σ^(2)-y^(2)}$
,
we have
$
	
	\bigg| e^(-σ/2) (y)/(ω) I_(1)(ω/2) \bigg|
	≤ C (y)/(\langle ω \rangle^(3/2)) e^((ω - σ)/2)
	≤ C \langle σ \rangle^(-1/2) e^(-y^(2)/8σ).
	
$ //[formula type:display]
Thereore, we have
$
	
	\| S(t-τ) g(τ) \partial_(x) w(τ) \|_{L^∞}
	≤ C \| g \|_{W^(1,∞)} \| w(τ) \|_{L^∞}
	
$ //[formula type:display]
and this implies
@1dmax //[ref type:eqref]
.
\end{proof}

By using Lemma
@lemma:estimate_of_transformed_wave //[ref type:ref]
,
we mesure the difference between
$u(t)$
and initial position
$\varphi$
under a certain condition by using their ratio.
#lemma(title: "Refined local estimates")[
\label{lemma:estaimte_of_u_devided}
Let $\varepsilon_0$ and $\varepsilon_1$ are real constans sufficiently close to $0$
satisfying $0 < \varepsilon_0 < - \varepsilon_1$.
Let $t \in (0,T_0)$ and $\rho >0$ satisfy
	\begin{align}
	C ( |\varepsilon_1|^{p-1} + \rho ) t < 1
	\label{eq:condition_for_u_devided}
	\end{align}
with a positive constant $C$.
Assume that $\varphi \in W^{2,1} \cap W^{2,\infty}$
satisfy @eq:shape_assumption //[ref type:eqref].
If the mild solution $u$ of Lemma @lemma:local_existence //[ref type:ref]
with initial data $(u_0,u_1) = (\varepsilon_0,\varepsilon_1)$
satsify 
	\[
	\| |u|^{p-2}u\|_{L^\infty(0,T_0; L^\infty)}
	+ \bigg\|\frac{\ddot \varphi}{\varphi} \bigg\|_{L^\infty}
	+ \bigg\|\frac{\dot \varphi^2}{\varphi^2} \bigg\|_{L^\infty}
	\leq C ( \varepsilon_1^{p-1} + \rho ).
	\]
Then $u$ enjoys the following estimate for $t \in (0,T_0)$:
	\begin{align}\label{eq2mm}
	\left\| \frac{u(t)}{\varphi} \right\|_{ L^{\infty}}
	\leq \frac{|\varepsilon_0 e^{-t} + (\varepsilon_1 + \varepsilon_0)(1-e^{-t})|}{1-C ( |\varepsilon_1|^{p-1} + \rho ) t}.
	\end{align}
] //[Lemma]
$\varepsilon_(0)$
and
$\varepsilon_(1)$
are real constans sufficiently close to
$0$
satisfying
$0 < \varepsilon_(0) < - \varepsilon_(1)$
.
Let
$t \in (0,T_(0))$
and
$ρ >0$
satisfy
	$
	C ( |\varepsilon_(1)|^{p-1} + ρ ) t < 1
	$ //[formula type:align]
with a positive constant
$C$
.
Assume that
$\varphi \in W^(2,1) \cap W^(2,∞)$
satisfy
@eq:shape_assumption //[ref type:eqref]
.
If the mild solution
$u$
of Lemma
@lemma:local_existence //[ref type:ref]
with initial data
$(u_(0),u_(1)) = (\varepsilon_(0),\varepsilon_(1))$
satsify
$
	
	\| |u|^{p-2}u\|_{L^∞(0,T_(0); L^∞)}
	+ \bigg\|(\ddot \varphi)/(\varphi) \bigg\|_{L^∞}
	+ \bigg\|(\dot \varphi^(2))/(\varphi^(2)) \bigg\|_{L^∞}
	≤ C ( \varepsilon_(1)^(p-1) + ρ ).
	
$ //[formula type:display]
Then
$u$
enjoys the following estimate for
$t \in (0,T_(0))$
:
	$
		\left\| (u(t))/(\varphi) \right\|_{ L^(∞)}
	≤ \frac{|\varepsilon_(0) e^(-t) + (\varepsilon_(1) + \varepsilon_(0))(1-e^(-t))|}{1-C ( |\varepsilon_(1)|^{p-1} + ρ ) t}.
	$ //[formula type:align]
\end{Lemma}
// Unknown node type: NodeType.PROOF
$
	
	v(t,x) = (u(t,x))/(\varphi(x)),
	
$ //[formula type:display]
so we have
	$
		\partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v
	= (|u|^p)/(\varphi)
	+ 2 (\dot \varphi \partial_(x) u)/(\varphi^(2))
	+ (\ddot \varphi)/(\varphi^(2)) u
	- 2 (\dot \varphi^(2))/(\varphi^(3)) u
	$ //[formula type:align*]
Since
$
	
	\partial_(x) u = v \dot \varphi  + \varphi \partial_(x) v
	
$ //[formula type:display]
we arrive at
$
	
	\partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v \\
	= \bigg( |u|^{p-2} u + (\ddot \varphi)/(\varphi) \bigg) v
	+ 2 (\dot \varphi)/(\varphi) \partial_(x) v
	
$ //[formula type:display]
Therefore, the Cauchy problem can be rewritten as
	$
	cases(
	\partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v  = f v+g\partial_(x)v\, \
	v(0\,x)=\varepsilon_(0) \, &= x \in \mathbb R\, \
	\partial_(t) v(0\,x) =\varepsilon_(1) \, &= x \in \mathbb R.
	)
	$ //[formula type:align*]
with
$
	
	f = |u|^{p-2}u  + (\ddot \varphi)/(\varphi),
	\quad
	g =  2  (\dot \varphi)/(\varphi).
	
$ //[formula type:display]
Noting
$
	
	\dot g = 2 (\ddot \varphi)/(\varphi) - 2 (\dot \varphi^(2))/(\varphi^(2))
	
$ //[formula type:display]
and applying Lemma
@lemma:local_existence //[ref type:ref]
and the assumption
@eq:shape_assumption //[ref type:eqref]
,
$
	
\|f\|_{L^∞(0,T_(0); L^∞)}
≤ C_(1) ( |\varepsilon_(1)|^{p-1} + ρ )

$ //[formula type:display]
and
$\|g\|_{W^(1,∞)} ≤ C_(1) ρ$
with some positive constants
$C_(1)$
.
\end{proof}

Next estimate plays an important role
to estimate the solution on the basis of initial data.
#lemma(title: "Hermite–Hadamard", id: "l3")[
Let $\phi$ be $C^1(\mathbb R; [0,\infty))$,
such that there is a positive constant $\rho$ so that
\begin{align}\label{eq.bb1}
 &  |\dot \phi(x)| \leq \rho  \phi(x) , \ \ \forall x \geq 0.
\end{align}
Then we have
\begin{align}\label{eq.HH1}
      & \frac{ \phi(\alpha) + \phi(\beta)}{2} \leq  \frac{1}{\beta - \alpha} \int_{\alpha}^{\beta} \phi(\sigma) d \sigma + \frac{\rho}{2} \int_{\alpha}^\beta \phi(\sigma) d \sigma
\end{align}
and
\begin{align}\label{eq.HH1mm}
      & \frac{ \phi(\alpha) + \phi(\beta)}{2} \geq  \frac{1}{\beta - \alpha} \int_{\alpha}^{\beta} \phi(\sigma) d \sigma -\frac{\rho}{2} \int_{\alpha}^\beta \phi(\sigma) d \sigma
\end{align}
for $0  \leq  \alpha < \beta < \infty.$
] //[Lemma]
$φ$
be
$C^(1)(\mathbb R; [0,∞))$
,
such that there is a positive constant
$ρ$
so that
	$
	 &= |\dot φ(x)| ≤ ρ  φ(x) , \ \ \forall x ≥ 0
	$ //[formula type:align]
Then we have
	$
	 &= ( φ(α) + φ(β))/(2) ≤  (1)/(β - α) \int_(α)^{β} φ(σ) d σ + (ρ)/(2) \int_(α)^β φ(σ) d \sigm
	$ //[formula type:align]
and
	$
	 &= ( φ(α) + φ(β))/(2) ≥  (1)/(β - α) \int_(α)^{β} φ(σ) d σ -(ρ)/(2) \int_(α)^β φ(σ) d \sigm
	$ //[formula type:align]
for
$0  ≤  α < β < ∞.$
\end{Lemma}
// Unknown node type: NodeType.PROOF
@DA98 //[ref type:cite]
(see Lemma 2.1 in
@DA98 //[ref type:cite]
)
$
	
	( φ(α) + φ(β))/(2) - (1)/(β - α) \int_(α)^{β} φ(σ) d σ
	= (β -  α)/(2) \int_(0)^(1) (1-2t) \dot φ(t α + (1-t)β) dt.
	
$ //[formula type:display]
Then we can write
	$
		( φ(α) + φ(β))/(2) - (1)/(β - α) \int_(α)^{β} φ(σ) d σ
	 &= = (β - α)/(2) \int_(0)^(1) (1-2t) \dot φ(t α + (1-t)β) dt \
	 &= ≤ (β - α)/(2) \int_(0)^1  | \dot φ(t α + (1-t)β)| dt \
	 &= = (1)/(2)\int_(α)^{β} |\dot φ(σ)| d σ.
	$ //[formula type:align*]
Assuming
@eq.bb1 //[ref type:eqref]
, we get
@eq.HH1 //[ref type:eqref]
.

It is easy to extend this estimate also to the cases
$α < 0 < β$
and
$α < β <0$
using the additional assumption that
$φ$
is an even function.
In fact, when
$α < 0 < β$
we define the interval
$J\subset [0,∞)$
with ends
$-α$
and
$β$
and then we can apply
@eq.HH1 //[ref type:eqref]
so we have
	$
		( φ(α) + φ(β))/(2)
	= ( φ(-α) + φ(β))/(2)
	≤  (1)/(|J|) \int_(J) φ(σ) d σ
	+ (ρ)/(2) \int_(J ) φ(σ) d σ.
	$ //[formula type:align]
This completes the proof.
\end{proof}

We finalize this section
by collecting some estimates of calculs to control nonlinaerity.
Consider the function
	$
		C(t,r,ρ,\varepsilon_(1))
	= \sup_(τ \in [0,t]) G(τ,r,ρ,\varepsilon_(1)),
	$ //[formula type:align]
where
$
	
	G(τ,r,ρ,\varepsilon_(1))
	= \frac{ | r + e^(-τ) - 1 |}{1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ}
	
$ //[formula type:display]
under the assumption
@eq:condition_for_u_devided //[ref type:eqref]
is satisfied.
Here
$ρ$
is a positive number and
$\varepsilon_(1)$
is a negative number
which are close to
$0$
.
#lemma(id: "l.61")[
We have the relation
	\[
	C(t,r,\rho, \varepsilon_1)
	= \begin{cases}
	G(t,r,\rho, \varepsilon_1) & \text{if } \quad r < r_1(t), \\
	r & \text{if } \quad r \in [r_1(t), r_2(t)], \\
	G(\min(t,- \log(1-r)),r,\rho, \varepsilon_1) & \text{if } \quad r > r_2(t),
	\end{cases}
	\]
where
	\begin{align*}
	r_1(t)
	&= \frac{1+C | \varepsilon_1|^{p-1} t + C \rho t}{2 + t},\\
	r_2(t)
	&= \frac{1-e^{-\tau}}{C ( |\varepsilon_1|^{p-1} + \rho ) \tau}.
	\end{align*}
] //[Lemma]
$
	
	C(t,r,ρ, \varepsilon_(1))
	= cases( G(t\,r\,ρ\, \varepsilon_(1)) & \text{if } \quad r < r_(1)(t), \\
	r & \text{if } \quad r \in [r_(1)(t), r_(2)(t)], \\
	G(min(t,- log(1-r)),r,ρ, \varepsilon_(1)) & \text{if } \quad r > r_(2)(t),
	)
	
$ //[formula type:display]
where
	$
		r_(1)(t)
	 &= = \frac{1+C | \varepsilon_(1)|^{p-1} t + C ρ t}{2 + t},\
	r_(2)(t)
	 &= = \frac{1-e^(-τ)}{C ( |\varepsilon_(1)|^{p-1} + ρ ) τ}.
	$ //[formula type:align*]
\end{Lemma}
// Unknown node type: NodeType.PROOF
$r < r_(1)(t)$
,
$r \in [r_(1)(t), r_(2)(t)]$
and
$r > r_(2)(t)$
.

We note that
$r_(1)$
is a increasing function and
$r_(2)$
is a decreasing function.
The monotonicity of
$r_(2)$
follows from the fact that
$
	
	\frac{1-e^(-τ)}{τ}
	= \int_(0)^(1) e^(-τ σ) d σ.
	
$ //[formula type:display]
Therfore,
$r \in [r_(1)(t), r_(2)(t)]$
implies that
$
	
	r \in \bigcap_(τ \in [0,t]) [r_(1)(τ), r_(2)(τ)].
	
$ //[formula type:display]
Since
$C δ t < 1$
, we note that
$1-e^(-τ) \in [r_(1)(τ), r_(2)(τ)]$
for any
$τ \in [0,t]$
.
In the case where
$r \in [r_(1)(τ), 1-e^(-τ)]$
, we have
	$
		 &= G(τ,r,ρ, \varepsilon_(1)) ≤ r\
	\Leftrightarrow &= \frac{ 1 - e^(-τ) - r}{1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ} ≤ r\
	\Leftrightarrow &= 1 - e^(-τ) - r ≤ r (1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ)\
	\Leftrightarrow &= r ≥ \frac{1-e^(-τ)}{2-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ} = r_(1)(τ).
	$ //[formula type:align*]
Similarly, in the case where
$r \in [1-e^(-τ), r_(2)(τ)]$
, we have
	$
		 &= G(τ,r,ρ, \varepsilon_(1)) ≤ r\
	\Leftrightarrow &= \frac{ r - 1 + e^(-τ)}{1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ} ≤ r\
	\Leftrightarrow &= r - 1 + e^(-τ) ≤ r (1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ)\
	\Leftrightarrow &= r ≤ \frac{1-e^(-τ)}{C ( |\varepsilon_(1)|^{p-1} + ρ ) τ} = r_(2)(τ).
	$ //[formula type:align*]
These computations imples that
$C(t,r,ρ, \varepsilon_(1)) = r$
for
$r \in [r_(1)(t), r_(2)(t)]$
.

In the case where
$r < r_(1)(t)$
,
$C(t,r,ρ, \varepsilon_(1)) = G(t,r,ρ, \varepsilon_(1))$
because
$C(\cdot,r,ρ, \varepsilon_(1))$
is increasing.

In the case where
$r > r_(2)(t)$
,
we compute
	$
		\partial_τ G(τ,r,ρ, \varepsilon_(1))
	 &= = - \frac{ e^(-τ)}{1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ}
	+ \frac{ C ( |\varepsilon_(1)|^{p-1} + ρ ) (r + e^(-τ) - 1) }{(1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ)^2}\
	 &= = \frac{ C ( |\varepsilon_(1)|^{p-1} + ρ ) (r + ( τ + 1 ) e^(-τ) - 1) - e^(-τ) }{(1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ)^2}\
	 &= = e^(-τ) \frac{ C ( |\varepsilon_(1)|^{p-1} + ρ ) ( τ + 1) - 1 - (1-r) C ( |\varepsilon_(1)|^{p-1} + ρ ) e^τ }{(1-C ( |\varepsilon_(1)|^{p-1} + ρ ) τ)^2}.
	$ //[formula type:align*]
So
$\partial_τ G(0,r,ρ, \varepsilon_(1)) < 0$
.
Moreover, we also compute
	$
		 &= \partial_τ \{ C ( |\varepsilon_(1)|^{p-1} + ρ ) ( τ + 1) - 1 - (1-r) C ( |\varepsilon_(1)|^{p-1} + ρ ) e^τ \}\
	 &= = C ( |\varepsilon_(1)|^{p-1} + ρ ) (1 - (1-r) e^τ).
	$ //[formula type:align*]
This implise that
$
	
	C(t,r,ρ, \varepsilon_(1)) = G(min(t,- log(1-r)),r,ρ, \varepsilon_(1)).
	
$ //[formula type:display]
\end{proof}
#corollary(id: "c62")[
We have the relation
	\begin{align}
	C(t,r,0,1/4) =
	\begin{cases}
	\frac{t(1-r/2)-r }{(1-t^2/4)}
	& \mbox{if} \quad r < r_t,\\
	r
	& \mbox{if} \quad r \geq r_t,
	\end{cases}
	\end{align}
where
	\[
	r_t
	= \frac{4t}{8+2t-t^2}
	= \frac{4t}{(4-t)(2+t)}.
	\]
] //[Corollary]
	$
		C(t,r,0,1/4) =
cases(
	(t(1-r/2)-r )/((1-t^(2)/4)) &= \mbox{if} \quad r < r_(t)\,\
	r &= \mbox{if} \quad r ≥ r_(t)\,
	)
	$ //[formula type:align]
where
$
	
	r_(t)
	= (4t)/(8+2t-t^(2))
	= (4t)/((4-t)(2+t)).
	
$ //[formula type:display]
\end{Corollary}

// %[[[
# Comparison principle
# Proof of Theorem \ref{theorem:main
@theorem:main //[ref type:ref]
}
// %[[[ Proposition Comparison Principle
$w = e^(t/2) u$
is a solution to the Cauchy problem
	$
	cases(
	\partial_(t)^(2) w - \Delta w = \left((1)/(4) + u|u|^{p-2} \right) w\, &= t \in (0\,T_(0))\, \
	x \in \mathbb R\,\
	w(0)=\varepsilon_(0) \varphi(x)\, &= x \in \mathbb R\,\
	\partial_(t) w(0) =\varepsilon_(1)\varphi(x)+(\varepsilon_(0))/(2)\varphi(x)\, &= x \in \mathbb R.
	)
	$ //[formula type:align]
The D'Alembert formula implies
	$
		 &= w(t) = \varepsilon_(0) (d)/(dt) W(t) (\varphi)(x) + \left(\varepsilon_(1) + (\varepsilon_(0))/(2) \right) W(t)(\varphi)(x)\
	 &= + \int_(0)^(t) W(t-τ)\left( \left((1)/(4)+u(τ)|u(τ)|^{p-2}\right) w(τ) \right) (x) dτ
	$ //[formula type:align*]
where
$
	
	W(t)(f)(x) = (1)/(2) \int_(x-t)^{x+t} f(τ) dτ,
	
$ //[formula type:display]
so
	$
		 &= \partial_(t) w(t,x) =  \varepsilon_(0) \left((d)/(dt)\right)^2 W(t) (\varphi)(x) + \left(\varepsilon_(1) + (\varepsilon_(0))/(2) \right) (d)/(dt) W(t)(\varphi)(x)\
	 &= + \int_(0)^(t) (d)/(dt) W(t-τ)\left( \left((1)/(4)+u(τ)|u(τ)|^{p-2}\right) w(τ) \right) (x) dτ
	$ //[formula type:align*]
Set
$
	
	r = \varepsilon_(0)/|\varepsilon_(1)|
	
$ //[formula type:display]
and
$r\in [0,1)$
follows from the assumption
@eq:condition_ratio //[ref type:eqref]
.

The idea of the proof is to define the set
\begin{equation}\label{eq.dA}
\mathcal{A}
= \{r \in [0,1); \exists (t,\varepsilon_0, \varepsilon_1, \varphi), \  w(t,x) \leq 0,\  \partial_t w(t,x) \leq 0 \ \mbox{for a.e.} \ \  x \in \mathbb{R} \}
\end{equation}
and show that
$\mathcal{A}$
covers the whole interval
$[0,1),$
i.e.
\begin{equation}\label{Asup}
    \begin{aligned}
        \mathcal{A} \supset [0,1).
    \end{aligned}
\end{equation}

We start with a sufficient condition that guaranties
$\partial_(t) w(t,x) ≤ 0$
for almost every
$x \in \mathbb{R}.$
#lemma[
\label{lemma:condition_for_negative_speed}
Let the assumption of Lemma @lemma:estaimte_of_u_devided //[ref type:ref]
be satisfied.
Let $\rho$ be the parameter from assumption @eq:shape_assumption //[ref type:eqref]
and $c_0$ be a number close to $1/4.$
If $C(t,r,\rho,c_0)$ defined by @eq.dC //[ref type:eqref] satisfies the estimate
	\begin{equation}\label{eq.a1}
	\frac{c_0}{2} C(t,r,\rho,c_0)
	\leq \bigg(1 - r \bigg( \rho + \frac{1}{2} \bigg) \bigg) \bigg( \frac{1}{2t} - \frac \rho 2 \bigg)
	\end{equation}
then $\partial_t w(t,x) \leq 0$ for a.e. $x \in \mathbb{R}.$
] //[Lemma]
@lemma:estaimte_of_u_devided //[ref type:ref]
be satisfied.
Let
$ρ$
be the parameter from assumption
@eq:shape_assumption //[ref type:eqref]
and
$c_(0)$
be a number close to
$1/4.$
If
$C(t,r,ρ,c_(0))$
defined by
@eq.dC //[ref type:eqref]
satisfies the estimate
	\begin{equation}\label{eq.a1}
	\frac{c_0}{2} C(t,r,\rho,c_0)
	\leq \bigg(1 - r \bigg( \rho + \frac{1}{2} \bigg) \bigg) \bigg( \frac{1}{2t} - \frac \rho 2 \bigg)
	\end{equation}
then
$\partial_(t) w(t,x) ≤ 0$
for a.e.
$x \in \mathbb{R}.$
\end{Lemma}
// Unknown node type: NodeType.PROOF
@eq2mm //[ref type:eqref]
in  Lemma
@lemma:estimate_of_transformed_wave //[ref type:ref]
,
we obtain
	$
		 &= \int_(0)^(t) (d)/(dt) W(t-τ)\left( \left((1)/(4)+u(τ)|u(τ)|^{p-2}\right) w(τ) \right) (x) dτ \
	 &= ≤ c_(0) \int_(0)^(t) (d)/(dt) W(t-τ) ( w(τ) ) (x) dτ \
	 &= =  (c_(0))/(2)\int_(0)^(t) \left(  w(τ, x+t-τ) +  w(τ, x-t+τ) \right) dτ \
	 &= ≤ (c_(0))/(2)\max_(0≤ τ ≤ t) ( |\varepsilon_(0) + τ(\varepsilon_(1) + \varepsilon_(0)/2)|)/((1-c_(0) τ^(2)-2c_(0)ρ τ^(2) - 3 ρ τ))
	\int_(0)^(t) \left(  \varphi(x+t-τ) +  \varphi( x-t+τ) \right) dτ\
	 &= ≤ (c_(0))/(2)| \varepsilon_(1) | C(t,r) \int_(-t)^t  \varphi(x+σ) dσ.
	$ //[formula type:align*]
Using
@eq:shape_assumption //[ref type:eqref]
, we obtain
	$
		 &= \partial_(t) w(t,x)\
	 &= ≤ \varepsilon_(0) (\varphi^\prime(x+t)- \varphi^\prime(x-t))/(2)
	+ \left(\varepsilon_(1) + (\varepsilon_(0))/(2) \right) (\varphi(x+t) + \varphi(x-t))/(2) \
	 &= + (c_(0))/(2) |\varepsilon_(1)| C(t,r) \int_(-t)^t  \varphi(x+σ) dτ\
	 &= ≤ \left(\varepsilon_(0) ρ + \varepsilon_(1) + (\varepsilon_(0))/(2)\right)(\varphi(x+t) + \varphi(x-t))/(2)
	+ (c_(0))/(2)| \varepsilon_(1) | C(t,r)
	\int_(-t)^t  \varphi(x+σ) dσ.
	$ //[formula type:align*]
Lemma
@l3 //[ref type:ref]
implies
	$
		(\varphi(x+t) + \varphi(x-t))/(2)
	≥  \left( (1)/(2t) - \frac ρ 2 \right)
	\int_(-t)^t  \varphi(x+σ) dτ.
	$ //[formula type:align]
Then we estimate
	$
		\partial_(t) w(t,x)
	 &= ≤ |\varepsilon_(1)| A(t,r) \int_(-t)^t  \varphi(x+σ) dτ,
	$ //[formula type:align]
where
$
	
	A(t,r) =
	- \bigg(1 - r \bigg( ρ + (1)/(2) \bigg) \bigg) \bigg( (1)/(2t) - \frac ρ 2 \bigg)
	+ (c_(0))/(2) C(t,r, ρ,c_(0)).
	
$ //[formula type:display]
Therefore, the condition
@eq.a1 //[ref type:eqref]
implies
$A(t,r) ≤ 0$
and hence
$\partial_(t) w(t,x) ≤ 0$
a.e.
This completes the proof.
\end{proof}
#lemma[
\label{lemma:condition_for_negative_position}
Let the assumption of Lemma @lemma:estaimte_of_u_devided //[ref type:ref]
be satisfied.
If the inequality
	\begin{equation}\label{eq.a2}
   \frac{c_0}{2}t  C(t,r,\rho,c_0)
	\leq \frac 1 2 - \bigg( \frac{2\rho+1}{4} + \frac{1}{2t}\bigg) r
	\end{equation}
holds, then
$ w (t,x) \leq 0$ for a.e. $x \in \mathbb{R}$.
Here $C(t,r,\rho,c_0)$ is defined in @eq.dC //[ref type:eqref].
] //[Lemma]
@lemma:estaimte_of_u_devided //[ref type:ref]
be satisfied.
If the inequality
	\begin{equation}\label{eq.a2}
   \frac{c_0}{2}t  C(t,r,\rho,c_0)
	\leq \frac 1 2 - \bigg( \frac{2\rho+1}{4} + \frac{1}{2t}\bigg) r
	\end{equation}
holds, then
$ w (t,x) ≤ 0$
for a.e.
$x \in \mathbb{R}$
.
Here
$C(t,r,ρ,c_(0))$
is defined in
@eq.dC //[ref type:eqref]
.
\end{Lemma}
// Unknown node type: NodeType.PROOF
	$
		 &= w(t,x)\
	 &= ≤ \varepsilon_(0) (\varphi(x+t)+ \varphi(x-t))/(2)
	+ \left(\varepsilon_(1) + (\varepsilon_(0))/(2) \right) \int_(-t)^{t}(\varphi(x+τ))/(2) dτ \
	 &= + (c_(0))/(2)|\varepsilon_(1)| C(t,r) \int_(0)^(t) \int_(τ-t)^{t-τ}\varphi(x+σ) dσ dτ\
	 &= ≤
	- |\varepsilon_(1)|
	\bigg\{
	\frac 1 2
	- \bigg( (2ρ+1)/(4) + (1)/(2t)\bigg) r
	- (c_(0))/(2) t  C(t,r)
	\bigg\}
	\int_(-t)^t \varphi(x+σ) dσ.
	$ //[formula type:align*]
\end{proof}

In view of the above Lemmas
@lemma:estaimte_of_u_devided //[ref type:ref]
,
@lemma:condition_for_negative_speed //[ref type:ref]
,
and
@lemma:condition_for_negative_position //[ref type:ref]
,
$\mathcal{A}$
contains the following set.
$
	
	\mathcal{B}
	= \{r \in [0,1); \exists (t,c_(0),ρ)\
	\mathrm{satisfying}\
	\eqref{eq:condition_(f)or_(u)_devided},\
	\eqref{eq.a1},\
	\mathrm{and}\ \eqref{eq.a2}\}
	
$ //[formula type:display]
@eq:condition_for_u_devided //[ref type:eqref]
,\
@eq.a1 //[ref type:eqref]
,\
	\mathrm{and}\
@eq.a2 //[ref type:eqref]
\}
	\]
Indeed, if
$r \in \mathcal{B}$
, then
there exits
$(\varepsilon_(0), \varepsilon_(1), \varphi)$
such that
$r=\varepsilon_(0)/|\varepsilon_(1)|$
and the assumptions
@eq:condition_for_u_devided //[ref type:eqref]
is satisfied.
Therefore,
$r \in \mathcal{A}$
.

The definition
@eq.dC //[ref type:eqref]
and Corollary
@c62 //[ref type:ref]
imply
	\begin{equation}
	C(t,r,0,1/4) =
	\begin{cases}
	\frac{t(1-r/2)-r }{(1-t^2/4)}
	& \mbox{if} \ r < 4t/(8+2t-t^2),\\
	r
	& \mbox{if} \ r > 4t/(8+2t-t^2).
	\end{cases}
	\end{equation}
Therefore, a sufficient condition for
$r \in \mathcal B$
is that whether
$r \in [0,1)$
satisfies
that there exists
$t \in (0,2)$
such that
{\color{blue} A sufficient condition for
$r\in B$
is that
$r \in (0,1)$
and there exists
$t$
such that 
}



the following two inequalities hold:
	\begin{equation}\label{sys1}
	\begin{cases}
	\frac{1}{8}  \left(\frac{t(1-r/2)-r }{(1-t^2/4)}  \right)
	< \bigg(1 - \frac{r}{2}  \bigg) \bigg( \frac{1}{2t} \bigg),\\
	\frac{1}{8} t  \left(\frac{t(1-r/2)-r }{(1-t^2/4)}  \right)
	< 1 - \bigg( \frac{1}{2} + \frac{1}{2t}\bigg) r,\\
	r
	< \frac{4t}{(4-t)(2+t)}
	\end{cases}
	\end{equation}
and
	\begin{equation}\label{sys2}
	\begin{cases}
	\frac{1}{8}  r
	< \bigg(1 - \frac{r}{2}  \bigg) \bigg( \frac{1}{2t} \bigg),\\
	\frac{1}{8} t  r
	< \frac 1 2 - \bigg( \frac{1}{4} + \frac{1}{2t}\bigg) r,\\
	r > \frac{4t}{(4-t)(2+t)}.
	\end{cases}
	\end{equation}
In particular, if
$r \in [0,1)$
admits some
$t \in (0,2)$
such that
$(t,r)$
satisfies either
@sys1 //[ref type:eqref]
or
@sys2 //[ref type:eqref]
,
then one can choose
$c_(0)$
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
$\mathcal B$
contains the following set:
$
	
	\mathcal C
	= \{r \in [0,1); \exists t, \ (t,r) \ \mbox{is a solution to \eqref{sys2}}\}.
	
$ //[formula type:display]
@sys2 //[ref type:eqref]
}\}.
	\]

Finally, we show that
$\mathcal C \supset [0,1)$
.
The system
@sys2 //[ref type:eqref]
is equivalent to
	$
	cases(
	r <   (4)/(2+t)\,\
	r < (8t)/((2+t)^2)\,\
	r > (4t)/((4-t)(2+t)).
	)
	$ //[formula type:align]
A positive solution
$r$
can be found iff
$
	
	(4t)/((4-t)(2+t)) < min \left((4)/(2+t), (8t)/((2+t)^2)  \right) .
	
$ //[formula type:display]
Note that for
$t \in [0,4)$
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
		I(t) &= = (a(t),b(t)), \
	a(t) &= = (4t)/((4-t)(2+t)) , \
	b(t) &= = min \left((4)/(2+t), (8t)/((2+t)^2)  \right)
	$ //[formula type:align*]
is nonempty for any
$t \in (0,2).$
Note that
$
	
	(8t)/((2+t)^2) < (4)/(2+t)
	
$ //[formula type:display]
for
$t \in (0,2).$
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
	= (4)/(4-t)\bigg( 1 - (2)/(t+2) \bigg).
	
$ //[formula type:display]
Moreover,
$a(0)=0 $
and
$ a(2)=b(2)=1$
imply that
$
	
	\mathcal{A} \supset \mathcal{B} \supset \mathcal{C} \supset [0,1).
	
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

\end{document}