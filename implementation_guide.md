# TeX to Typst 変換器 実装手順書

## 概要

この手順書は、TeX to Typst変換器の実装における標準的な作業手順をまとめたものです。

## 標準作業手順

### 1. TODOの確認
- `tex2typst_todo.md`を確認して現在の作業項目を把握
- 作業対象のTODO番号と内容を確認
- 完了済み項目と未完了項目を整理

### 2. 対象ファイルの変更
- TODOに応じて該当するファイルを特定
- 必要な修正を実装
- 変更内容を記録

#### 主要対象ファイル
- **`tyx/parser/tex_parser_improved.py`** - TeXパーサー（前処理、定理環境、数式抽出）
- **`tyx/transformer/tex_to_typst.py`** - TeX→Typst変換器（数式変換、参照変換）
- **`tyx/parser/ast.py`** - AST定義（ノードタイプ定義）
- **`sample/sample.tex`** - 入力テストファイル
- **`sample/sample_N.typ`** - 出力テストファイル（NはTODO項目番号）
- **`tex2typst_todo.md`** - TODOリスト（進捗管理）

### 3. TODO番号に沿った試験実行

#### 3.1 試験実行の手順
1. **仮想環境の有効化**
   ```bash
   cd /home/kf/github/tyx
   source venv/bin/activate
   ```

2. **修正内容の確認**
   - 修正したファイルの内容を確認
   - 変更箇所が正しく実装されているかチェック

3. **基本テストの実行**
   - TODO項目に応じた出力ファイル名でテスト実行
   - エラーが発生しないことを確認

4. **出力結果の確認**
   - 生成された`.typ`ファイルの内容を確認
   - 期待される結果と実際の結果を比較

5. **特定問題のテスト**
   - 修正した機能の個別テストを実行
   - 問題が解決されているか確認

6. **エラーハンドリング**
   - エラーが発生した場合はデバッグ情報を確認
   - 必要に応じて修正を再実施

#### 3.2 確認すべき項目
- **構文エラー**: Typstファイルが正しくコンパイルできるか
- **内容の正確性**: 変換結果が期待通りか
- **フォーマット**: 出力フォーマットが適切か
- **メタコメント**: 必要なメタコメントが追加されているか
- **Unicode変換**: 数式記号が正しくUnicode化されているか

### 4. 確認（修正か続行か）

#### 4.1 結果確認の手順
1. **出力ファイルの内容確認**
   - 生成された`.typ`ファイルを開いて内容を確認
   - 期待される結果と実際の結果を比較

2. **問題点の特定**
   - 構文エラーがないか確認
   - 変換結果が正しいか確認
   - フォーマットが適切か確認

3. **修正の必要性判断**
   - 問題があれば修正を実施
   - 問題がなければ次のTODOに進む

#### 4.2 修正が必要な場合
1. **問題の分析**
   - エラーメッセージの確認
   - 問題箇所の特定
   - 原因の分析

2. **修正の実施**
   - 対象ファイルの修正
   - 修正内容の確認

3. **再テスト**
   - 修正後の再テスト実行
   - 問題が解決されたか確認

#### 4.3 次のTODOに進む場合
1. **TODOリストの更新**
   - 完了した項目を`tex2typst_todo.md`で更新
   - 次の作業項目を確認

2. **進捗の記録**
   - 完了した作業内容を記録
   - 次のステップの準備

## 現在の進捗状況

### ✅ 完了済み項目

1. **前処理の修正（preambleをコメントアウトして保持）**
2. **参照タイプの追加（EQREF、CITE）**
3. **数式変換の修正（仕様準拠）**
4. **数式記号のUnicode化（基本的な実装）**

### 🔄 進行中・部分完了項目

5. **数式記号のUnicode化（完全実装）**
   - 基本的な記号は実装済み
   - 残存問題：`\left`と`\right`の削除が不完全

## 残存する問題

### 問題1: `\left`と`\right`の削除が不完全

**対象ファイル**: `tyx/transformer/tex_to_typst.py`
**修正箇所**: `_transform_math_content`メソッド

**現状**: 
```typst
$u \in C\left(\left[0, T_1\right) ;W^{1,\infty} \cap W^{1,1}\right)$
```

**目標**:
```typst
$u \in C([0, T_1) ;W^{1,∞} ∩ W^{1,1})$
```

### 問題2: アクセントの変換（未実装）

**対象ファイル**: `tyx/transformer/tex_to_typst.py`
**修正箇所**: `_transform_math_content`メソッド

**未実装項目**:
- `\dot{x}` → `dot(x)`
- `\ddot{x}` → `dot.double(x)`
- `\hat{x}` → `hat(x)`
- `\bar{x}` → `bar(x)`
- `\tilde{x}` → `tilde(x)`
- `\vec{x}` → `arrow(x)`

### 問題3: 定理環境の改善（未実装）

**対象ファイル**: `tyx/parser/tex_parser_improved.py`
**修正箇所**: `_parse_theorem`メソッド

**未実装項目**:
- 定理タイトルの正しい抽出
- ラベルの正しい抽出
- 定理内容の適切なフォーマット

## 標準テスト手順

### 1. 基本テスト（TODO番号に沿った試験実行）

#### テスト出力ファイル命名規則
- **`sample_1.typ`** - TODO項目1完了後の出力（前処理修正）
- **`sample_2.typ`** - TODO項目2完了後の出力（参照タイプ追加）
- **`sample_3.typ`** - TODO項目3完了後の出力（数式変換修正）
- **`sample_4.typ`** - TODO項目4完了後の出力（定理環境改善）
- **`sample_5.typ`** - TODO項目5完了後の出力（テキスト処理改善）
- **`sample_final.typ`** - 最終完成版の出力

#### 基本テストコマンド（TODO番号に応じて出力ファイル名を変更）

**TODO項目1完了後**:
```bash
cd /home/kf/github/tyx
source venv/bin/activate
python -c "
from tyx.parser.tex_parser_improved import ImprovedTeXParser
from tyx.transformer.tex_to_typst import TeXToTypstTransformer

parser = ImprovedTeXParser()
transformer = TeXToTypstTransformer()

with open('sample/sample.tex', 'r', encoding='utf-8') as f:
    tex_content = f.read()

ast = parser.parse(tex_content)
typst_content = transformer.transform(ast)

with open('sample/sample_1.typ', 'w', encoding='utf-8') as f:
    f.write(typst_content)

print('sample_1.typ生成完了')
"
```

**TODO項目2完了後**:
```bash
# 上記と同じコマンドで、出力ファイル名を sample_2.typ に変更
with open('sample/sample_2.typ', 'w', encoding='utf-8') as f:
    f.write(typst_content)
```

**TODO項目3完了後**:
```bash
# 上記と同じコマンドで、出力ファイル名を sample_3.typ に変更
with open('sample/sample_3.typ', 'w', encoding='utf-8') as f:
    f.write(typst_content)
```

**TODO項目4完了後**:
```bash
# 上記と同じコマンドで、出力ファイル名を sample_4.typ に変更
with open('sample/sample_4.typ', 'w', encoding='utf-8') as f:
    f.write(typst_content)
```

**TODO項目5完了後**:
```bash
# 上記と同じコマンドで、出力ファイル名を sample_5.typ に変更
with open('sample/sample_5.typ', 'w', encoding='utf-8') as f:
    f.write(typst_content)
```

**最終完成版**:
```bash
# 上記と同じコマンドで、出力ファイル名を sample_final.typ に変更
with open('sample/sample_final.typ', 'w', encoding='utf-8') as f:
    f.write(typst_content)
```

### 2. 特定問題のテスト

#### 数式変換テスト
```bash
# \left と \right の削除テスト
python -c "
from tyx.transformer.tex_to_typst import TeXToTypstTransformer
transformer = TeXToTypstTransformer()
result = transformer._transform_math_content(r'C\\left([0, T_1\\right)')
print(result)
"
```

#### アクセント変換テスト
```bash
# アクセント変換テスト
python -c "
from tyx.transformer.tex_to_typst import TeXToTypstTransformer
transformer = TeXToTypstTransformer()
result = transformer._transform_math_content(r'\\dot{x} + \\hat{y} + \\bar{z}')
print(result)
"
```

#### 定理環境テスト
```bash
# 定理環境テスト
python -c "
from tyx.parser.tex_parser_improved import ImprovedTeXParser
parser = ImprovedTeXParser()
result = parser._parse_theorem(r'\\begin{lemma}[Test Lemma]\\label{lem:test}This is a test.\\end{lemma}')
print(result)
"
```

## ファイル構成

```
/home/kf/github/tyx/
├── tyx/
│   ├── parser/
│   │   ├── ast.py                    # AST定義
│   │   └── tex_parser_improved.py    # TeXパーサー
│   └── transformer/
│       └── tex_to_typst.py          # TeX → Typst変換器
├── sample/
│   ├── sample.tex                   # 入力ファイル
│   ├── sample_1.typ                 # TODO項目1完了後の出力
│   ├── sample_2.typ                 # TODO項目2完了後の出力
│   ├── sample_3.typ                 # TODO項目3完了後の出力
│   ├── sample_4.typ                 # TODO項目4完了後の出力
│   ├── sample_5.typ                 # TODO項目5完了後の出力
│   └── sample_final.typ             # 最終完成版の出力
├── tex2typst_todo.md               # TODOリスト
└── implementation_guide.md         # この手順書
```

## テスト出力ファイル管理

### 命名規則
- **`sample_N.typ`** - TODO項目N完了後の出力（N=1,2,3,4,5）
- **`sample_final.typ`** - 最終完成版の出力

### ファイル管理ルール
1. **段階的保存**: 各TODO項目完了後に該当する`sample_N.typ`を生成
2. **バックアップ保持**: 前のバージョンは削除せずに保持
3. **進捗確認**: 各段階での出力を比較して改善点を特定
4. **最終版**: 全項目完了後に`sample_final.typ`を生成

## 注意事項

1. **TODO確認**: 作業開始前に必ず`tex2typst_todo.md`を確認
2. **段階的テスト**: 各修正後に必ずテストを実行
3. **TODO更新**: 完了した項目は`tex2typst_todo.md`を更新
4. **エラーハンドリング**: 予期しないエラーが発生した場合は、デバッグ情報を確認

## 次のアクション

1. **TODOの確認**: `tex2typst_todo.md`で現在の作業項目を確認
2. **対象ファイルの変更**: 
   - `tyx/transformer/tex_to_typst.py`の`_transform_math_content`メソッドで`\left`と`\right`の削除問題を修正
   - アクセント変換の実装
3. **TODO番号に沿った試験実行**: 修正内容をテスト
4. **確認（修正か続行か）**: 結果を確認して次のステップを決定

## 具体的な修正手順

### 手順1: `\left`と`\right`の削除修正
1. `tyx/transformer/tex_to_typst.py`を開く
2. `_transform_math_content`メソッドを確認
3. `\left`と`\right`の削除処理を修正
4. 正規表現の順序を調整

### 手順2: アクセント変換の実装
1. `tyx/transformer/tex_to_typst.py`を開く
2. `_transform_math_content`メソッドにアクセント変換処理を追加
3. 各アクセント記号のTypst関数形式への変換を実装

### 手順3: 定理環境の改善
1. `tyx/parser/tex_parser_improved.py`を開く
2. `_parse_theorem`メソッドを修正
3. 定理タイトル、ラベル、内容の正しい抽出を実装

---

**最終目標**: 完全にコンパイル可能なTypstファイルの生成、元のTeXファイルの構造と内容の保持、人間が読みやすいTypstコードの生成、ラウンドトリップ変換の可逆性
