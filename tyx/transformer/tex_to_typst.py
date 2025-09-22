#!/usr/bin/env python3
"""
TeXからTypstへの変換器
"""

from typing import List, Optional
from ..parser.ast import (
    ASTNode, DocumentNode, SectionNode, MathNode, TheoremNode, 
    ReferenceNode, TextNode, NormNode, AbsNode, NodeType
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
        
        # 最後に統一的なインデント処理を実行
        result = "\n".join(typst_content)
        result = self._normalize_indentation(result)
        
        return result
    
    def _normalize_indentation(self, content: str) -> str:
        """統一的なインデント処理を実行"""
        import re
        
        lines = content.split('\n')
        normalized_lines = []
        
        for line in lines:
            # 数式のインデントを正規化
            if line.strip().startswith('$') and line.strip().endswith('$'):
                # インライン数式はインデントなし
                if '//[formula type:' not in line:
                    normalized_lines.append(line.strip())
                    continue
            
            # ディスプレイ数式のインデント正規化
            if '//[formula type:display]' in line:
                # 数式ブロック全体を1レベルインデント
                if line.strip().startswith('$'):
                    normalized_lines.append('\t' + line.strip())
                elif line.strip().endswith('$'):
                    normalized_lines.append('\t' + line.strip())
                else:
                    normalized_lines.append('\t' + line.strip())
                continue
            
            # ディスプレイ数式の開始行（単独の$）も1レベルインデント
            if line.strip() == '$' and not line.startswith('\t'):
                normalized_lines.append('\t' + line.strip())
                continue
            
            # align環境のインデント正規化
            if '//[formula type:align' in line:
                # 数式ブロック全体を1レベルインデント
                if line.strip().startswith('$'):
                    normalized_lines.append('\t' + line.strip())
                elif line.strip().endswith('$'):
                    normalized_lines.append('\t' + line.strip())
                else:
                    normalized_lines.append('\t' + line.strip())
                continue
            
            # cases環境のインデント正規化
            if 'cases(' in line or '//[command type:cases]' in line:
                # cases( は1レベルインデント
                if line.strip().startswith('cases('):
                    normalized_lines.append('\t' + line.strip())
                # cases終了の ) //[command type:cases] は1レベルインデント
                elif line.strip().endswith('//[command type:cases]'):
                    normalized_lines.append('\t' + line.strip())
                # cases内の各行は2レベルインデント
                elif line.strip() and not line.strip().startswith(')'):
                    normalized_lines.append('\t\t' + line.strip())
                else:
                    normalized_lines.append(line)
                continue
            
            # その他の行はそのまま
            normalized_lines.append(line)
        
        return '\n'.join(normalized_lines)
    
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
        elif node.node_type == NodeType.NORM:
            return self._transform_norm(node)
        elif node.node_type == NodeType.ABS:
            return self._transform_abs(node)
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
        # 子ノードがある場合は子ノードを変換
        if node.children:
            content_parts = []
            # 特殊なノード（AbsNode、NormNode）がある場合は、それらのみを使用
            special_nodes = [child for child in node.children if child.node_type in [NodeType.ABS, NodeType.NORM]]
            if special_nodes:
                for child in special_nodes:
                    content_parts.append(self._transform_node(child))
            else:
                # 特殊なノードがない場合はすべての子ノードを使用
                for child in node.children:
                    content_parts.append(self._transform_node(child))
            content = "".join(content_parts)
        else:
            content = self._transform_math_content(node.content)
        
        # 最後の処理：^と_の後の(?)や{?}を?にする変換（1文字の場合のみ）
        import re
        content = re.sub(r'([\^_])\((.)\)', r'\1\2', content)
        content = re.sub(r'([\^_])\{(.)\}', r'\1\2', content)
        
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
    
    def _transform_norm(self, node: NormNode) -> str:
        """ノルム記号を変換"""
        # 子ノードがある場合は、それらを置換してから残りの内容を処理
        if node.children:
            inner_content = node.content
            # 子ノードの絶対値記号を置換
            for child in node.children:
                if child.node_type == NodeType.ABS:
                    # 絶対値記号のパターンを検索して置換
                    import re
                    abs_pattern = r'\\bigg\s*\|(.*?)\\bigg\s*\|'
                    match = re.search(abs_pattern, inner_content, re.DOTALL)
                    if match and match.group(1).strip() == child.content:
                        replacement = self._transform_abs(child)
                        inner_content = inner_content[:match.start()] + replacement + inner_content[match.end():]
            
            # 残りの内容を反復的に変換
            inner_content = self._transform_norm_content_iterative(inner_content)
            # 積分記号などの他の数学記号も変換
            inner_content = self._transform_math_content(inner_content)
            # _transform_math_contentの最後の処理も適用
            inner_content = re.sub(r'([\^_])\((.)\)', r'\1\2', inner_content)
            inner_content = re.sub(r'([\^_])\{(.)\}', r'\1\2', inner_content)
        else:
            # 内側の内容を反復的に変換
            inner_content = self._transform_norm_content_iterative(node.content)
        
        # 最後の処理：^と_の後の(?)や{?}を?にする変換（1文字の場合のみ）
        import re
        inner_content = re.sub(r'([\^_])\((.)\)', r'\1\2', inner_content)
        inner_content = re.sub(r'([\^_])\{(.)\}', r'\1\2', inner_content)
        
        if node.subscript:
            return f"norm({inner_content})_({node.subscript})"
        else:
            return f"norm({inner_content})"
    
    def _transform_norm_content_iterative(self, content: str) -> str:
        """ノルム記号の内容を反復的に変換"""
        import re
        
        # 変換が起こらなくなるまで繰り返す
        prev_content = ""
        current_content = content
        
        while prev_content != current_content:
            prev_content = current_content
            
            # \| ... \|_{...} を norm(...)_(...) に変換
            pattern = r'\\\|\s*([^|]+?)\s*\\\|\s*_\{\s*(.*?)\s*\}'
            match = re.search(pattern, current_content, re.DOTALL)
            
            if match:
                inner = match.group(1).strip()
                subscript = match.group(2).strip()
                
                # 内側の内容を再帰的に変換
                inner_converted = self._transform_norm_content_iterative(inner)
                
                # 置換を実行
                replacement = f'norm({inner_converted})_({subscript})'
                current_content = current_content[:match.start()] + replacement + current_content[match.end():]
        
        return current_content
    
    def _transform_abs(self, node: AbsNode) -> str:
        """絶対値記号を変換"""
        # 内側の内容を変換
        inner_content = self._transform_abs_content_iterative(node.content)
        return f"abs({inner_content})"
    
    def _transform_abs_content_iterative(self, content: str) -> str:
        """絶対値記号の内容を反復的に変換"""
        import re
        
        # 変換が起こらなくなるまで繰り返す
        prev_content = ""
        current_content = content
        
        while prev_content != current_content:
            prev_content = current_content
            
            # \bigg| ... \bigg| を abs(...) に変換
            pattern = r'\\bigg\s*\|(.*?)\\bigg\s*\|'
            match = re.search(pattern, current_content, re.DOTALL)
            
            if match:
                inner = match.group(1).strip()
                # 内側の内容を再帰的に変換
                inner_converted = self._transform_abs_content_iterative(inner)
                # 置換を実行
                replacement = f'abs({inner_converted})'
                current_content = current_content[:match.start()] + replacement + current_content[match.end():]
        
        return current_content
    
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
        
        
        # 通常テキストでは変数の空白分離は行わない（数式のみで実施）
        
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
        
        # 数式アクセントの変換（最初に実行）
        for tex_accent, typst_accent in self.math_accents.items():
            pattern = r'\\' + re.escape(tex_accent) + r'\{([^}]+)\}'
            replacement = typst_accent + r'(\1)'
            content = re.sub(pattern, replacement, content)
        
        # 分数の変換は前処理で完了済み
        
        # 数式演算子の変換（前処理で完了済みのため不要）
        # 残存するコマンドのみ処理
        content = re.sub(r'\\int(?![a-zA-Z])', '∫', content)
        content = re.sub(r'\\iint(?![a-zA-Z])', '∬', content)
        content = re.sub(r'\\iiint(?![a-zA-Z])', '∭', content)
        content = re.sub(r'\\oint(?![a-zA-Z])', '∮', content)
        
        # 特別な処理：∫_{ℂ dot.double(f) を ∫_(ℂ) dot.double(f) に変換（最初に処理）
        if '∫_{' in content and 'dot.double(' in content:
            # ∫_{ から dot.double( の前までを () で囲む
            start = content.find('∫_{')
            dot_start = content.find('dot.double(')
            if start != -1 and dot_start != -1 and dot_start > start:
                inner_content = content[start+3:dot_start-1]  # 空白を除く
                content = content[:start+2] + '(' + inner_content + ') ' + content[dot_start:]
        
        # 積分記号の下付き・上付き文字の {} を () に変換（特別な処理の後は除外）
        if '∫_{' not in content or 'dot.double(' not in content:
            content = re.sub(r'∫_\{([^}]+)\}', r'∫_(\1)', content)
        # 下付き文字の処理（数式アクセントの後）
        # ∫_(ℂ) dot.double(f) の状態では処理をスキップ
        if not (content.count('∫_(') == 1 and 'dot.double(' in content):
            content = re.sub(r'∫_([^{}]+)', r'∫_(\1)', content)
        
        # 余分な括弧を修正：∫_((ℋ_+) hat(f)) → ∫_(ℋ_+) hat(f)
        content = re.sub(r'∫_\(\(([^)]+)\)\s+([^)]+)\)', r'∫_(\1) \2', content)
        # Σ_{𝔄} を Σ_(𝔄) に修正
        content = re.sub(r'Σ_\{([^}]+)\}', r'Σ_(\1)', content)
        # \| ... \|_{...} を norm(...)_(...) に変換（括弧バランス考慮）
        def process_norm_balanced(text):
            """ノルム記号を括弧バランスを考慮して処理"""
            # 変換が起こらなくなるまで繰り返す
            prev_text = ""
            current_text = text
            
            while prev_text != current_text:
                prev_text = current_text
                
                # ノルム記号の開始位置を検索
                start_pos = current_text.find('\\|')
                if start_pos == -1:
                    break
                
                # ノルム記号の終了位置を検索（括弧のバランスを考慮）
                norm_end = find_norm_end(current_text, start_pos)
                if norm_end == -1:
                    break
                
                # ノルム記号の内容を抽出
                norm_content = current_text[start_pos:norm_end]
                
                # \| ... \|_{...} のパターンを解析
                norm_match = re.match(r'\\\|\s*(.*?)\s*\\\|\s*_\{\s*(.*?)\s*\}', norm_content, re.DOTALL)
                if norm_match:
                    inner = norm_match.group(1).strip()
                    subscript = norm_match.group(2).strip()
                    
                    # 置換を実行
                    replacement = f'norm({inner})_({subscript})'
                    current_text = current_text[:start_pos] + replacement + current_text[norm_end:]
            
            return current_text
        
        def find_norm_end(text, start_pos):
            """ノルム記号の終了位置を検索（括弧のバランスを考慮）"""
            pos = start_pos + 2  # \| の後
            brace_count = 0
            in_subscript = False
            
            while pos < len(text):
                if text[pos:pos+2] == '\\|' and brace_count == 0:
                    # ノルム記号の終了を発見
                    pos += 2
                    # 下付き文字の開始を検索
                    while pos < len(text) and text[pos] in ' \t':
                        pos += 1
                    if pos < len(text) and text[pos] == '_':
                        pos += 1
                        while pos < len(text) and text[pos] in ' \t':
                            pos += 1
                        if pos < len(text) and text[pos] == '{':
                            pos += 1
                            brace_count = 1
                            in_subscript = True
                            while pos < len(text) and brace_count > 0:
                                if text[pos] == '{':
                                    brace_count += 1
                                elif text[pos] == '}':
                                    brace_count -= 1
                                pos += 1
                            return pos
                    return pos
                elif text[pos] == '{' and not in_subscript:
                    brace_count += 1
                elif text[pos] == '}' and not in_subscript:
                    brace_count -= 1
                pos += 1
            
            return -1
        
        content = process_norm_balanced(content)
        # 残存する下付き文字の {} を () に変換（複雑な内容に対応）
        content = re.sub(r'∫_\{([^{}]*(?:\([^)]*\)[^{}]*)*)\}', r'∫_(\1)', content)
        # 下付き文字の処理を正しく修正
        # ∫_{...} の { から } までを正しく抽出
        content = re.sub(r'∫_\{([^}]+)\}', r'∫_(\1)', content)
        # より直接的なアプローチ：∫_{ から最後の } までを () に変換
        if '∫_{' in content:
            start = content.find('∫_{')
            if start != -1:
                # 最後の } を見つける
                end = content.rfind('}')
                if end != -1 and end > start:
                    inner_content = content[start+3:end]
                    content = content[:start+2] + '(' + inner_content + ')' + content[end+1:]
                else:
                    # } がない場合は、∫_{ の後のすべてを () で囲む
                    inner_content = content[start+3:]
                    content = content[:start+2] + '(' + inner_content + ')'
        content = re.sub(r'∬_\{([^}]+)\}', r'∬_(\1)', content)
        content = re.sub(r'∭_\{([^}]+)\}', r'∭_(\1)', content)
        content = re.sub(r'∮_\{([^}]+)\}', r'∮_(\1)', content)
        # 単一文字の下付き文字も処理（Unicode文字を含む）
        content = re.sub(r'∮_([A-Za-zΑ-Ωα-ω])', r'∮_(\1)', content)
        # 単一文字の下付き文字も処理（Unicode文字を含む）
        content = re.sub(r'∫_([A-Za-zΑ-Ωα-ω])', r'∫_(\1)', content)
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
        
        # 数式アクセントの変換（下付き文字の処理より前に実行）
        for tex_accent, typst_accent in self.math_accents.items():
            pattern = r'\\' + re.escape(tex_accent) + r'\{([^}]+)\}'
            replacement = typst_accent + r'(\1)'
            content = re.sub(pattern, replacement, content)
        
        # 残存する\fracと\sqrtを処理
        content = re.sub(r'\\frac\{([^}]+)\}\{([^}]+)\}', r'(\1)/(\2)', content)
        content = re.sub(r'\\sqrt\{([^}]+)\}', r'sqrt(\1)', content)
        
        # \quadをquadに変換
        content = re.sub(r'\\quad', 'quad', content)
        
        # \mathrm{text}を"text"に変換
        content = re.sub(r'\\mathrm\{([^}]+)\}', r'"\1"', content)
        
        # cases環境の変換（コマンド保護処理より前）
        content = re.sub(r'\\begin\{cases\}', 'cases(', content)
        content = re.sub(r'\\end\{cases\}', ') //[command type:cases]', content)
        content = re.sub(r'\\end\{cases', ') //[command type:cases]', content)  # 不完全な場合も処理
        
        
        # 改行文字の前後のcasesを適切に処理
        content = re.sub(r'\ncases\(', '\ncases(', content)
        content = re.sub(r'cases\(\n', 'cases(\n', content)
        
        # 改行文字を含むcasesを保護
        content = re.sub(r'\ncases\(', '__CASES_START__', content)
        content = re.sub(r'cases\(\n', '__CASES_START__', content)
        
        # 改行文字を含むcasesを保護
        content = re.sub(r'\ncases\(', '__CASES_START__', content)
        content = re.sub(r'cases\(\n', '__CASES_START__', content)
        
        # 改行文字を含むcasesを保護
        content = re.sub(r'\ncases\(', '__CASES_START__', content)
        content = re.sub(r'cases\(\n', '__CASES_START__', content)
        
        # 改行文字を含むcasesを保護
        content = re.sub(r'\ncases\(', '__CASES_START__', content)
        content = re.sub(r'cases\(\n', '__CASES_START__', content)
        
        # 改行文字を含むcasesを保護
        content = re.sub(r'\ncases\(', '__CASES_START__', content)
        content = re.sub(r'cases\(\n', '__CASES_START__', content)
        
        # 改行文字を含むcasesを保護
        content = re.sub(r'\ncases\(', '__CASES_START__', content)
        content = re.sub(r'cases\(\n', '__CASES_START__', content)
        
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
        
        
        # 数式関数の変換
        for tex_func, typst_func in self.math_functions.items():
            pattern = r'\\' + re.escape(tex_func) + r'\('
            replacement = typst_func + r'('
            content = re.sub(pattern, replacement, content)
        
        # 記号変換は前処理で完了済みのため、ここでは不要
        
        
        # その他のコマンドの処理（より安全に）
        # content = re.sub(r'\\([a-zA-Z]+)\{([^}]*)\}', r'\\\1(\2)', content)  # preambleで問題になるためコメントアウト
        
        # 空行の処理（改行を保持）
        # content = content.strip()  # 改行を保持するためコメントアウト
        
        # タブ+スペースをタブに正規化（複数回適用）
        while '\t ' in content:
            content = re.sub(r'\t ', '\t', content)
        
        # 変数の空白分離：予約関数名以外の連続するアルファベットを空白で分離
        reserved_functions = ['sin', 'cos', 'tan', 'cot', 'sec', 'csc', 'arcsin', 'arccos', 'arctan', 
                            'sinh', 'cosh', 'tanh', 'coth', 'sech', 'csch', 'log', 'ln', 'exp', 
                            'max', 'min', 'sup', 'inf', 'lim', 'limsup', 'liminf', 'gcd', 'lcm',
                            'det', 'rank', 'trace', 'dim', 'ker', 'im', 'span', 'norm', 'abs', 'cases',
                            'command', 'type', 'if', 'then', 'else', 'and', 'or', 'not', 'quad', 'FUNC']
        
        # コマンド内のテキストを保護してから変数分離を実行
        # \mathrm{...}, \mathbf{...} などのコマンド内のテキストを一時的に置換
        command_placeholders = {}
        placeholder_counter = 0
        
        # コマンド内のテキストを保護
        def protect_command_content(match):
            nonlocal placeholder_counter
            placeholder = f"__CMD_{placeholder_counter}__"
            command_placeholders[placeholder] = match.group(0)
            placeholder_counter += 1
            return placeholder
        
        # \mathrm{...}, \mathbf{...} などのコマンドを保護
        content = re.sub(r'\\[a-zA-Z]+\{[^}]*\}', protect_command_content, content)
        
        # 連続するアルファベットを空白で分離（予約関数名は除く）
        def separate_variables(match):
            text = match.group(0)
            # プレースホルダーは変数分離しない
            if text.startswith('__CMD_') or text.startswith('__FUNC_') or text.startswith('__COMMENT_'):
                return text
            # 改行文字を含む場合は、改行文字を除いてチェック
            clean_text = text.replace('\n', '').replace('\r', '')
            # 予約関数名かチェック
            for func in reserved_functions:
                if clean_text == func:
                    return text  # 元の文字列をそのまま返す
            # 予約関数名でない場合は空白で分離
            return ' '.join(text)
        
        # コメント部分を保護してから変数分離
        comment_placeholders = {}
        comment_counter = 0
        
        def protect_comment(match):
            nonlocal comment_counter
            placeholder = f"__COMMENT_{comment_counter}__"
            comment_placeholders[placeholder] = match.group(0)
            comment_counter += 1
            return placeholder
        
        # //[...] 形式のコメントを保護
        content = re.sub(r'//\[[^\]]+\]', protect_comment, content)
        
        # 改行文字の前後を適切に処理してから変数分離
        # 関数呼び出しパターンを保護してから変数分離
        # cases(, sin(, cos( などのパターンを保護（改行文字を含む場合も）
        content = re.sub(r'([a-zA-Z]+)\(', r'__FUNC_\1__(', content)
        
        # 改行文字を含む関数呼び出しパターンも保護
        content = re.sub(r'([a-zA-Z]+)\(', r'__FUNC_\1__(', content)
        
        # 改行文字を含む関数呼び出しパターンも保護
        content = re.sub(r'([a-zA-Z]+)\(', r'__FUNC_\1__(', content)
        
        # 改行文字を含む関数呼び出しパターンも保護
        content = re.sub(r'([a-zA-Z]+)\(', r'__FUNC_\1__(', content)
        
        # 改行文字を含む関数呼び出しパターンも保護
        content = re.sub(r'([a-zA-Z]+)\(', r'__FUNC_\1__(', content)
        
        # 改行文字を含む関数呼び出しパターンも保護
        content = re.sub(r'([a-zA-Z]+)\(', r'__FUNC_\1__(', content)
        
        # 通常の変数分離（プレースホルダーと関数呼び出しパターンを除外）
        def enhanced_separate_variables(match):
            text = match.group(0)
            # __で囲まれたプレースホルダーは分離しない
            if text.startswith('__') and text.endswith('__'):
                return text
            # 通常の変数分離処理
            return separate_variables(match)
        
        content = re.sub(r'(?!__[A-Z_]*__)[a-zA-Z]{2,}(?!\()', enhanced_separate_variables, content)
        
        # 関数呼び出しパターンを元に戻す
        content = re.sub(r'__FUNC_([a-zA-Z\s]+)__\(', lambda m: m.group(1).replace(' ', '') + '(', content)
        
        # 変数分離された関数名を元に戻す
        content = re.sub(r'__FUNC_([a-zA-Z\s]+)__\(', lambda m: m.group(1).replace(' ', '') + '(', content)
        
        # 変数分離された関数名を元に戻す
        content = re.sub(r'__FUNC_([a-zA-Z\s]+)__\(', lambda m: m.group(1).replace(' ', '') + '(', content)
        
        # 変数分離された関数名を元に戻す
        content = re.sub(r'__FUNC_([a-zA-Z\s]+)__\(', lambda m: m.group(1).replace(' ', '') + '(', content)
        
        # 変数分離された関数名を元に戻す
        content = re.sub(r'__FUNC_([a-zA-Z\s]+)__\(', lambda m: m.group(1).replace(' ', '') + '(', content)
        
        # 変数分離された関数名を元に戻す
        content = re.sub(r'__FUNC_([a-zA-Z\s]+)__\(', lambda m: m.group(1).replace(' ', '') + '(', content)
        
        # 保護したコメントを元に戻す
        for placeholder, original in comment_placeholders.items():
            content = content.replace(placeholder, original)
        
        # 保護したコマンドを元に戻す
        for placeholder, original in command_placeholders.items():
            content = content.replace(placeholder, original)
        
        # 保護したcasesを元に戻す
        content = content.replace('__CASES_START__', 'cases(')
        
        # 最後の処理：^と_の後の(?)や{?}を?にする変換（1文字の場合のみ）
        content = re.sub(r'([\^_])\((.)\)', r'\1\2', content)
        content = re.sub(r'([\^_])\{(.)\}', r'\1\2', content)
        
        return content
