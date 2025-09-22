# TeX ⇄ Typst 変換規則書

## 概要

この文書は、TeXからTypstへの変換器（tyx）の現在の変換規則をまとめたものです。変換器は往復可逆性と人間可読性を最優先として設計されています。

## 変換アーキテクチャ

### 主要コンポーネント

1. **パーサー** (`tyx/parser/tex_parser_improved.py`)
   - 単純な辞書変換（\alpha, \int等）を前処理で実行
   - 数式環境の認識と構造抽出
   - AST（抽象構文木）の構築

2. **変換器** (`tyx/transformer/tex_to_typst.py`)
   - ASTをTypst形式に変換
   - 残存する数式変換を実行
   - メタコメントの生成

3. **ユーティリティ**
   - `tyx/utils/unicode.py`: Unicode変換
   - `tyx/utils/meta_comments.py`: メタコメント処理
   - `tyx/utils/labels.py`: ラベル管理

## 変換規則

### 1. 文書構造

#### セクション
```tex
\section{タイトル}
\subsection{タイトル}
\subsubsection{タイトル}
```
↓
```typst
= タイトル
== タイトル
=== タイトル
```

**注意**: 現在の実装では`\subsection`は`\section`と同じ処理（`# タイトル`）になります。

### 2. 数式変換

**処理順序**: 単純な辞書変換（\alpha, \int等） → 数式環境の認識 → AST構築 → 残存する変換

#### 2.1 数式環境

**インライン数式**
```tex
$x^2$
```
↓
```typst
$x^2$
```

**ディスプレイ数式**
```tex
\[
x^2
\]
```
↓
```typst
	$
	x^2
	$ //[formula type:display]
```

**align環境**
```tex
\begin{align}
a &= b\\
&= c \label{eq:test}
\end{align}
```
↓
```typst
	$
	a &= b\\
	&= c
	$ //[formula type:align]
	<eq:test>
```

**align*環境**
```tex
\begin{align*}
a &= b\\
&= c
\end{align*}
```
↓
```typst
	$
	a &= b\\
	&= c
	$ //[formula type:align*]
```

#### 2.2 数式記号の変換

**ギリシャ文字**
```tex
\alpha, \beta, \gamma, \delta, \epsilon, \zeta, \eta, \theta
```
↓
```typst
α, β, γ, δ, ε, ζ, η, θ
```

**数学記号**
```tex
\infty, \partial, \nabla, \pm, \mp, \times, \div, \leq, \geq, \neq
```
↓
```typst
∞, ∂, ∇, ±, ∓, ×, ÷, ≤, ≥, ≠
```

**演算子**
```tex
\sum, \int, \prod, \lim, \max, \min, \sup, \inf
```
↓
```typst
Σ, ∫, ∏, lim, max, min, sup, inf
```

**積分記号の詳細処理**
```tex
\int_{a+b}^\infty f(x) dx
```
↓
```typst
∫_(a+b)^∞ f(x) d x
```

**注意**: `\int`の下付き・上付き文字の`{}`は`()`に変換されます。

#### 2.3 数式アクセント

```tex
\dot{x}, \ddot{x}, \hat{x}, \bar{x}, \tilde{x}, \vec{x}
```
↓
```typst
dot(x), dot.double(x), hat(x), bar(x), tilde(x), arrow(x)
```

#### 2.4 数式関数

```tex
\sin, \cos, \tan, \log, \ln, \exp, \sinh, \cosh, \erf
```
↓
```typst
sin, cos, tan, log, ln, exp, sinh, cosh, erf
```

#### 2.5 分数と根号

```tex
\frac{a}{b}, \sqrt{x}
```
↓
```typst
(a)/(b), sqrt(x)
```

#### 2.6 上付き・下付き文字

```tex
x^{2}, x_{i}, x^{a}_{b}
```
↓
```typst
x^(2), x_(i), x_(b)^(a)
```

#### 2.7 cases環境

```tex
\begin{cases}
x & \text{if } x > 0 \\
-x & \text{if } x \leq 0
\end{cases}
```
↓
```typst
	cases(
		x & quad "if" quad x > 0\,\
		-x & quad "if" quad x ≤ 0
	)
```

### 3. 定理環境

```tex
\begin{theorem}[タイトル]\label{thm:example}
定理の内容
\end{theorem}
```
↓
```typst
#theorem(title: "タイトル", id: "thm:example")[
定理の内容
] //[theorem]
```

**対応する定理タイプ:**
- `theorem` → `#theorem`
- `lemma` → `#lemma`
- `proposition` → `#proposition`
- `corollary` → `#corollary`
- `definition` → `#definition`
- `remark` → `#remark`
- `example` → `#example`
- `proof` → `#proof`

### 4. 参照

#### 通常参照
```tex
\ref{label}
```
↓
```typst
@label //[ref type:ref]
```

#### 数式参照
```tex
\eqref{label}
```
↓
```typst
@label //[ref type:eqref]
```

#### 引用
```tex
\cite{key1,key2}
```
↓
```typst
@key1 //[ref type:cite]
,
@key2 //[ref type:cite]
```

### 5. ラベル管理

#### ラベルの正規化
- 定理: `theorem:label`
- 数式: `eq:label`
- 図: `fig:label`
- 表: `table:label`
- セクション: `section:label`

#### ラベル抽出
```tex
\label{eq:example}
```
↓
```typst
<eq:example>
```

### 6. メタコメント

ラウンドトリップ変換の可逆性を保証するためのメタコメントが自動生成されます。

#### 数式のメタコメント
- `//[formula type:display]`
- `//[formula type:align]`
- `//[formula type:align*]`

#### 参照のメタコメント
- `//[ref type:ref]`
- `//[ref type:eqref]`
- `//[ref type:cite]`

#### 定理のメタコメント
- `//[theorem]`
- `//[lemma]`
- `//[proposition]`
- など

### 7. 前処理

#### Preambleの保持
```tex
\usepackage{amsmath}
\newcommand{\foo}{bar}
```
↓
```typst
// \usepackage{amsmath}
// \newcommand{\foo}{bar}

#import "article.typ": *
```

### 8. 特殊な処理

#### 変数の空白分離
```tex
\int_0^1 x dx
```
↓
```typst
∫_0^1 x d x
```

#### ノルム記号
```tex
\|x\|, \left\|x\right\|
```
↓
```typst
norm(x)
```

**注意**: 現在の実装では`r'\\|([^|]+)\\|'`の正規表現が日本語文字を誤ってマッチする問題があります。

#### 大きな括弧
```tex
\left( \right), \bigg( \bigg)
```
↓
```typst
( //[command type:left]
	内容
) //[command type:right]
```

### 9. エラーハンドリング

#### 未知のコマンド
```tex
\unknown{content}
```
↓
```typst
unknown(content) //[latex:\unknown]
```

#### 未知の環境
```tex
\begin{unknown}
content
\end{unknown}
```
↓
```typst
/* env:unknown */
content
```

### 10. 出力フォーマット

#### インデント規則
- ブロック要素: タブ（`\t`）でインデント
- 数式: タブでインデント
- ネスト: タブの階層で表現

#### 改行規則
- 数式の改行: `\\` → `\`
- 段落: 空行で分離
- 長い行: 80文字目安で折り返し

## 実装状況

### 完了済み
- [x] 基本的なパーサーの実装
- [x] 基本的な変換器の実装
- [x] 数式記号のUnicode変換
- [x] 定理環境の変換
- [x] 参照の変換
- [x] メタコメントの生成
- [x] ラベル管理

### 進行中
- [ ] 複雑な数式構文の完全対応
- [ ] パフォーマンス最適化
- [ ] エラーハンドリングの改善

### 未実装
- [ ] TikZ図の変換
- [ ] 複雑なパッケージの対応
- [ ] カスタムコマンドの完全対応

## 制限事項

1. **TikZ図**: 現在はコメントアウトして保持
2. **複雑なパッケージ**: 基本的なamsmathパッケージのみ対応
3. **カスタムコマンド**: 基本的な変換のみ
4. **表**: 基本的な表構造のみ対応
5. **ノルム記号**: `r'\\|([^|]+)\\|'`の正規表現が日本語文字を誤ってマッチする問題
6. **サブセクション**: `\subsection`は`\section`と同じ処理になる

## 使用方法

```bash
# TeXからTypstへの変換
python -m tyx.tex_to_typst input.tex output.typ

# TypstからTeXへの変換（将来実装予定）
python -m tyx.typst_to_tex input.typ output.tex
```

## 参考資料

- [README.md](../README.md): プロジェクトの概要
- [tex2typst_todo.md](../tex2typst_todo.md): 実装状況とTODO
- [implementation_guide.md](../implementation_guide.md): 実装ガイド