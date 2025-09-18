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
$  align(}\label{eq:DW}, \begin{cases}, \partial_(t)^(2) u+\partial_(t) u-\Delta u=|u|^p,, u(0)=u_(0), \partial_(t) u(0)=u_(1),, \end{cases})  $
The aim of this manuscript
is to establish the global existence of solutions
under the initial conditions
$  align(}\label{eq:initial_(c)ondition}, , )  $
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
// Unknown node type: NodeType.EQREF
has been extensively studied.
The Cauchy problem
// Unknown node type: NodeType.EQREF
has been extensively studied
(see
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
// Unknown node type: NodeType.CITE
,
and references therein).
A key step for analyzing the nonlinear problem
// Unknown node type: NodeType.EQREF
is to first
understand the corresponding linear (free) problem:
$  align(}, \begin{cases}, \partial_(t)^(2) u + \partial_(t) u - \Delta u = 0,\\, u(0) = u_(0),, \partial_(t) u(0) = u_(1)., \end{cases}, \label{eq:linear_(d)amped_(w)ave})  $
// %]]]
 
// %[[[ An explicit representation of solutions to
// Unknown node type: NodeType.EQREF
An explicit representation of solutions to
// Unknown node type: NodeType.EQREF
is derived through the substitution
$u(t,x)=e^(-t/2)w(t,x)$
,
which transforms
// Unknown node type: NodeType.EQREF
into the wave-type equation
$  align(}, \partial_(t)^(2) w - \Delta w = (1)/(4) w,, \label{eq:transformed_(w)ave_(e)quation})  $
which highlights the wave structure; for details, see Chapter VI, Section 6 in
// Unknown node type: NodeType.CITE
.
In particular,
// Unknown node type: NodeType.EQREF
yields the following
comparison principle for
// Unknown node type: NodeType.EQREF
in one and two dimensional case:
if
$\overline{u_(0)} \ge \underline{u_(0)} $
and
$\overline{u_(1)} + \overline{u_(0)}/2 \ge \underline{u_(1)} + \underline{u_(0)}/2$
,
then the solutions
$\overline{u}$
of
// Unknown node type: NodeType.EQREF
with
$\overline{u_(0)}, \overline{u_(1)}$
and
$\underline{u}$
with
$\underline{u_(0)}, \underline{u_(1)}$
satisfy
$\overline{u}(t,x) \ge \underline{u}(t,x)$
for all
$t \ge 0$
and
$x$
.
This comparison principle will be a key tool in what follows.
Hereafter, we denote by
$S(t)f$
the solution to
// Unknown node type: NodeType.EQREF
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
// Unknown node type: NodeType.EQREF
is
asymptotically equivalent to the solution of the free heat equation:
$  align(}, \begin{cases}, \partial_(t) v - \Delta v = 0,\\, v(0) = u_(0) + u_(1)., \end{cases}, \label{eq:free_(h)eat})  $
For simplicity, we denote by
$e^(t \Delta) f$
the solution to
// Unknown node type: NodeType.EQREF
corresponding to the data
$v(0)=f$
.
Marcati and Nishihara
// Unknown node type: NodeType.CITE
and Nishihara
// Unknown node type: NodeType.CITE
established the asymptotic equivalence
in the one- and three-dimensional cases, respectively.
Namely, for a sufficiently regular function
$f$
,
the following asymptotic relation holds:
$  align(}, S(t) f, \sim e^(t \Delta) f + e^(-t/2) W(t) f., \label{eq:asymptotic_(e)quivalence})  $
We refer to
// Unknown node type: NodeType.CITE
for more general results.
We note that, even before the explicit proofs by Marcati and Nishihara,
this idea had been used in the perturbative analysis of solutions to
// Unknown node type: NodeType.EQREF
;
see, for example,
// Unknown node type: NodeType.CITE
.
// %]]]

// %[[[ Returning to the Cauchy problem
// Unknown node type: NodeType.EQREF
,
Returning to the Cauchy problem
// Unknown node type: NodeType.EQREF
,
the local existence of solutions to
// Unknown node type: NodeType.EQREF
is known under standard regularity assumptions.
For example, a classical result can be found in
// Unknown node type: NodeType.CITE
.
Moreover, the discussion in
// Unknown node type: NodeType.CITE
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
such that @eq:DW possesses a unique mild solution
$u \in C\left(\left[0, T_1\right) ;W^{1,\infty} \cap W^{1,1}\right)$
satisfying the estimate
	\begin{align}\label{eq2}
	\sup _{0 \leq t \leq T_1} \|u(t) \|_{ L^{\infty}}
	\lesssim ( \|u_0 \|_{L^\infty} + \|u_1 \|_{L^\infty}).
	\end{align}
] //[Lemma]
$(u_(0),u_(1)) \in W^(1,\infty) \cap W^(1,1) \times L^\infty \cap L^(1)$
and
$p > 1$
and
$n =1$
.
There exists
$T_(1)=T_(1)(u_(0),u_(1))$
such that
// Unknown node type: NodeType.EQREF
possesses a unique mild solution
$u \in C\left(\left[0, T_(1)\right) ;W^(1,\infty) \cap W^(1,1)\right)$
satisfying the estimate
$  align(}\label{eq2}, \sup _{0 \le t \le T_(1)} \|u(t) \|_{ L^(\infty)}, \lesssim ( \|u_(0) \|_{L^\infty} + \|u_(1) \|_{L^\infty}).)  $
\end{Lemma}
\noindent
Here
$W^(1,q)$
for
$1 \le q \le \infty$
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
// Unknown node type: NodeType.EQREF
and for the existence of global solutions to the Fujita-type heat equation:
$  align(}, \partial_(t) v - \Delta v = |v|^p., \label{eq:fujita_(e)quation})  $
For details, see
// Unknown node type: NodeType.CITE
.
We also remark that when
$n \in \mathbb N$
,
$p > 1+2/n$
,
and the initial data are sufficiently small,
then solutions to
// Unknown node type: NodeType.EQREF
exist globally in time.
Our subsequent analysis is based on Lemma
@lemma:local_existence
.
// %]]]

// %[[[ Although the solution to
// Unknown node type: NodeType.EQREF
Although the solution to
// Unknown node type: NodeType.EQREF
can be constructed explicitly from
// Unknown node type: NodeType.EQREF
,
the asymptotic equivalence
// Unknown node type: NodeType.EQREF
is a powerful tool for analyzing solutions to
// Unknown node type: NodeType.EQREF
.
Roughly speaking, one may analyze solutions
$u$
to
// Unknown node type: NodeType.EQREF
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
// Unknown node type: NodeType.CITE
showed that
when
$n = 1, 2$
and
$1 < p \le 3$
,
if
$  align(}, \int u_(0) + u_(1) dx > 0,, \label{eq:initial_(m)ean_(c)ondition})  $
then, irrespective of the size of the initial data,
the solution
$u$
to
// Unknown node type: NodeType.EQREF
blows up in finite time.
Moreover, they derived sharp estimates for the lifespan in terms of the size of the initial data.
In
// Unknown node type: NodeType.CITE
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
// Unknown node type: NodeType.CITE
,
Ikeda and Wakasugi
// Unknown node type: NodeType.CITE
,
and Ikeda and Sobajima
// Unknown node type: NodeType.CITE
proved finite-time blow-up of
the spatial mean of solutions to
// Unknown node type: NodeType.EQREF
and derived lifespan estimates
in more general spatial settings,
still under the initial condition
// Unknown node type: NodeType.EQREF
.
Their approach is based on the weak formulation of
// Unknown node type: NodeType.EQREF
and is more closely tied to the scaling properties of
// Unknown node type: NodeType.EQREF
than to the asymptotic equivalence
// Unknown node type: NodeType.EQREF
.
Recently, the present authors
// Unknown node type: NodeType.CITE
showed the finite-time blow-up of solutions to
// Unknown node type: NodeType.EQREF
and obtained sharp lifespan estimates
under the mean-zero initial condition
$  align(}, \int u_(0) + u_(1) dx = 0,, \quad, u_(0), u_(1) \not\equiv 0., \label{eq:initial_(m)ean_(c)ondition_(o)urs})  $
The approach of
// Unknown node type: NodeType.CITE
is inspired by that of Li and Zhou
// Unknown node type: NodeType.CITE
.
We note that
the mean-zero condition
// Unknown node type: NodeType.EQREF
cannot be handled by a direct application of a weak formulation approach.
We also refer to
// Unknown node type: NodeType.CITE
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
	\int u_(0) dx = \mu_(0),
	\quad
	\int u_(1) dx = \mu_(1),
	 $
such that the corresponding solution blows up in finite time.
More precisely,
let
$\psi$
be a smooth function supported in a compact set
and its integral is
$1$
.
Let
$L$
be a large positive number.
If
$  align(}, u_(0)(x), u_(1)(x))  $
then one can show
$u(t,x) = u_(b)(t,x) + u_(g)(t,x-L)$
till some time,
where
$u_(b)$
is the blow-up solution with initial data
$(u_(0), u_(1)) = (\psi,0)$
and
$u_(g)$
is the solution with initial data
$(u_(0), u_(1)) = ((\mu_(0)-1)\psi, \mu_(1) \psi)$
.
Since the argument above implies that
$\int u_(b) + \partial_(t) u_(b) dx$
blows up in finite time
and
$\int u_(g) + \partial_(t) u_(g) dx$
is increasing,
there exists a time
$t_(0)$
such that
$ 
	\int u(t_(0)) + \partial_(t) u(t_(0)) dx
	= \int u_(b)(t_(0)) + \partial_(t) u_(b)(t_(0)) dx + \int u_(g)(t_(0)) + \partial_(t) u_(g)(t_(0)) dx
	> 0.
	 $
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
// Unknown node type: NodeType.EQREF
.
Li and Zhou
// Unknown node type: NodeType.CITE
also showed that,
when
$n = 1, 2$
and even when
$1 < p \le 3$
,
global existence for small initial data holds for
// Unknown node type: NodeType.EQREF
under the following pointwise condition (for all
$x$
):
$  align(}, u_(0)(x) = 0,, \quad, u_(1)(x) \le 0., \label{eq:initial_(c)ondition_(L)i_(Z)hou})  $
This was further extended to
$  align(}, u_(0)(x) \le 0,, u_(1)(x) + \frac 1 2 u_(0)(x) \le 0., \label{eq:initial_(c)ondition_(L)i_(Z)hou_(g)eneral})  $
For details, see
// Unknown node type: NodeType.CITE
.
The conditions
// Unknown node type: NodeType.EQREF
and
// Unknown node type: NodeType.EQREF
are used to implement a comparison argument
based on the nonlinear version of
the transformation associated with
// Unknown node type: NodeType.EQREF
.
Indeed, under
// Unknown node type: NodeType.EQREF
and
// Unknown node type: NodeType.EQREF
,
solutions are shown to be negative at any time and point.
On the other hand, in other cases,
it is unclear whether
there is an initial condition
with which global solutions exist.
// %]]]

// %[[[ The expectation of global existence for
// Unknown node type: NodeType.EQREF
,
The expectation of global existence for
// Unknown node type: NodeType.EQREF
,
even with a positive initial position,
may be supported by a result of Pinsky
// Unknown node type: NodeType.CITE
.
In
// Unknown node type: NodeType.CITE
, it is shown that
there exist both global and blow-up solutions of
// Unknown node type: NodeType.EQREF
for certain sign-changing initial data.
The proof relies on a comparison argument
that is not directly applicable to
// Unknown node type: NodeType.EQREF
without imposing the initial condition
// Unknown node type: NodeType.EQREF
.
On the other hand,
since global solutions to
// Unknown node type: NodeType.EQREF
are known to behave similarly to global solutions of
// Unknown node type: NodeType.EQREF
under certain initial conditions,
the gap in the assumptions required by the comparison argument
appears to be merely technical.
// %]]]

// %[[[ The aim of this manuscript
The aim of this manuscript
is to generalize a sufficient condition
for global existence of solutions to
// Unknown node type: NodeType.EQREF
.
For simplicity, we restrict our attention to the one-dimensional case.
In particular,
we show that the blow-up conditions based on the spatial integrals of the initial data,
namely
// Unknown node type: NodeType.EQREF
and
// Unknown node type: NodeType.EQREF
,
cannot be relaxed without taking into account the shape of the initial data,
provided that the spatial integral of the initial position is positive.
More precisely, we ask the following question:
Does there exist a constant
$c_(0) > 0$
such that, for
$ 
	0 < \varepsilon_(0) < c_(0) |\varepsilon_(1)| \ll 1,
	 $
there exists a smooth, positive function
$\varphi$
such that
the solution with initial data
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
exists globally in time?
To the best of the authors' knowledge,
global existence for
// Unknown node type: NodeType.EQREF
has only been established via comparison arguments.
Accordingly, we employ the following simple sufficient condition for global existence:
there exist a constant
$c_(0) > 0$
and a smooth, positive function
$\varphi$
such that, for
$ 
	\varepsilon_(0) < c_(0) |\varepsilon_(1)| \ll 1,
	 $
the solution
$u$
with initial data
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
satisfies
$  align(}, u(t,x) \le 0,\ \ \partial_(t) u(t,x) + (1)/(2)u(t,x) \le 0, \label{eq:aim})  $
for all
$x$
at some time
$t$
.
Once
// Unknown node type: NodeType.EQREF
is verified,
Theorem 1.2 in
// Unknown node type: NodeType.CITE
yields global existence.
Decay in this case is studied in
// Unknown node type: NodeType.CITE
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
and the mild solution $u \in C([0,T_0) \times \mathbb{R})$ to @eq:DW
with initial data $(u_0,u_1) = (\varepsilon_0 \varphi, \varepsilon_1 \varphi)$
exists and satisfies the pointwise estimates @eq:aim
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
$  align(}, 0 < \varepsilon_(0) < -\varepsilon_(1) \ll 1., \label{eq:condition_(r)atio})  $
Then there exists a sufficiently small number
$\rho$
and
a positive function
$\varphi \in W^(2,1) \cap W^(2,\infty)$
satisfying the following pointwise control
$  align(}\label{eq:shape_(a)ssumption} \tag{H1}, |\varphi^\prime(x)| + |\varphi^(\prime\prime) (x)| \le \rho  \varphi(x) , \ \ \forall x \ge 0)  $
and the mild solution
$u \in C([0,T_(0)) \times \mathbb{R})$
to
// Unknown node type: NodeType.EQREF
with initial data
$(u_(0),u_(1)) = (\varepsilon_(0) \varphi, \varepsilon_(1) \varphi)$
exists and satisfies the pointwise estimates
// Unknown node type: NodeType.EQREF
at time
$ 
	t(\varepsilon_(0)/|\varepsilon_(1)|)+\delta \in (0,2),
	 $
where
$\delta>0$
is sufficiently small
and
$t=t(\varepsilon_(0)/|\varepsilon_(1)|)$
is the unique positive solution 
of
$  align(}\label{eq.deft}, (\varepsilon_(0))/(|\varepsilon_(1)|) =  (4t)/((4-t)(2+t)).)  $
\end{Theorem}

We give some remarks on Theorem
@theorem:main
.
First,
the condition
// Unknown node type: NodeType.EQREF
is optimal.
Indeed, for
$\varepsilon_(0) + \varepsilon_(1) \ge 0$
,
we can apply Theorem 1.1 in
// Unknown node type: NodeType.CITE
and deduce blow-up.
Second,
for any positive
$\rho$
,
there exists a function
$\varphi \in W^(2,1) \cap W^(2,\infty)$
satisfying
// Unknown node type: NodeType.EQREF
.
Indeed, let
$N$
be an integer,
$a >1$
, and
$ 
	\varphi(x) = (N^(2)+x^(2))^{-a/2}
	 $
then
$\varphi \in W^(2,1) \cap W^(2,\infty)$
and
$  align(}, |\varphi^\prime(x)|, |\varphi^(\prime\prime)(x)|)  $
so
$\rho = a/N + a(a+1)/N^(2) \to 0$
as
$N \to \infty.$
Third,
the condition
// Unknown node type: NodeType.EQREF
plays an important role
in obtaining the pointwise estimate
// Unknown node type: NodeType.EQREF
.
In particular,
// Unknown node type: NodeType.EQREF
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
	 $
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
// Unknown node type: NodeType.EQREF
is well-defined.
The smallness of
$\delta$
is determined by
$ 
	\delta < b(t)-a(t),
	 $
where
$ 
	b(t) = (8t)/((2+t)^2).
	 $
The proof that
$b(t)>a(t)$
for
$t \in (0,2)$
is elementary
and can be found at the end of the proof of Theorem
@theorem:main
.

We note that
it is still unclear whether
there exists a global solution to
// Unknown node type: NodeType.EQREF
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
	 $
In the next section, we collect some preliminary estimates.
Theorem
@theorem:main
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
$g \in W^(1,\infty)$
and
$f, w \in L^\infty(0,2;L^\infty)$
.
Then there exists a unique
$L^\infty$
valued mild solution
$v$
to the following Cauchy problem:
$ 
	\begin{cases}
	\partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v  = f w+g \partial_(x) w,\\
	v(0,x)= \varepsilon_(0),\\
	\partial_(t) v(0,x)= \varepsilon_(1).
	\end{cases}
	 $
Moreover,
$v$
enjoys the following estimate:
$  align(}, \|v(t)\|_{L^\infty}, , , \|f\|_{L^\infty(0,t; L^\infty)} + \| g \|_{W^(1,\infty)}, \bigg) \|w\|_{L^\infty(0,t; L^\infty)}., \label{1dmax})  $
\end{Lemma}
// Unknown node type: NodeType.PROOF
$  align(}, v(t,x), , + ( \varepsilon_(0) + \varepsilon_(1) )(1-e^(-t))\\, , + \int_(0)^(t) S(t-\tau) g \partial_(x) w(\tau,x) d\tau,)  $
where
$ 
	S(t) h(x)
	= (1)/(2) e^(-t/2) \int_(-t)^{t} I_(0) \bigg( \frac{\sqrt{t^(2)-y^(2)}}{2} \bigg) h(x+y) d y.
	 $
We note that by denoting
$\omega = \sqrt{t^(2)-y^(2)}$
we have
$ 
	e^(-t/2) I_(0) \bigg( (\omega)/(2) \bigg)
	\le \langle \omega \rangle^(-1/2) e^((\omega - t/2))
	\le C \langle t \rangle^(-1/2) e^(-y^(2)/8t).
	 $
Therfore, a straightforward calculation shows that
$ 
	\| S(t-\tau) f(\tau) w(\tau) \|_{L^\infty}
	\le C \| f(\tau) \|_{L^\infty} \| w(\tau) \|_{L^\infty}.
	 $
We note that by writing
$\sigma = t-\tau$
we have
$  align(}, e^(\sigma/2) S(\sigma) g \partial_(x) w(\tau)(x), , , , )  $
We note that by writing
$\omega = \sqrt{\sigma^(2)-y^(2)}$
,
we have
$ 
	\bigg| e^(-\sigma/2) (y)/(\omega) I_(1)(\omega/2) \bigg|
	\le C (y)/(\langle \omega \rangle^(3/2)) e^((\omega - \sigma)/2)
	\le C \langle \sigma \rangle^(-1/2) e^(-y^(2)/8\sigma).
	 $
Thereore, we have
$ 
	\| S(t-\tau) g(\tau) \partial_(x) w(\tau) \|_{L^\infty}
	\le C \| g \|_{W^(1,\infty)} \| w(\tau) \|_{L^\infty}
	 $
and this implies
// Unknown node type: NodeType.EQREF
.
\end{proof}

By using Lemma
@lemma:estimate_of_transformed_wave
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
satisfy @eq:shape_assumption.
If the mild solution $u$ of Lemma @lemma:local_existence
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
$\rho >0$
satisfy
$  align(}, C ( |\varepsilon_(1)|^{p-1} + \rho ) t < 1, \label{eq:condition_(f)or_(u)_devided})  $
with a positive constant
$C$
.
Assume that
$\varphi \in W^(2,1) \cap W^(2,\infty)$
satisfy
// Unknown node type: NodeType.EQREF
.
If the mild solution
$u$
of Lemma
@lemma:local_existence
with initial data
$(u_(0),u_(1)) = (\varepsilon_(0),\varepsilon_(1))$
satsify
$ 
	\| |u|^{p-2}u\|_{L^\infty(0,T_(0); L^\infty)}
	+ \bigg\|(\ddot \varphi)/(\varphi) \bigg\|_{L^\infty}
	+ \bigg\|(\dot \varphi^(2))/(\varphi^(2)) \bigg\|_{L^\infty}
	\le C ( \varepsilon_(1)^(p-1) + \rho ).
	 $
Then
$u$
enjoys the following estimate for
$t \in (0,T_(0))$
:
$  align(}\label{eq2mm}, \left\| (u(t))/(\varphi) \right\|_{ L^(\infty)}, \le \frac{|\varepsilon_(0) e^(-t) + (\varepsilon_(1) + \varepsilon_(0))(1-e^(-t))|}{1-C ( |\varepsilon_(1)|^{p-1} + \rho ) t}.)  $
\end{Lemma}
// Unknown node type: NodeType.PROOF
$ 
	v(t,x) = (u(t,x))/(\varphi(x)),
	 $
so we have
$  align(}, \partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v, = (|u|^p)/(\varphi), + 2 (\dot \varphi \partial_(x) u)/(\varphi^(2)), + (\ddot \varphi)/(\varphi^(2)) u, - 2 (\dot \varphi^(2))/(\varphi^(3)) u)  $
Since
$ 
	\partial_(x) u = v \dot \varphi  + \varphi \partial_(x) v
	 $
we arrive at
$ 
	\partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v \\
	= \bigg( |u|^{p-2} u + (\ddot \varphi)/(\varphi) \bigg) v
	+ 2 (\dot \varphi)/(\varphi) \partial_(x) v
	 $
Therefore, the Cauchy problem can be rewritten as
$  align(}, \begin{cases}, \partial_(t)^(2) v + \partial_(t) v - \partial_(x)^(2) v  = f v+g\partial_(x)v, \\, v(0,x)=\varepsilon_(0) ,, \partial_(t) v(0,x) =\varepsilon_(1) ,, \end{cases})  $
with
$ 
	f = |u|^{p-2}u  + (\ddot \varphi)/(\varphi),
	\quad
	g =  2  (\dot \varphi)/(\varphi).
	 $
Noting
$ 
	\dot g = 2 (\ddot \varphi)/(\varphi) - 2 (\dot \varphi^(2))/(\varphi^(2))
	 $
and applying Lemma
@lemma:local_existence
and the assumption
// Unknown node type: NodeType.EQREF
,
$ 
\|f\|_{L^\infty(0,T_(0); L^\infty)}
\le C_(1) ( |\varepsilon_(1)|^{p-1} + \rho )
 $
and
$\|g\|_{W^(1,\infty)} \le C_(1) \rho$
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
$\phi$
be
$C^(1)(\mathbb R; [0,\infty))$
,
such that there is a positive constant
$\rho$
so that
$  align(}\label{eq.bb1}, )  $
Then we have
$  align(}\label{eq.HH1}, )  $
and
$  align(}\label{eq.HH1mm}, )  $
for
$0  \le  \alpha < \beta < \infty.$
\end{Lemma}
// Unknown node type: NodeType.PROOF
// Unknown node type: NodeType.CITE
(see Lemma 2.1 in
// Unknown node type: NodeType.CITE
)
$ 
	( \phi(\alpha) + \phi(\beta))/(2) - (1)/(\beta - \alpha) \int_(\alpha)^{\beta} \phi(\sigma) d \sigma
	= (\beta -  \alpha)/(2) \int_(0)^(1) (1-2t) \dot \phi(t \alpha + (1-t)\beta) dt.
	 $
Then we can write
$  align(}, ( \phi(\alpha) + \phi(\beta))/(2) - (1)/(\beta - \alpha) \int_(\alpha)^{\beta} \phi(\sigma) d \sigma, , , )  $
Assuming
// Unknown node type: NodeType.EQREF
, we get
// Unknown node type: NodeType.EQREF
.

It is easy to extend this estimate also to the cases
$\alpha < 0 < \beta$
and
$\alpha < \beta <0$
using the additional assumption that
$\phi$
is an even function.
In fact, when
$\alpha < 0 < \beta$
we define the interval
$J\subset [0,\infty)$
with ends
$-\alpha$
and
$\beta$
and then we can apply
// Unknown node type: NodeType.EQREF
so we have
$  align(}\label{eq.HH1m}, ( \phi(\alpha) + \phi(\beta))/(2), = ( \phi(-\alpha) + \phi(\beta))/(2), \le  (1)/(|J|) \int_(J) \phi(\sigma) d \sigma, + (\rho)/(2) \int_(J ) \phi(\sigma) d \sigma.)  $
This completes the proof.
\end{proof}

We finalize this section
by collecting some estimates of calculs to control nonlinaerity.
Consider the function
$  align(}\label{eq.dC}, C(t,r,\rho,\varepsilon_(1)), = \sup_(\tau \in [0,t]) G(\tau,r,\rho,\varepsilon_(1)),)  $
where
$ 
	G(\tau,r,\rho,\varepsilon_(1))
	= \frac{ | r + e^(-\tau) - 1 |}{1-C ( |\varepsilon_(1)|^{p-1} + \rho ) \tau}
	 $
under the assumption
// Unknown node type: NodeType.EQREF
is satisfied.
Here
$\rho$
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
$  align(}, r_(1)(t), , r_(2)(t), )  $
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
	\frac{1-e^(-\tau)}{\tau}
	= \int_(0)^(1) e^(-\tau \sigma) d \sigma.
	 $
Therfore,
$r \in [r_(1)(t), r_(2)(t)]$
implies that
	\[
	r \in \bigcap_{\tau \in [0,t]} [r_1(\tau), r_2(\tau)].
	\]
Since
$C \delta t < 1$
, we note that
$1-e^(-\tau) \in [r_(1)(\tau), r_(2)(\tau)]$
for any
$\tau \in [0,t]$
.
In the case where
$r \in [r_(1)(\tau), 1-e^(-\tau)]$
, we have
$  align(}, , \Leftrightarrow, \Leftrightarrow, \Leftrightarrow)  $
Similarly, in the case where
$r \in [1-e^(-\tau), r_(2)(\tau)]$
, we have
$  align(}, , \Leftrightarrow, \Leftrightarrow, \Leftrightarrow)  $
These computations imples that
$C(t,r,\rho, \varepsilon_(1)) = r$
for
$r \in [r_(1)(t), r_(2)(t)]$
.

In the case where
$r < r_(1)(t)$
,
$C(t,r,\rho, \varepsilon_(1)) = G(t,r,\rho, \varepsilon_(1))$
because
$C(\cdot,r,\rho, \varepsilon_(1))$
is increasing.

In the case where
$r > r_(2)(t)$
,
we compute
$  align(}, \partial_\tau G(\tau,r,\rho, \varepsilon_(1)), , + \frac{ C ( |\varepsilon_(1)|^{p-1} + \rho ) (r + e^(-\tau) - 1) }{(1-C ( |\varepsilon_(1)|^{p-1} + \rho ) \tau)^2}\\, , )  $
So
$\partial_\tau G(0,r,\rho, \varepsilon_(1)) < 0$
.
Moreover, we also compute
$  align(}, , )  $
This implise that
$ 
	C(t,r,\rho, \varepsilon_(1)) = G(\min(t,- \log(1-r)),r,\rho, \varepsilon_(1)).
	 $
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
$  align(}, C(t,r,0,1/4) =, \begin{cases}, (t(1-r/2)-r )/((1-t^(2)/4)), , r, , \end{cases})  $
where
$ 
	r_(t)
	= (4t)/(8+2t-t^(2))
	= (4t)/((4-t)(2+t)).
	 $
\end{Corollary}

// %[[[
# Comparison principle
# Proof of Theorem \ref{theorem:main
@theorem:main
}
// %[[[ Proposition Comparison Principle
$w = e^(t/2) u$
is a solution to the Cauchy problem
$  align(}\label{CPa1}, \begin{cases}, \partial_(t)^(2) w - \Delta w = \left((1)/(4) + u|u|^{p-2} \right) w,, , w(0)=\varepsilon_(0) \varphi(x),, , \partial_(t) w(0) =\varepsilon_(1)\varphi(x)+(\varepsilon_(0))/(2)\varphi(x),, , \end{cases})  $
The D'Alembert formula implies
$  align(}, , )  $
where
$ 
	W(t)(f)(x) = (1)/(2) \int_(x-t)^{x+t} f(\tau) d\tau,
	 $
so
$  align(}, , )  $
Set
$ 
	r = \varepsilon_(0)/|\varepsilon_(1)|
	 $
and
$r\in [0,1)$
follows from the assumption
// Unknown node type: NodeType.EQREF
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
$\partial_(t) w(t,x) \le 0$
for almost every
$x \in \mathbb{R}.$
#lemma[
\label{lemma:condition_for_negative_speed}
Let the assumption of Lemma @lemma:estaimte_of_u_devided
be satisfied.
Let $\rho$ be the parameter from assumption @eq:shape_assumption
and $c_0$ be a number close to $1/4.$
If $C(t,r,\rho,c_0)$ defined by @eq.dC satisfies the estimate
	\begin{equation}\label{eq.a1}
	\frac{c_0}{2} C(t,r,\rho,c_0)
	\leq \bigg(1 - r \bigg( \rho + \frac{1}{2} \bigg) \bigg) \bigg( \frac{1}{2t} - \frac \rho 2 \bigg)
	\end{equation}
then $\partial_t w(t,x) \leq 0$ for a.e. $x \in \mathbb{R}.$
] //[Lemma]
@lemma:estaimte_of_u_devided
be satisfied.
Let
$\rho$
be the parameter from assumption
// Unknown node type: NodeType.EQREF
and
$c_(0)$
be a number close to
$1/4.$
If
$C(t,r,\rho,c_(0))$
defined by
// Unknown node type: NodeType.EQREF
satisfies the estimate
	\begin{equation}\label{eq.a1}
	\frac{c_0}{2} C(t,r,\rho,c_0)
	\leq \bigg(1 - r \bigg( \rho + \frac{1}{2} \bigg) \bigg) \bigg( \frac{1}{2t} - \frac \rho 2 \bigg)
	\end{equation}
then
$\partial_(t) w(t,x) \le 0$
for a.e.
$x \in \mathbb{R}.$
\end{Lemma}
// Unknown node type: NodeType.PROOF
// Unknown node type: NodeType.EQREF
in  Lemma
@lemma:estimate_of_transformed_wave
,
we obtain
$  align(}, , , , , \int_(0)^(t) \left(  \varphi(x+t-\tau) +  \varphi( x-t+\tau) \right) d\tau\\, )  $
Using
// Unknown node type: NodeType.EQREF
, we obtain
$  align(}, , , + \left(\varepsilon_(1) + (\varepsilon_(0))/(2) \right) (\varphi(x+t) + \varphi(x-t))/(2) \\, , , + (c_(0))/(2)| \varepsilon_(1) | C(t,r), \int_(-t)^t  \varphi(x+\sigma) d\sigma.)  $
Lemma
@l3
implies
$  align(}\label{eq.HH1m1}, (\varphi(x+t) + \varphi(x-t))/(2), \ge  \left( (1)/(2t) - \frac \rho 2 \right), \int_(-t)^t  \varphi(x+\sigma) d\tau.)  $
Then we estimate
$  align(}, \label{HH2}, \partial_(t) w(t,x), )  $
where
$ 
	A(t,r) =
	- \bigg(1 - r \bigg( \rho + (1)/(2) \bigg) \bigg) \bigg( (1)/(2t) - \frac \rho 2 \bigg)
	+ (c_(0))/(2) C(t,r, \rho,c_(0)).
	 $
Therefore, the condition
// Unknown node type: NodeType.EQREF
implies
$A(t,r) \le 0$
and hence
$\partial_(t) w(t,x) \le 0$
a.e.
This completes the proof.
\end{proof}
#lemma[
\label{lemma:condition_for_negative_position}
Let the assumption of Lemma @lemma:estaimte_of_u_devided
be satisfied.
If the inequality
	\begin{equation}\label{eq.a2}
   \frac{c_0}{2}t  C(t,r,\rho,c_0)
	\leq \frac 1 2 - \bigg( \frac{2\rho+1}{4} + \frac{1}{2t}\bigg) r
	\end{equation}
holds, then
$ w (t,x) \leq 0$ for a.e. $x \in \mathbb{R}$.
Here $C(t,r,\rho,c_0)$ is defined in @eq.dC.
] //[Lemma]
@lemma:estaimte_of_u_devided
be satisfied.
If the inequality
	\begin{equation}\label{eq.a2}
   \frac{c_0}{2}t  C(t,r,\rho,c_0)
	\leq \frac 1 2 - \bigg( \frac{2\rho+1}{4} + \frac{1}{2t}\bigg) r
	\end{equation}
holds, then
$ w (t,x) \le 0$
for a.e.
$x \in \mathbb{R}$
.
Here
$C(t,r,\rho,c_(0))$
is defined in
// Unknown node type: NodeType.EQREF
.
\end{Lemma}
// Unknown node type: NodeType.PROOF
$  align(}, , , + \left(\varepsilon_(1) + (\varepsilon_(0))/(2) \right) \int_(-t)^{t}(\varphi(x+\tau))/(2) d\tau \\, , , - |\varepsilon_(1)|, \bigg\{, \frac 1 2, - \bigg( (2\rho+1)/(4) + (1)/(2t)\bigg) r, - (c_(0))/(2) t  C(t,r), \bigg\}, \int_(-t)^t \varphi(x+\sigma) d\sigma.)  $
\end{proof}

In view of the above Lemmas
@lemma:estaimte_of_u_devided
,
@lemma:condition_for_negative_speed
,
and
@lemma:condition_for_negative_position
,
$\mathcal{A}$
contains the following set.
$ 
	\mathcal{B}
	= \{r \in [0,1); \exists (t,c_(0),\rho)\
	\mathrm{satisfying}\
	\eqref{eq:condition_(f)or_(u)_devided},\
	\eqref{eq.a1},\
	\mathrm{and}\ \eqref{eq.a2}\}
	 $
// Unknown node type: NodeType.EQREF
,\
// Unknown node type: NodeType.EQREF
,\
	\mathrm{and}\
// Unknown node type: NodeType.EQREF
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
// Unknown node type: NodeType.EQREF
is satisfied.
Therefore,
$r \in \mathcal{A}$
.

The definition
// Unknown node type: NodeType.EQREF
and Corollary
@c62
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
// Unknown node type: NodeType.EQREF
or
// Unknown node type: NodeType.EQREF
,
then one can choose
$c_(0)$
sufficiently close to
$1/4$
and
$\rho>0$
sufficiently small
so that the assumptions
// Unknown node type: NodeType.EQREF
,
// Unknown node type: NodeType.EQREF
and
// Unknown node type: NodeType.EQREF
in Lemmas
@lemma:condition_for_negative_speed
and
@lemma:condition_for_negative_position
are satisfied.
Consequently,
$\mathcal B$
contains the following set:
$ 
	\mathcal C
	= \{r \in [0,1); \exists t, \ (t,r) \ \mbox{is a solution to \eqref{sys2}}\}.
	 $
// Unknown node type: NodeType.EQREF
}\}.
	\]

Finally, we show that
$\mathcal C \supset [0,1)$
.
The system
// Unknown node type: NodeType.EQREF
is equivalent to
$  align(}\label{sys4}, \begin{cases}, r <   (4)/(2+t),\\, r < (8t)/((2+t)^2),\\, r > (4t)/((4-t)(2+t))., \end{cases})  $
A positive solution
$r$
can be found iff
$ 
	(4t)/((4-t)(2+t)) < \min \left((4)/(2+t), (8t)/((2+t)^2)  \right) .
	 $
Note that for
$t \in [0,4)$
$ 
	(4t)/((4-t)(2+t)) < (4)/(2+t)
	 $
is equivalent to
$t <2$
and
$ 
	(4t)/((4-t)(2+t)) < (8t)/((2+t)^2)
	 $
is equivalent to
$t <2.$
Therefore the interval
$  align(}, I(t), a(t), b(t))  $
is nonempty for any
$t \in (0,2).$
Note that
$ 
	(8t)/((2+t)^2) < (4)/(2+t)
	 $
for
$t \in (0,2).$
Therefore,
$ 
	b(t) = (8t)/((2+t)^2).
	 $
The function
$a$
is increasing on
$[0,4)$
, because
$ 
	a(t)
	= (4)/(4-t)\bigg( 1 - (2)/(t+2) \bigg).
	 $
Moreover,
$a(0)=0 $
and
$ a(2)=b(2)=1$
imply that
$ 
	\mathcal{A} \supset \mathcal{B} \supset \mathcal{C} \supset [0,1).
	 $
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