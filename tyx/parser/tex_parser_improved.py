#!/usr/bin/env python3
"""
改良されたTeXパーサー
"""

import re
from typing import List, Optional, Tuple
from .ast import (
    ASTNode, DocumentNode, SectionNode, MathNode, TheoremNode, 
    ReferenceNode, TextNode, NodeType
)


class ImprovedTeXParser:
    """改良されたTeXパーサー"""
    
    def __init__(self):
        # 数式記号のUnicodeマッピング（前処理で使用）
        self.math_symbols = {
            'alpha': 'α', 'beta': 'β', 'gamma': 'γ', 'delta': 'δ',
            'epsilon': 'ε', 'zeta': 'ζ', 'eta': 'η', 'theta': 'θ',
            'iota': 'ι', 'kappa': 'κ', 'lambda': 'λ', 'mu': 'μ',
            'nu': 'ν', 'xi': 'ξ', 'omicron': 'ο', 'pi': 'π',
            'rho': 'ρ', 'sigma': 'σ', 'tau': 'τ', 'upsilon': 'υ',
            'phi': 'φ', 'chi': 'χ', 'psi': 'ψ', 'omega': 'ω',
            'infty': '∞', 'partial': '∂', 'nabla': '∇', 'Delta': 'Δ',
            'varepsilon': 'ε', 'varphi': 'φ', 'in': '∈', 'sim': '∼',
            'lesssim': '≲', 'gtrsim': '≳', 'cap': '∩',
            'not': '¬', 'equiv': '≡', 'quad': ' ', 'mathbb': 'ℝ',
            'leq': '≤', 'geq': '≥', 'll': '≪', 'gg': '≫',
            'times': '×'
        }
        
        # 数式演算子のUnicodeマッピング
        self.math_operators = {
            'sum': 'Σ', 'int': '∫', 'prod': '∏', 'lim': 'lim',
            'sin': 'sin', 'cos': 'cos', 'tan': 'tan', 'log': 'log',
            'ln': 'ln', 'exp': 'exp', 'max': 'max', 'min': 'min',
            'sup': 'sup', 'inf': 'inf'
        }
    
    def parse(self, tex_content: str) -> DocumentNode:
        """TeXコンテンツを解析してASTに変換"""
        document = DocumentNode(node_type=NodeType.DOCUMENT, content="")
        
        # 前処理：不要な部分を除去
        cleaned_content = self._preprocess(tex_content)
        
        # 主要な構造を抽出
        elements = self._extract_elements(cleaned_content)
        
        # 各要素をASTノードに変換
        for element in elements:
            node = self._parse_element(element)
            if node:
                document.add_child(node)
        
        return document
    
    def _preprocess(self, tex_content: str) -> str:
        """前処理：preambleをコメントアウトして保持"""
        lines = tex_content.split('\n')
        processed_lines = []
        in_preamble = True
        in_abstract = False
        in_multiline_command = False
        brace_count = 0
        
        for line in lines:
            # \begin{document}までをpreambleとして扱う
            if '\\begin{document}' in line:
                in_preamble = False
                fixed_line = line.replace('\\\\', '\\')
                processed_lines.append('// ' + fixed_line)
                continue
            
            # \end{document}の処理
            if '\\end{document}' in line:
                processed_lines.append(line)
                continue
            
            # preamble内の処理
            if in_preamble:
                # 行コメントをTypstコメントに変換
                if line.strip().startswith('%'):
                    # %を// %に変換
                    typst_comment = line.replace('%', '// %', 1)
                    processed_lines.append(typst_comment)
                else:
                    # preambleコマンドをコメントアウト
                    preamble_commands = [
                        '\\documentclass',
                        '\\usepackage',
                        '\\mathtoolsset',
                        '\\newtheorem',
                        '\\title',
                        '\\author',
                        '\\address',
                        '\\email',
                        '\\subjclass',
                        '\\keywords',
                        '\\maketitle',
                    ]
                    
                    is_preamble_command = any(line.strip().startswith(cmd) for cmd in preamble_commands)
                    if is_preamble_command:
                        # \\を\に修正してコメントアウト
                        fixed_line = line.replace('\\\\', '\\')
                        processed_lines.append('// ' + fixed_line)
                    else:
                        processed_lines.append(line)
            else:
                # document内の処理
                # メタデータコマンドをコメントアウト
                metadata_commands = [
                    '\\title',
                    '\\author',
                    '\\address',
                    '\\email',
                    '\\subjclass',
                    '\\keywords',
                    '\\maketitle',
                ]
                
                is_metadata_command = any(line.strip().startswith(cmd) for cmd in metadata_commands)
                if is_metadata_command:
                    # \\を\に修正してコメントアウト
                    fixed_line = line.replace('\\\\', '\\')
                    processed_lines.append('// ' + fixed_line)
                    # {}ブロックの開始を検出
                    brace_count += line.count('{') - line.count('}')
                    if brace_count > 0:
                        in_multiline_command = True
                    else:
                        in_multiline_command = False
                # abstract環境の処理
                elif '\\begin{abstract}' in line:
                    in_abstract = True
                    fixed_line = line.replace('\\\\', '\\')
                    processed_lines.append('// ' + fixed_line)
                elif '\\end{abstract}' in line:
                    in_abstract = False
                    fixed_line = line.replace('\\\\', '\\')
                    processed_lines.append('// ' + fixed_line)
                elif in_abstract:
                    fixed_line = line.replace('\\\\', '\\')
                    processed_lines.append('// ' + fixed_line)
                elif in_multiline_command:
                    # 複数行コマンドの内容をコメントアウト
                    processed_lines.append('// ' + line)
                    # {}ブロックの終了を検出
                    brace_count += line.count('{') - line.count('}')
                    if brace_count <= 0:
                        in_multiline_command = False
                        brace_count = 0
                else:
                    # 行コメントをTypstコメントに変換
                    if line.strip().startswith('%'):
                        # %を// %に変換
                        typst_comment = line.replace('%', '// %', 1)
                        processed_lines.append(typst_comment)
                        continue
                    # 行内コメントを除去
                    if '%' in line:
                        line = line[:line.index('%')]
                    processed_lines.append(line)
        
        # 記号変換を前処理として実施
        processed_content = '\n'.join(processed_lines)
        processed_content = self._convert_math_symbols(processed_content)
        
        return processed_content
    
    def _convert_math_symbols(self, content: str) -> str:
        """数式記号をUnicodeに変換（前処理として実施）"""
        # 基本的な数式記号の変換
        for tex_symbol, unicode_char in self.math_symbols.items():
            if tex_symbol == 'mathbb':
                # \mathbb{R} → ℝ, \mathbb{N} → ℕ, \mathbb{Z} → ℤ, \mathbb{Q} → ℚ, \mathbb{C} → ℂ
                content = re.sub(r'\\mathbb\s*\{?R\}?', 'ℝ', content)
                content = re.sub(r'\\mathbb\s*\{?N\}?', 'ℕ', content)
                content = re.sub(r'\\mathbb\s*\{?Z\}?', 'ℤ', content)
                content = re.sub(r'\\mathbb\s*\{?Q\}?', 'ℚ', content)
                content = re.sub(r'\\mathbb\s*\{?C\}?', 'ℂ', content)
            else:
                # \symbol → unicode
                pattern = r'\\' + re.escape(tex_symbol) + r'(?![a-zA-Z])'
                content = re.sub(pattern, unicode_char, content)
        
        # 数式演算子の変換
        for tex_operator, unicode_char in self.math_operators.items():
            pattern = r'\\' + re.escape(tex_operator) + r'(?![a-zA-Z])'
            content = re.sub(pattern, unicode_char, content)
        
        # 特別な処理
        # \not\equiv → ≢
        content = re.sub(r'\\not\\equiv', '≢', content)
        
        # \left と \right を削除
        content = re.sub(r'\\left', '', content)
        content = re.sub(r'\\right', '', content)
        
        # \prime の処理（上付き文字の前に処理）
        content = re.sub(r'\\prime', "'", content)
        
        # \frac の処理
        content = re.sub(r'\\frac\{([^}]+)\}\{([^}]+)\}', r'(\1)/(\2)', content)
        
        # &= = の重複を修正
        content = re.sub(r'&=\s*=', '&=', content)
        
        return content
    
    def _extract_elements(self, content: str) -> List[str]:
        """主要な要素を抽出"""
        elements = []
        
        # 定理環境を抽出
        theorem_pattern = r'\\begin\{(Theorem|Lemma|Proposition|Corollary|Definition|Remark|Example|Proof|theorem|lemma|proposition|corollary|definition|remark|example|proof)\}(.*?)\\end\{\1\}'
        theorem_matches = list(re.finditer(theorem_pattern, content, re.DOTALL))
        
        # セクションを抽出
        section_pattern = r'\\(section|subsection|subsubsection)\{([^}]+)\}'
        section_matches = list(re.finditer(section_pattern, content))
        
        # 数式環境を抽出
        math_patterns = [
            r'\\begin\{align\}(.*?)\\end\{align\}',
            r'\\begin\{align\*\}(.*?)\\end\{align\*\}',
            r'\\\[(.*?)\\\]',
            r'\$([^$]+)\$',
        ]
        
        math_matches = []
        for pattern in math_patterns:
            math_matches.extend(list(re.finditer(pattern, content, re.DOTALL)))
        
        # 参照を抽出
        ref_pattern = r'\\(ref|eqref|cite)\{([^}]+)\}'
        ref_matches = list(re.finditer(ref_pattern, content))
        
        # すべてのマッチを位置順にソート
        all_matches = []
        for match in theorem_matches:
            all_matches.append(('theorem', match.start(), match.end(), match))
        for match in section_matches:
            all_matches.append(('section', match.start(), match.end(), match))
        for match in math_matches:
            all_matches.append(('math', match.start(), match.end(), match))
        for match in ref_matches:
            all_matches.append(('ref', match.start(), match.end(), match))
        
        all_matches.sort(key=lambda x: x[1])
        
        # 要素を抽出
        last_end = 0
        for element_type, start, end, match in all_matches:
            # 前の要素との間のテキスト
            if start > last_end:
                text_between = content[last_end:start].strip()
                if text_between:
                    elements.append(('text', text_between))
            
            # 現在の要素
            if element_type == 'theorem':
                elements.append(('theorem', match.group(0)))
            elif element_type == 'section':
                elements.append(('section', match.group(0)))
            elif element_type == 'math':
                elements.append(('math', match.group(0)))
            elif element_type == 'ref':
                elements.append(('ref', match.group(0)))
            
            last_end = end
        
        # 最後の要素以降のテキスト
        if last_end < len(content):
            text_after = content[last_end:].strip()
            if text_after:
                elements.append(('text', text_after))
        
        return elements
    
    def _parse_element(self, element: Tuple[str, str]) -> Optional[ASTNode]:
        """要素をASTノードに変換"""
        element_type, content = element
        
        if element_type == 'section':
            return self._parse_section(content)
        elif element_type == 'theorem':
            return self._parse_theorem(content)
        elif element_type == 'math':
            return self._parse_math(content)
        elif element_type == 'ref':
            return self._parse_reference(content)
        elif element_type == 'text':
            return self._parse_text(content)
        
        return None
    
    def _parse_section(self, content: str) -> SectionNode:
        """セクションを解析"""
        match = re.match(r'\\(section|subsection|subsubsection)\{([^}]+)\}', content)
        if match:
            level_cmd, title = match.groups()
            level = self._get_section_level(level_cmd)
            return SectionNode(
                node_type=NodeType.SECTION,
                level=level,
                title=title,
                content=title
            )
        return SectionNode(node_type=NodeType.SECTION, level=1, title="", content="")
    
    def _parse_theorem(self, content: str) -> TheoremNode:
        """定理環境を解析"""
        # \begin{Theorem}[title]\label{label}...\end{Theorem}
        theorem_match = re.match(r'\\begin\{([^}]+)\}(?:\[([^\]]*)\])?(?:\\label\{([^}]+)\})?(.*?)\\end\{\1\}', content, re.DOTALL)
        if theorem_match:
            theorem_type, title, label, body = theorem_match.groups()
            
            # 定理タイプに応じてNodeTypeを設定
            node_type = self._get_theorem_node_type(theorem_type)
            
            # Lemma内の数式環境を処理
            processed_body = self._process_math_in_content(body.strip())
            
            return TheoremNode(
                node_type=node_type,
                theorem_type=theorem_type,
                title=title or "",
                label=label or "",
                content=processed_body
            )
        return TheoremNode(node_type=NodeType.THEOREM, theorem_type="", title="", label="", content="")
    
    def _get_theorem_node_type(self, theorem_type: str) -> NodeType:
        """定理タイプに応じてNodeTypeを返す"""
        theorem_type_lower = theorem_type.lower()
        if theorem_type_lower == 'theorem':
            return NodeType.THEOREM
        elif theorem_type_lower == 'lemma':
            return NodeType.LEMMA
        elif theorem_type_lower == 'proposition':
            return NodeType.PROPOSITION
        elif theorem_type_lower == 'corollary':
            return NodeType.COROLLARY
        elif theorem_type_lower == 'definition':
            return NodeType.DEFINITION
        elif theorem_type_lower == 'remark':
            return NodeType.REMARK
        elif theorem_type_lower == 'example':
            return NodeType.EXAMPLE
        elif theorem_type_lower == 'proof':
            return NodeType.PROOF
        else:
            return NodeType.THEOREM  # デフォルト
    
    def _process_math_in_content(self, content: str) -> str:
        """コンテンツ内の数式環境を処理"""
        # \begin{align*}...\end{align*} を処理（先に処理する）
        content = re.sub(r'\\begin\{align\*\}(.*?)\\end\{align\*\}', 
                        lambda m: f'$ {self._parse_math_content(m.group(1))} $ //[formula type:align*]', 
                        content, flags=re.DOTALL)
        
        # \begin{align}...\end{align} を処理
        content = re.sub(r'\\begin\{align\}(.*?)\\end\{align\}', 
                        lambda m: f'$ {self._parse_math_content(m.group(1))} $ //[formula type:align]', 
                        content, flags=re.DOTALL)
        
        # \[...\] を処理
        content = re.sub(r'\\\[(.*?)\\\]', 
                        lambda m: f'$ {self._parse_math_content(m.group(1))} $ //[formula type:display]', 
                        content, flags=re.DOTALL)
        
        return content
    
    def _parse_math_content(self, content: str) -> str:
        """数式内容を基本的に処理"""
        # 基本的な数式処理（簡易版）
        content = content.replace('\\label{eq2}', '').strip()
        return content
    
    def _parse_math(self, content: str) -> MathNode:
        """数式を解析"""
        if content.startswith('\\begin{align}'):
            math_content = content[12:-13]  # \begin{align}と\end{align}を除去
            return MathNode(
                node_type=NodeType.MATH_ALIGN,
                content=math_content,
                math_type="align"
            )
        elif content.startswith('\\begin{align*}'):
            math_content = content[13:-14]  # \begin{align*}と\end{align*}を除去
            return MathNode(
                node_type=NodeType.MATH_ALIGN_STAR,
                content=math_content,
                math_type="align*"
            )
        elif content.startswith('\\['):
            math_content = content[2:-2]  # \[と\]を除去
            return MathNode(
                node_type=NodeType.MATH_DISPLAY,
                content=math_content,
                math_type="display"
            )
        elif content.startswith('$'):
            math_content = content[1:-1]  # $を除去
            return MathNode(
                node_type=NodeType.MATH_INLINE,
                content=math_content,
                math_type="inline"
            )
        return MathNode(node_type=NodeType.MATH_INLINE, content=content, math_type="inline")
    
    def _parse_reference(self, content: str) -> ReferenceNode:
        """参照を解析"""
        match = re.match(r'\\(ref|eqref|cite)\{([^}]+)\}', content)
        if match:
            ref_type, target = match.groups()
            # ref_typeに応じてnode_typeを設定
            if ref_type == "ref":
                node_type = NodeType.REF
            elif ref_type == "eqref":
                node_type = NodeType.EQREF
            elif ref_type == "cite":
                node_type = NodeType.CITE
            else:
                node_type = NodeType.REF
            
            return ReferenceNode(
                node_type=node_type,
                ref_type=ref_type,
                target=target
            )
        return ReferenceNode(node_type=NodeType.REF, ref_type="ref", target="")
    
    def _parse_text(self, content: str) -> TextNode:
        """テキストを解析"""
        return TextNode(
            node_type=NodeType.TEXT,
            content=content
        )
    
    def _get_section_level(self, section_command: str) -> int:
        """セクションレベルを取得"""
        if section_command == "section":
            return 1
        elif section_command == "subsection":
            return 2
        elif section_command == "subsubsection":
            return 3
        else:
            return 1


# グローバルインスタンス
improved_tex_parser = ImprovedTeXParser()
