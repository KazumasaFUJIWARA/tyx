#!/usr/bin/env python3
"""
TeXからTypstへの変換器
"""

from typing import List, Optional
from ..parser.ast import (
    ASTNode, DocumentNode, SectionNode, MathNode, TheoremNode, 
    ReferenceNode, TextNode, NodeType
)
from ..utils.meta_comments import MetaCommentGenerator
from ..utils.labels import LabelManager


class TeXToTypstTransformer:
    """TeXからTypstへの変換器"""
    
    def __init__(self):
        self.meta_comment_generator = MetaCommentGenerator()
        self.label_manager = LabelManager()
        
        # 数式記号のUnicodeマッピング
        self.math_symbols = {
            'alpha': 'α',
            'beta': 'β', 
            'gamma': 'γ',
            'delta': 'δ',
            'epsilon': 'ε',
            'zeta': 'ζ',
            'eta': 'η',
            'theta': 'θ',
            'iota': 'ι',
            'kappa': 'κ',
            'lambda': 'λ',
            'mu': 'μ',
            'nu': 'ν',
            'xi': 'ξ',
            'omicron': 'ο',
            'pi': 'π',
            'rho': 'ρ',
            'sigma': 'σ',
            'tau': 'τ',
            'upsilon': 'υ',
            'phi': 'φ',
            'chi': 'χ',
            'psi': 'ψ',
            'omega': 'ω',
            'infty': '∞',
            'partial': '∂',
            'nabla': '∇',
            'pm': '±',
            'mp': '∓',
            'times': '×',
            'div': '÷',
            'leq': '≤',
            'geq': '≥',
            'neq': '≠',
            'approx': '≈',
            'equiv': '≡',
            'propto': '∝',
            'varepsilon': 'ε',
            'varphi': 'φ',
            'mathbb': 'ℝ',
            'in': '∈',
            'sim': '∼',
            'lesssim': '≲',
            'gtrsim': '≳',
            'infty': '∞',
            'cap': '∩',
            'sup': 'sup',
            'not': '¬',
            'equiv': '≡',
            'mu': 'μ',
            'quad': ' ',
            'psi': 'ψ',
        }
        
        # 数式アクセントのマッピング
        self.math_accents = {
            'dot': 'dot',
            'ddot': 'dot.double',
            'hat': 'hat',
            'bar': 'bar',
            'tilde': 'tilde',
            'vec': 'arrow',
        }
        
        # 数式関数のマッピング
        self.math_functions = {
            'sin': 'sin',
            'cos': 'cos',
            'tan': 'tan',
            'log': 'log',
            'ln': 'ln',
            'exp': 'exp',
            'sinh': 'sinh',
            'cosh': 'cosh',
            'erf': 'erf',
        }
        
        # 数式演算子のUnicodeマッピング
        self.math_operators = {
            'sum': 'Σ',
            'int': '∫',
            'prod': '∏',
            'lim': 'lim',
            'max': 'max',
            'min': 'min',
            'sup': 'sup',
            'inf': 'inf',
        }
    
    def transform(self, ast: DocumentNode) -> str:
        """ASTをTypstに変換"""
        typst_content = []
        
        # ドキュメント開始
        typst_content.append("#import \"article.typ\": *")
        typst_content.append("")
        
        # 各子要素を変換
        for child in ast.children:
            typst_content.append(self._transform_node(child))
        
        return "\n".join(typst_content)
    
    def _transform_node(self, node: ASTNode) -> str:
        """ノードをTypstに変換"""
        if node.node_type == NodeType.SECTION:
            return self._transform_section(node)
        elif node.node_type == NodeType.SUBSECTION:
            return self._transform_section(node)
        elif node.node_type == NodeType.MATH_INLINE:
            return self._transform_math_inline(node)
        elif node.node_type == NodeType.MATH_DISPLAY:
            return self._transform_math_display(node)
        elif node.node_type == NodeType.MATH_ALIGN:
            return self._transform_math_align(node)
        elif node.node_type == NodeType.MATH_ALIGN_STAR:
            return self._transform_math_align_star(node)
        elif node.node_type == NodeType.THEOREM:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.LEMMA:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.PROPOSITION:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.COROLLARY:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.DEFINITION:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.REMARK:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.EXAMPLE:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.PROOF:
            return self._transform_theorem(node)
        elif node.node_type == NodeType.REF:
            return self._transform_reference(node)
        elif node.node_type == NodeType.EQREF:
            return self._transform_reference(node)
        elif node.node_type == NodeType.CITE:
            return self._transform_reference(node)
        elif node.node_type == NodeType.TEXT:
            return self._transform_text(node)
        else:
            return f"// Unknown node type: {node.node_type}"
    
    def _transform_section(self, node: SectionNode) -> str:
        """セクションを変換"""
        if node.level == 1:
            return f"= {node.title}"
        elif node.level == 2:
            return f"== {node.title}"
        elif node.level == 3:
            return f"=== {node.title}"
        else:
            return f"= {node.title}"
    
    def _transform_math_inline(self, node: MathNode) -> str:
        """インライン数式を変換"""
        content = self._transform_math_content(node.content)
        return f"${content}$"
    
    def _transform_math_display(self, node: MathNode) -> str:
        """ディスプレイ数式を変換"""
        content = self._transform_math_content(node.content)
        return f"\t$\n\t{content}\n\t$ //[formula type:display]\n"
    
    def _transform_math_align(self, node: MathNode) -> str:
        """align環境を変換"""
        # align環境の内容を解析してTypstのalign形式に変換
        content = self._transform_align_content(node.content)
        return f"\t$\n{content}\n\t$ //[formula type:align]"
    
    def _transform_math_align_star(self, node: MathNode) -> str:
        """align*環境を変換"""
        # align*環境の内容を解析してTypstのalign形式に変換
        content = self._transform_align_content(node.content)
        return f"\t$\n{content}\n\t$ //[formula type:align*]"
    
    def _transform_theorem(self, node: TheoremNode) -> str:
        """定理環境を変換"""
        # 定理タイプのマッピング
        theorem_type_map = {
            'Theorem': 'theorem',
            'Lemma': 'lemma', 
            'Proposition': 'proposition',
            'Corollary': 'corollary',
            'Definition': 'definition',
            'Remark': 'remark',
            'Example': 'example',
            'Proof': 'proof',
            'theorem': 'theorem',
            'lemma': 'lemma',
            'proposition': 'proposition', 
            'corollary': 'corollary',
            'definition': 'definition',
            'remark': 'remark',
            'example': 'example',
            'proof': 'proof',
        }
        
        typst_type = theorem_type_map.get(node.theorem_type, 'theorem')
        
        # 引数の構築
        args = []
        if node.title:
            args.append(f'title: "{node.title}"')
        if node.label:
            args.append(f'id: "{node.label}"')
        
        args_str = ", ".join(args) if args else ""
        
        # 内容の変換
        content = self._transform_text_content(node.content)
        
        # メタコメントの追加（ラウンドトリップ用）
        meta_comment = self.meta_comment_generator.generate_theorem_meta_comment(
            node.theorem_type
        )
        
        if args_str:
            return f"#{typst_type}({args_str})[\n{content}\n] {meta_comment}"
        else:
            return f"#{typst_type}[\n{content}\n] {meta_comment}"
    
    def _transform_reference(self, node: ReferenceNode) -> str:
        """参照を変換"""
        if node.ref_type == "ref":
            return f"@{node.target} //[ref type:ref]"
        elif node.ref_type == "eqref":
            return f"@{node.target} //[ref type:eqref]"
        elif node.ref_type == "cite":
            return f"@{node.target} //[ref type:cite]"
        else:
            return f"@{node.target} //[ref type:ref]"
    
    def _transform_text(self, node: TextNode) -> str:
        """テキストを変換"""
        return self._transform_text_content(node.content)
    
    def _transform_text_content(self, content: str) -> str:
        """テキスト内容を変換"""
        import re
        
        # 参照の変換
        content = re.sub(r'\\ref\{([^}]+)\}', r'@\1 //[ref type:ref]', content)
        content = re.sub(r'\\eqref\{([^}]+)\}', r'@\1 //[ref type:eqref]', content)
        content = re.sub(r'\\cite\{([^}]+)\}', r'@\1 //[ref type:cite]', content)
        
        # 残存するTeXコマンドの処理
        content = re.sub(r'\\end\{[^}]+\}', '', content)  # \end{Lemma}等を除去
        content = re.sub(r'\\noindent', '', content)  # \noindentを除去
        
        # 重複した内容を除去（同じ内容が連続している場合）
        lines = content.split('\n')
        cleaned_lines = []
        prev_line = None
        for line in lines:
            if line.strip() != prev_line:
                cleaned_lines.append(line)
                prev_line = line.strip()
        content = '\n'.join(cleaned_lines)
        
        # 基本的なエスケープ処理（必要最小限）
        # content = content.replace("\\", "\\\\")  # コメントアウト：preambleで問題になる
        
        # タブ+スペースをタブに正規化（複数回適用）
        while '\t ' in content:
            content = re.sub(r'\t ', '\t', content)
        
        return content
    
    def _transform_align_content(self, content: str) -> str:
        """align環境の内容を変換"""
        import re
        
        # 行を分割
        lines = content.split('\n')
        converted_lines = []
        
        for line in lines:
            line = line.strip()
            if not line:
                continue
            
            # \label や \nonumber を除去
            line = re.sub(r'\\label\{[^}]+\}', '', line)
            line = re.sub(r'\\nonumber', '', line)
            
            # 残った}を除去
            line = re.sub(r'^}\s*', '', line)
            line = re.sub(r'^}\s*\\label\{[^}]+\}', '', line)  # }\\label{...}のパターンも処理
            
            # 空行をスキップ
            if not line.strip():
                continue
            
            # & で分割（複数行の数式）
            if '&' in line:
                # &= で分割して処理
                if '&=' in line:
                    parts = line.split('&=')
                    converted_parts = []
                    for part in parts:
                        # タブを保持するため、先頭の空白のみ削除
                        converted_part = self._transform_math_content(part.lstrip())
                        converted_parts.append(converted_part)
                    converted_line = " &= ".join(converted_parts)
                else:
                    parts = line.split('&')
                    converted_parts = []
                    for part in parts:
                        # タブを保持するため、先頭の空白のみ削除
                        converted_part = self._transform_math_content(part.lstrip())
                        converted_parts.append(converted_part)
                    converted_line = " &= ".join(converted_parts)
                converted_lines.append(converted_line)
            else:
                # 単一行の数式
                converted_line = self._transform_math_content(line)
                converted_lines.append(converted_line)
        
        # Typstのalign形式に変換（README.mdの仕様に従う）
        if len(converted_lines) == 1:
            result = converted_lines[0]
            # タブ+スペースをタブに正規化
            result = re.sub(r'\t ', '\t', result)
            return result
        else:
            # 各行にタブを追加し、\\を\に変換
            tabbed_lines = []
            for line in converted_lines:
                # \\を\に変換（Typstの改行）
                line = line.replace('\\\\', '\\')
                # cases環境の行は追加のタブを付けない
                if 'cases(' in line:
                    tabbed_lines.append(line)
                else:
                    tabbed_lines.append(f"\t{line}")
            
            # 全体を結合
            result = "\n".join(tabbed_lines)
            
            # cases環境の処理（複数行対応）
            lines = result.split('\n')
            in_cases = False
            cases_content = []
            new_lines = []
            
            for line in lines:
                if 'cases(' in line:
                    in_cases = True
                    cases_content = []
                    new_lines.append(line)
                elif in_cases and line.strip() == ')':
                    # cases環境の終了
                    if cases_content:
                        # cases環境内の,を\,に変換
                        combined_content = ' '.join(cases_content)
                        combined_content = combined_content.replace(',', '\\,')
                        # \ を\<改行><タブ>に変換
                        combined_content = combined_content.replace('\\ ', '\\\n\t')
                        # cases(の後に改行を追加
                        new_lines.append(f'\t{combined_content}')
                    new_lines.append(line)
                    in_cases = False
                elif in_cases:
                    # cases環境内の行
                    cases_content.append(line.strip())
                else:
                    new_lines.append(line)
            
            result = '\n'.join(new_lines)
            
            # タブ+スペースをタブに正規化
            result = re.sub(r'\t ', '\t', result)
            
            return result
    
    def _transform_math_content(self, content: str) -> str:
        """数式内容を変換（記号変換は前処理で完了済み）"""
        import re
        
        # 分数の変換は前処理で完了済み
        
        # 数式演算子の変換（前処理で完了済みのため不要）
        # 残存するコマンドのみ処理
        content = re.sub(r'\\int(?![a-zA-Z])', '∫', content)
        content = re.sub(r'\\iint(?![a-zA-Z])', '∬', content)
        content = re.sub(r'\\iiint(?![a-zA-Z])', '∭', content)
        content = re.sub(r'\\oint(?![a-zA-Z])', '∮', content)
        
        # 積分記号の下付き・上付き文字の {} を () に変換
        content = re.sub(r'∫_\{([^}]+)\}', r'∫_(\1)', content)
        content = re.sub(r'∬_\{([^}]+)\}', r'∬_(\1)', content)
        content = re.sub(r'∭_\{([^}]+)\}', r'∭_(\1)', content)
        content = re.sub(r'∮_\{([^}]+)\}', r'∮_(\1)', content)
        # 上付き文字の処理（単一文字を先に処理）
        content = re.sub(r'∫\^([a-zA-Z0-9∞])', r'∫^(\1)', content)
        content = re.sub(r'∬\^([a-zA-Z0-9∞])', r'∬^(\1)', content)
        content = re.sub(r'∭\^([a-zA-Z0-9∞])', r'∭^(\1)', content)
        content = re.sub(r'∮\^([a-zA-Z0-9∞])', r'∮^(\1)', content)
        content = re.sub(r'∫\^\{([^}]+)\}', r'∫^(\1)', content)
        content = re.sub(r'∬\^\{([^}]+)\}', r'∬^(\1)', content)
        content = re.sub(r'∭\^\{([^}]+)\}', r'∭^(\1)', content)
        content = re.sub(r'∮\^\{([^}]+)\}', r'∮^(\1)', content)
        # 一般的な上付き文字の {} を () に変換
        content = re.sub(r'\^\{([^}]+)\}', r'^(\1)', content)
        
        # 残存する\fracと\sqrtを処理
        content = re.sub(r'\\frac\{([^}]+)\}\{([^}]+)\}', r'(\1)/(\2)', content)
        content = re.sub(r'\\sqrt\{([^}]+)\}', r'sqrt(\1)', content)
        
        # 残存する\biggと\left/rightを処理
        content = re.sub(r'\\bigg\(', '( //[command type:bigg]\n\t', content)
        content = re.sub(r'\\bigg\)', ') //[command type:bigg]\n', content)
        content = re.sub(r'\\bigg\[', '[ //[command type:bigg]\n\t', content)
        content = re.sub(r'\\bigg\]', '] //[command type:bigg]\n', content)
        content = re.sub(r'\\bigg\{', '{ //[command type:bigg]\n\t', content)
        content = re.sub(r'\\bigg\}', '} //[command type:bigg]\n', content)
        
        content = re.sub(r'\\left\(', '( //[command type:left]\n\t', content)
        content = re.sub(r'\\right\)', ') //[command type:right]\n', content)
        content = re.sub(r'\\left\[', '[ //[command type:left]\n\t', content)
        content = re.sub(r'\\right\]', '] //[command type:right]\n', content)
        content = re.sub(r'\\left\{', '{ //[command type:left]\n\t', content)
        content = re.sub(r'\\right\}', '} //[command type:right]\n', content)
        
        
        # 上付き文字の変換
        content = re.sub(r'([a-zA-Z0-9]+)\^\{([^}]+)\}', r'\1^(\2)', content)
        content = re.sub(r'([a-zA-Z0-9]+)\^([a-zA-Z0-9])', r'\1^(\2)', content)
        
        # 下付き文字の変換
        content = re.sub(r'([a-zA-Z0-9]+)_\{([^}]+)\}', r'\1_(\2)', content)
        content = re.sub(r'([a-zA-Z0-9]+)_([a-zA-Z0-9])', r'\1_(\2)', content)
        
        # &= = の重複を修正
        content = re.sub(r'&=\s*=', '&=', content)
        
        # 数式アクセントの変換（README.mdの仕様に従う）
        for tex_accent, typst_accent in self.math_accents.items():
            pattern = r'\\' + re.escape(tex_accent) + r'\{([^}]+)\}'
            replacement = typst_accent + r'(\1)'
            content = re.sub(pattern, replacement, content)
        
        # 数式関数の変換
        for tex_func, typst_func in self.math_functions.items():
            pattern = r'\\' + re.escape(tex_func) + r'\('
            replacement = typst_func + r'('
            content = re.sub(pattern, replacement, content)
        
        # 記号変換は前処理で完了済みのため、ここでは不要
        
        # cases環境の変換
        content = re.sub(r'\\begin\{cases\}', 'cases(', content)
        content = re.sub(r'\\end\{cases\}', ')', content)
        content = re.sub(r'\\end\{cases', ')', content)  # 不完全な場合も処理
        
        # cases環境内の処理（複数行対応）
        def process_cases_content(match):
            cases_content = match.group(1)
            # 改行を除去して一行にまとめる
            cases_content = cases_content.replace('\n', ' ')
            # 複数のスペースを単一スペースに
            cases_content = re.sub(r'\s+', ' ', cases_content)
            # , を \, に変換（cases環境内のみ）
            cases_content = cases_content.replace(',', '\\,')
            return f'cases({cases_content})'
        
        # cases(内容)のパターンを処理（複数行対応）
        content = re.sub(r'cases\(([^)]+)\)', process_cases_content, content, flags=re.DOTALL)
        
        # その他のコマンドの処理（より安全に）
        # content = re.sub(r'\\([a-zA-Z]+)\{([^}]*)\}', r'\\\1(\2)', content)  # preambleで問題になるためコメントアウト
        
        # 空行の処理（改行を保持）
        # content = content.strip()  # 改行を保持するためコメントアウト
        
        # タブ+スペースをタブに正規化（複数回適用）
        while '\t ' in content:
            content = re.sub(r'\t ', '\t', content)
        
        return content
