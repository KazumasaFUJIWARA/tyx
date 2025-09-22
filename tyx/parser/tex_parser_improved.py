#!/usr/bin/env python3
"""
改良されたTeXパーサー
"""

import re
from typing import List, Optional, Tuple
from .ast import (
    ASTNode, DocumentNode, SectionNode, MathNode, TheoremNode, 
    ReferenceNode, TextNode, NormNode, AbsNode, NodeType
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
            'infty': '∞', 'partial': '∂', 'nabla': '∇', 
            'Alpha': 'Α', 'Beta': 'Β', 'Gamma': 'Γ', 'Delta': 'Δ', 'Epsilon': 'Ε', 'Zeta': 'Ζ',
            'Eta': 'Η', 'Theta': 'Θ', 'Iota': 'Ι', 'Kappa': 'Κ', 'Lambda': 'Λ', 'Mu': 'Μ',
            'Nu': 'Ν', 'Xi': 'Ξ', 'Omicron': 'Ο', 'Pi': 'Π', 'Rho': 'Ρ', 'Sigma': 'Σ',
            'Tau': 'Τ', 'Upsilon': 'Υ', 'Phi': 'Φ', 'Chi': 'Χ', 'Psi': 'Ψ', 'Omega': 'Ω',
            'varepsilon': 'ε', 'varphi': 'φ', 'in': '∈', 'sim': '∼',
            'lesssim': '≲', 'gtrsim': '≳', 'cap': '∩',
            'not': '¬', 'equiv': '≡', 'quad': 'quad',             'mathbb': 'ℝ', 'cdot': '⋅', 'ell': 'ℓ',
            'leq': '≤', 'geq': '≥', 'll': '≪', 'gg': '≫',
            'times': '×', 'langle': '⟨', 'rangle': '⟩'
        }
        
        # 数式演算子のUnicodeマッピング
        self.math_operators = {
            'sum': 'Σ', 'int': '∫', 'iint': '∬', 'iiint': '∭', 'oint': '∮', 'prod': '∏', 'lim': 'lim',
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
    
    def _parse_norm_expression(self, content: str) -> List[ASTNode]:
        """ノルム記号を解析してASTノードに変換（拡張版）"""
        nodes = []
        
        # ノルム記号の変種を正規化
        content = self._normalize_norm_variants(content)
        
        # ノルム記号の開始位置を検索
        start_pos = content.find('\\|')
        if start_pos == -1:
            # ノルム記号がない場合は通常のテキストノード
            if content.strip():
                nodes.append(TextNode(node_type=NodeType.TEXT, content=content))
            return nodes
        
        # ノルム記号の前の部分
        if start_pos > 0:
            prefix = content[:start_pos]
            if prefix.strip():
                nodes.append(TextNode(node_type=NodeType.TEXT, content=prefix))
        
        # ノルム記号の終了位置を検索（括弧のバランスを考慮）
        norm_end = self._find_norm_end(content, start_pos)
        if norm_end == -1:
            # ノルム記号が不完全な場合は通常のテキストノード
            nodes.append(TextNode(node_type=NodeType.TEXT, content=content))
            return nodes
        
        # ノルム記号の内容を抽出
        norm_content = content[start_pos:norm_end]
        
        # スペース系コマンドを無視するパターン
        _WS = r'(?:\s|\\[,;:!])*'
        
        # \| ... \|_{...} のパターンを解析（下付きあり、省略波括弧対応）
        norm_match_with_sub = re.match(
            rf'\\\|{_WS}(.*?){_WS}\\\|{_WS}_(?:\{{\s*(.*?)\s*\}}|([A-Za-z0-9]+)){_WS}$',
            norm_content, re.DOTALL)
        if norm_match_with_sub:
            inner_content = norm_match_with_sub.group(1).strip()
            subscript = (norm_match_with_sub.group(2) or norm_match_with_sub.group(3) or "").strip()
            
            # 内側の内容で絶対値記号を再帰的に処理
            inner_abs_nodes = self._parse_abs_expression(inner_content)
            
            # ノルムノードを作成
            norm_node = NormNode(
                node_type=NodeType.NORM,
                content=inner_content,
                subscript=subscript
            )
            # 絶対値ノードを子ノードとして追加
            for abs_node in inner_abs_nodes:
                norm_node.add_child(abs_node)
            nodes.append(norm_node)
        else:
            # \| ... \| のパターンを解析（下付きなし）
            norm_match_without_sub = re.match(
                rf'\\\|{_WS}(.*?){_WS}\\\|{_WS}$',
                norm_content, re.DOTALL)
            if norm_match_without_sub:
                inner_content = norm_match_without_sub.group(1).strip()
                
                # 内側の内容で絶対値記号を再帰的に処理
                inner_abs_nodes = self._parse_abs_expression(inner_content)
                
                # ノルムノードを作成（下付きなし）
                norm_node = NormNode(
                    node_type=NodeType.NORM,
                    content=inner_content,
                    subscript=""
                )
                # 絶対値ノードを子ノードとして追加
                for abs_node in inner_abs_nodes:
                    norm_node.add_child(abs_node)
                nodes.append(norm_node)
            else:
                # パターンにマッチしない場合は何もしない（他の解析で処理される）
                pass
        
        # 残りの部分を処理
        remaining = content[norm_end:]
        if remaining.strip():
            remaining_nodes = self._parse_norm_expression(remaining)
            nodes.extend(remaining_nodes)
        
        return nodes
    
    def _normalize_norm_variants(self, s: str) -> str:
        """ノルム記号の変種を正規化"""
        # \left\| ... \right\| → \| ... \|
        s = re.sub(r'\\left\s*\\\|', r'\\|', s)
        s = re.sub(r'\\right\s*\\\|', r'\\|', s)
        # \lVert \rVert / \Vert / \vert → \|（両側揃ったもののみ想定）
        s = re.sub(r'\\lVert', r'\\|', s)
        s = re.sub(r'\\rVert', r'\\|', s)
        s = re.sub(r'\\Vert', r'\\|', s)
        # 絶対値記号はそのまま（| ... |）
        # ノルム記号のみ \bigg| \Big| \big| → \|
        # 注意: 絶対値記号（|）とノルム記号（\|）を区別
        return s
    
    def _parse_abs_expression(self, content: str) -> List[ASTNode]:
        """絶対値記号を解析してASTノードを作成"""
        nodes = []
        
        # \bigg| ... \bigg| パターンを検索（最優先）
        pattern = r'\\bigg\s*\|(.*?)\\bigg\s*\|'
        match = re.search(pattern, content, re.DOTALL)
        if match:
            inner_content = match.group(1).strip()
            abs_node = AbsNode()
            abs_node.content = inner_content
            nodes.append(abs_node)
            return nodes
        
        # \Big| ... \Big| パターンを検索
        pattern = r'\\Big\s*\|(.*?)\\Big\s*\|'
        match = re.search(pattern, content, re.DOTALL)
        if match:
            inner_content = match.group(1).strip()
            abs_node = AbsNode()
            abs_node.content = inner_content
            nodes.append(abs_node)
            return nodes
        
        # \big| ... \big| パターンを検索
        pattern = r'\\big\s*\|(.*?)\\big\s*\|'
        match = re.search(pattern, content, re.DOTALL)
        if match:
            inner_content = match.group(1).strip()
            abs_node = AbsNode()
            abs_node.content = inner_content
            nodes.append(abs_node)
            return nodes
        
        # 通常の | ... | パターンを検索（最後）
        pattern = r'(?<!\\)\|(.*?)(?<!\\)\|'
        match = re.search(pattern, content, re.DOTALL)
        if match:
            inner_content = match.group(1).strip()
            abs_node = AbsNode()
            abs_node.content = inner_content
            nodes.append(abs_node)
            return nodes
        
        return nodes
    
    def _find_norm_end(self, content: str, start_pos: int) -> int:
        """ノルム記号の終了位置を検索（堅牢版）"""
        pos = start_pos + 2  # \| の後
        brace_count = 0
        paren_count = 0
        in_subscript = False
        
        while pos < len(content):
            if content[pos:pos+2] == '\\|' and brace_count == 0 and paren_count == 0:
                # ノルム記号の終了を発見
                pos += 2
                # 下付き文字の開始を検索
                while pos < len(content) and content[pos] in ' \t':
                    pos += 1
                if pos < len(content) and content[pos] == '_':
                    pos += 1
                    while pos < len(content) and content[pos] in ' \t':
                        pos += 1
                    if pos < len(content) and content[pos] == '{':
                        # 波括弧付き下付き
                        pos += 1
                        brace_count = 1
                        in_subscript = True
                        while pos < len(content) and brace_count > 0:
                            if content[pos] == '{':
                                brace_count += 1
                            elif content[pos] == '}':
                                brace_count -= 1
                            pos += 1
                        return pos
                    elif pos < len(content) and content[pos].isalnum():
                        # 省略波括弧下付き（単一文字）
                        pos += 1
                        return pos
                return pos
            elif content[pos] == '{' and not in_subscript:
                brace_count += 1
            elif content[pos] == '}' and not in_subscript:
                brace_count -= 1
            elif content[pos] == '(' and not in_subscript:
                paren_count += 1
            elif content[pos] == ')' and not in_subscript:
                paren_count -= 1
            pos += 1
        
        return -1
    
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
        
        # 数式環境を先に抽出してから記号変換を適用
        processed_content = self._convert_math_symbols(processed_content)
        
        return processed_content
    
    def _convert_math_symbols(self, content: str) -> str:
        """数式記号をUnicodeに変換（前処理として実施）"""
        # 基本的な数式記号の変換（数式モードの判定を行わず直接置換）
        for tex_symbol, unicode_char in self.math_symbols.items():
            if tex_symbol == 'mathbb':
                # \mathbb{R} → ℝ, \mathbb{N} → ℕ, \mathbb{Z} → ℤ, \mathbb{Q} → ℚ, \mathbb{C} → ℂ
                content = re.sub(r'\\mathbb\s*\{?R\}?', 'ℝ', content)
                content = re.sub(r'\\mathbb\s*\{?N\}?', 'ℕ', content)
                content = re.sub(r'\\mathbb\s*\{?Z\}?', 'ℤ', content)
                content = re.sub(r'\\mathbb\s*\{?Q\}?', 'ℚ', content)
                content = re.sub(r'\\mathbb\s*\{?C\}?', 'ℂ', content)
            else:
                # \symbol → unicode（数式モードの判定を行わず直接置換）
                pattern = r'\\' + re.escape(tex_symbol) + r'(?![a-zA-Z])'
                content = re.sub(pattern, unicode_char, content)
        
        # 数式演算子の変換（数式モードの判定を行わず直接置換）
        for tex_operator, unicode_char in self.math_operators.items():
            if tex_operator == 'sup':
                # sup _{...} のパターンを特別に処理
                # \sup _{...} → sup_{...}
                content = re.sub(r'\\sup\s*_\{([^}]+)\}', r'sup_{\1}', content)
                # \sup _... → sup_...
                content = re.sub(r'\\sup\s*_([a-zA-Z0-9])', r'sup_\1', content)
                # その他の\sup → sup
                content = re.sub(r'\\sup(?![a-zA-Z])', 'sup', content)
            else:
                # その他の演算子を直接置換
                pattern = r'\\' + re.escape(tex_operator) + r'(?![a-zA-Z])'
                content = re.sub(pattern, unicode_char, content)
        
        # 特別な処理
        # \not\equiv → ≢
        content = re.sub(r'\\not\\equiv', '≢', content)
        
        # \left と \right をメタコメント付きで変換
        content = re.sub(r'\\left\(', '( //[command type:left]\n\t', content)
        content = re.sub(r'\\right\)', ') //[command type:right]\n', content)
        content = re.sub(r'\\left\[', '[ //[command type:left]\n\t', content)
        content = re.sub(r'\\right\]', '] //[command type:right]\n', content)
        content = re.sub(r'\\left\{', '{ //[command type:left]\n\t', content)
        content = re.sub(r'\\right\}', '} //[command type:right]\n', content)
        
        # \prime の処理（上付き文字の前に処理）
        content = re.sub(r'\\prime', "'", content)
        
        # \bigg をメタコメント付きで変換
        content = re.sub(r'\\bigg\(', '( //[command type:bigg]\n\t', content)
        content = re.sub(r'\\bigg\)', ') //[command type:bigg]\n', content)
        content = re.sub(r'\\bigg\[', '[ //[command type:bigg]\n\t', content)
        content = re.sub(r'\\bigg\]', '] //[command type:bigg]\n', content)
        content = re.sub(r'\\bigg\{', '{ //[command type:bigg]\n\t', content)
        content = re.sub(r'\\bigg\}', '} //[command type:bigg]\n', content)
        
        
        # \sqrt の処理（\fracより先に処理）
        content = re.sub(r'\\sqrt\{([^}]+)\}', r'sqrt(\1)', content)
        
        # \frac の処理
        content = re.sub(r'\\frac\{([^}]+)\}\{([^}]+)\}', r'(\1)/(\2)', content)
        
        # 数式アクセントの処理（前処理で）
        content = re.sub(r'\\ddot\{([^}]+)\}', r'dot.double(\1)', content)
        content = re.sub(r'\\dot\{([^}]+)\}', r'dot(\1)', content)
        content = re.sub(r'\\hat\{([^}]+)\}', r'hat(\1)', content)
        content = re.sub(r'\\bar\{([^}]+)\}', r'bar(\1)', content)
        content = re.sub(r'\\tilde\{([^}]+)\}', r'tilde(\1)', content)
        content = re.sub(r'\\vec\{([^}]+)\}', r'arrow(\1)', content)
        
        # \mathfrak の変換（A-Z、波括弧付き対応）
        content = re.sub(r'\\mathfrak\s*\{A\}', '𝔄', content)
        content = re.sub(r'\\mathfrak\s*\{B\}', '𝔅', content)
        content = re.sub(r'\\mathfrak\s*\{C\}', 'ℭ', content)
        content = re.sub(r'\\mathfrak\s*\{D\}', '𝔇', content)
        content = re.sub(r'\\mathfrak\s*\{E\}', '𝔈', content)
        content = re.sub(r'\\mathfrak\s*\{F\}', '𝔉', content)
        content = re.sub(r'\\mathfrak\s*\{G\}', '𝔊', content)
        content = re.sub(r'\\mathfrak\s*\{H\}', 'ℌ', content)
        content = re.sub(r'\\mathfrak\s*\{I\}', 'ℑ', content)
        content = re.sub(r'\\mathfrak\s*\{J\}', '𝔍', content)
        content = re.sub(r'\\mathfrak\s*\{K\}', '𝔎', content)
        content = re.sub(r'\\mathfrak\s*\{L\}', '𝔏', content)
        content = re.sub(r'\\mathfrak\s*\{M\}', '𝔐', content)
        content = re.sub(r'\\mathfrak\s*\{N\}', '𝔑', content)
        content = re.sub(r'\\mathfrak\s*\{O\}', '𝔒', content)
        content = re.sub(r'\\mathfrak\s*\{P\}', '𝔓', content)
        content = re.sub(r'\\mathfrak\s*\{Q\}', '𝔔', content)
        content = re.sub(r'\\mathfrak\s*\{R\}', 'ℜ', content)
        content = re.sub(r'\\mathfrak\s*\{S\}', '𝔖', content)
        content = re.sub(r'\\mathfrak\s*\{T\}', '𝔗', content)
        content = re.sub(r'\\mathfrak\s*\{U\}', '𝔘', content)
        content = re.sub(r'\\mathfrak\s*\{V\}', '𝔙', content)
        content = re.sub(r'\\mathfrak\s*\{W\}', '𝔚', content)
        content = re.sub(r'\\mathfrak\s*\{X\}', '𝔛', content)
        content = re.sub(r'\\mathfrak\s*\{Y\}', '𝔜', content)
        content = re.sub(r'\\mathfrak\s*\{Z\}', 'ℨ', content)
        # 空白付きも対応
        content = re.sub(r'\\mathfrak\s+A', '𝔄', content)
        content = re.sub(r'\\mathfrak\s+B', '𝔅', content)
        content = re.sub(r'\\mathfrak\s+C', 'ℭ', content)
        content = re.sub(r'\\mathfrak\s+D', '𝔇', content)
        content = re.sub(r'\\mathfrak\s+E', '𝔈', content)
        content = re.sub(r'\\mathfrak\s+F', '𝔉', content)
        content = re.sub(r'\\mathfrak\s+G', '𝔊', content)
        content = re.sub(r'\\mathfrak\s+H', 'ℌ', content)
        content = re.sub(r'\\mathfrak\s+I', 'ℑ', content)
        content = re.sub(r'\\mathfrak\s+J', '𝔍', content)
        content = re.sub(r'\\mathfrak\s+K', '𝔎', content)
        content = re.sub(r'\\mathfrak\s+L', '𝔏', content)
        content = re.sub(r'\\mathfrak\s+M', '𝔐', content)
        content = re.sub(r'\\mathfrak\s+N', '𝔑', content)
        content = re.sub(r'\\mathfrak\s+O', '𝔒', content)
        content = re.sub(r'\\mathfrak\s+P', '𝔓', content)
        content = re.sub(r'\\mathfrak\s+Q', '𝔔', content)
        content = re.sub(r'\\mathfrak\s+R', 'ℜ', content)
        content = re.sub(r'\\mathfrak\s+S', '𝔖', content)
        content = re.sub(r'\\mathfrak\s+T', '𝔗', content)
        content = re.sub(r'\\mathfrak\s+U', '𝔘', content)
        content = re.sub(r'\\mathfrak\s+V', '𝔙', content)
        content = re.sub(r'\\mathfrak\s+W', '𝔚', content)
        content = re.sub(r'\\mathfrak\s+X', '𝔛', content)
        content = re.sub(r'\\mathfrak\s+Y', '𝔜', content)
        content = re.sub(r'\\mathfrak\s+Z', 'ℨ', content)
        
        # \mathcal の変換（A-Z、波括弧付き対応）
        content = re.sub(r'\\mathcal\s*\{A\}', '𝒜', content)
        content = re.sub(r'\\mathcal\s*\{B\}', 'ℬ', content)
        content = re.sub(r'\\mathcal\s*\{C\}', '𝒞', content)
        content = re.sub(r'\\mathcal\s*\{D\}', '𝒟', content)
        content = re.sub(r'\\mathcal\s*\{E\}', 'ℰ', content)
        content = re.sub(r'\\mathcal\s*\{F\}', 'ℱ', content)
        content = re.sub(r'\\mathcal\s*\{G\}', '𝒢', content)
        content = re.sub(r'\\mathcal\s*\{H\}', 'ℋ', content)
        content = re.sub(r'\\mathcal\s*\{I\}', 'ℐ', content)
        content = re.sub(r'\\mathcal\s*\{J\}', '𝒥', content)
        content = re.sub(r'\\mathcal\s*\{K\}', '𝒦', content)
        content = re.sub(r'\\mathcal\s*\{L\}', 'ℒ', content)
        content = re.sub(r'\\mathcal\s*\{M\}', 'ℳ', content)
        content = re.sub(r'\\mathcal\s*\{N\}', '𝒩', content)
        content = re.sub(r'\\mathcal\s*\{O\}', '𝒪', content)
        content = re.sub(r'\\mathcal\s*\{P\}', '𝒫', content)
        content = re.sub(r'\\mathcal\s*\{Q\}', '𝒬', content)
        content = re.sub(r'\\mathcal\s*\{R\}', 'ℛ', content)
        content = re.sub(r'\\mathcal\s*\{S\}', '𝒮', content)
        content = re.sub(r'\\mathcal\s*\{T\}', '𝒯', content)
        content = re.sub(r'\\mathcal\s*\{U\}', '𝒰', content)
        content = re.sub(r'\\mathcal\s*\{V\}', '𝒱', content)
        content = re.sub(r'\\mathcal\s*\{W\}', '𝒲', content)
        content = re.sub(r'\\mathcal\s*\{X\}', '𝒳', content)
        content = re.sub(r'\\mathcal\s*\{Y\}', '𝒴', content)
        content = re.sub(r'\\mathcal\s*\{Z\}', '𝒵', content)
        # 空白付きも対応
        content = re.sub(r'\\mathcal\s+A', '𝒜', content)
        content = re.sub(r'\\mathcal\s+B', 'ℬ', content)
        content = re.sub(r'\\mathcal\s+C', '𝒞', content)
        content = re.sub(r'\\mathcal\s+D', '𝒟', content)
        content = re.sub(r'\\mathcal\s+E', 'ℰ', content)
        content = re.sub(r'\\mathcal\s+F', 'ℱ', content)
        content = re.sub(r'\\mathcal\s+G', '𝒢', content)
        content = re.sub(r'\\mathcal\s+H', 'ℋ', content)
        content = re.sub(r'\\mathcal\s+I', 'ℐ', content)
        content = re.sub(r'\\mathcal\s+J', '𝒥', content)
        content = re.sub(r'\\mathcal\s+K', '𝒦', content)
        content = re.sub(r'\\mathcal\s+L', 'ℒ', content)
        content = re.sub(r'\\mathcal\s+M', 'ℳ', content)
        content = re.sub(r'\\mathcal\s+N', '𝒩', content)
        content = re.sub(r'\\mathcal\s+O', '𝒪', content)
        content = re.sub(r'\\mathcal\s+P', '𝒫', content)
        content = re.sub(r'\\mathcal\s+Q', '𝒬', content)
        content = re.sub(r'\\mathcal\s+R', 'ℛ', content)
        content = re.sub(r'\\mathcal\s+S', '𝒮', content)
        content = re.sub(r'\\mathcal\s+T', '𝒯', content)
        content = re.sub(r'\\mathcal\s+U', '𝒰', content)
        content = re.sub(r'\\mathcal\s+V', '𝒱', content)
        content = re.sub(r'\\mathcal\s+W', '𝒲', content)
        content = re.sub(r'\\mathcal\s+X', '𝒳', content)
        content = re.sub(r'\\mathcal\s+Y', '𝒴', content)
        content = re.sub(r'\\mathcal\s+Z', '𝒵', content)
        
        # \mathbb の変換（A-Z、波括弧付き対応）
        content = re.sub(r'\\mathbb\s*\{A\}', '𝔸', content)
        content = re.sub(r'\\mathbb\s*\{B\}', '𝔹', content)
        content = re.sub(r'\\mathbb\s*\{C\}', 'ℂ', content)
        content = re.sub(r'\\mathbb\s*\{D\}', '𝔻', content)
        content = re.sub(r'\\mathbb\s*\{E\}', '𝔼', content)
        content = re.sub(r'\\mathbb\s*\{F\}', '𝔽', content)
        content = re.sub(r'\\mathbb\s*\{G\}', '𝔾', content)
        content = re.sub(r'\\mathbb\s*\{H\}', 'ℍ', content)
        content = re.sub(r'\\mathbb\s*\{I\}', '𝕀', content)
        content = re.sub(r'\\mathbb\s*\{J\}', '𝕁', content)
        content = re.sub(r'\\mathbb\s*\{K\}', '𝕂', content)
        content = re.sub(r'\\mathbb\s*\{L\}', '𝕃', content)
        content = re.sub(r'\\mathbb\s*\{M\}', '𝕄', content)
        content = re.sub(r'\\mathbb\s*\{N\}', 'ℕ', content)
        content = re.sub(r'\\mathbb\s*\{O\}', '𝕆', content)
        content = re.sub(r'\\mathbb\s*\{P\}', 'ℙ', content)
        content = re.sub(r'\\mathbb\s*\{Q\}', 'ℚ', content)
        content = re.sub(r'\\mathbb\s*\{R\}', 'ℝ', content)
        content = re.sub(r'\\mathbb\s*\{S\}', '𝕊', content)
        content = re.sub(r'\\mathbb\s*\{T\}', '𝕋', content)
        content = re.sub(r'\\mathbb\s*\{U\}', '𝕌', content)
        content = re.sub(r'\\mathbb\s*\{V\}', '𝕍', content)
        content = re.sub(r'\\mathbb\s*\{W\}', '𝕎', content)
        content = re.sub(r'\\mathbb\s*\{X\}', '𝕏', content)
        content = re.sub(r'\\mathbb\s*\{Y\}', '𝕐', content)
        content = re.sub(r'\\mathbb\s*\{Z\}', 'ℤ', content)
        # 空白付きも対応
        content = re.sub(r'\\mathbb\s+A', '𝔸', content)
        content = re.sub(r'\\mathbb\s+B', '𝔹', content)
        content = re.sub(r'\\mathbb\s+C', 'ℂ', content)
        content = re.sub(r'\\mathbb\s+D', '𝔻', content)
        content = re.sub(r'\\mathbb\s+E', '𝔼', content)
        content = re.sub(r'\\mathbb\s+F', '𝔽', content)
        content = re.sub(r'\\mathbb\s+G', '𝔾', content)
        content = re.sub(r'\\mathbb\s+H', 'ℍ', content)
        content = re.sub(r'\\mathbb\s+I', '𝕀', content)
        content = re.sub(r'\\mathbb\s+J', '𝕁', content)
        content = re.sub(r'\\mathbb\s+K', '𝕂', content)
        content = re.sub(r'\\mathbb\s+L', '𝕃', content)
        content = re.sub(r'\\mathbb\s+M', '𝕄', content)
        content = re.sub(r'\\mathbb\s+N', 'ℕ', content)
        content = re.sub(r'\\mathbb\s+O', '𝕆', content)
        content = re.sub(r'\\mathbb\s+P', 'ℙ', content)
        content = re.sub(r'\\mathbb\s+Q', 'ℚ', content)
        content = re.sub(r'\\mathbb\s+R', 'ℝ', content)
        content = re.sub(r'\\mathbb\s+S', '𝕊', content)
        content = re.sub(r'\\mathbb\s+T', '𝕋', content)
        content = re.sub(r'\\mathbb\s+U', '𝕌', content)
        content = re.sub(r'\\mathbb\s+V', '𝕍', content)
        content = re.sub(r'\\mathbb\s+W', '𝕎', content)
        content = re.sub(r'\\mathbb\s+X', '𝕏', content)
        content = re.sub(r'\\mathbb\s+Y', '𝕐', content)
        content = re.sub(r'\\mathbb\s+Z', 'ℤ', content)
        
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
        
        # 要素を抽出（重複を避ける）
        last_end = 0
        processed_positions = set()
        
        for element_type, start, end, match in all_matches:
            # 重複チェック：既に処理済みの位置範囲と重複していないか確認
            if any(pos >= start and pos < end for pos in processed_positions):
                continue
                
            # 前の要素との間のテキスト
            if start > last_end:
                text_between = content[last_end:start].strip()
                if text_between:
                    elements.append(('text', text_between))
            
            # 現在の要素
            if element_type == 'theorem':
                theorem_content = match.group(0)
                elements.append(('theorem', theorem_content))
            elif element_type == 'section':
                elements.append(('section', match.group(0)))
            elif element_type == 'math':
                elements.append(('math', match.group(0)))
            elif element_type == 'ref':
                elements.append(('ref', match.group(0)))
            
            # 処理済み位置を記録
            for pos in range(start, end):
                processed_positions.add(pos)
            
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
            # ノルム記号と絶対値記号を解析して子ノードに変換
            child_nodes = self._parse_norm_expression(math_content)
            abs_nodes = self._parse_abs_expression(math_content)
            child_nodes.extend(abs_nodes)
            math_node = MathNode(
                node_type=NodeType.MATH_ALIGN,
                content=math_content,
                math_type="align"
            )
            # 子ノードを追加
            for child in child_nodes:
                math_node.add_child(child)
            return math_node
        elif content.startswith('\\begin{align*}'):
            math_content = content[13:-14]  # \begin{align*}と\end{align*}を除去
            # ノルム記号と絶対値記号を解析して子ノードに変換
            child_nodes = self._parse_norm_expression(math_content)
            abs_nodes = self._parse_abs_expression(math_content)
            child_nodes.extend(abs_nodes)
            math_node = MathNode(
                node_type=NodeType.MATH_ALIGN_STAR,
                content=math_content,
                math_type="align*"
            )
            # 子ノードを追加
            for child in child_nodes:
                math_node.add_child(child)
            return math_node
        elif content.startswith('\\['):
            math_content = content[2:-2]  # \[と\]を除去
            # ノルム記号と絶対値記号を解析して子ノードに変換
            child_nodes = self._parse_norm_expression(math_content)
            abs_nodes = self._parse_abs_expression(math_content)
            child_nodes.extend(abs_nodes)
            math_node = MathNode(
                node_type=NodeType.MATH_DISPLAY,
                content=math_content,
                math_type="display"
            )
            # 子ノードを追加
            for child in child_nodes:
                math_node.add_child(child)
            return math_node
        elif content.startswith('$'):
            math_content = content[1:-1]  # $を除去
            # ノルム記号を先に解析（ノルム内で絶対値記号も処理される）
            child_nodes = self._parse_norm_expression(math_content)
            
            # ノルム記号が見つからない場合のみ絶対値記号を解析
            if not child_nodes:
                abs_nodes = self._parse_abs_expression(math_content)
                child_nodes.extend(abs_nodes)
            
            # 子ノードがある場合は、contentを空にして子ノードのみを使用
            if child_nodes:
                math_node = MathNode(
                    node_type=NodeType.MATH_INLINE,
                    content="",  # 子ノードがある場合は空
                    math_type="inline"
                )
                # 子ノードを追加
                for child in child_nodes:
                    math_node.add_child(child)
            else:
                # 子ノードがない場合は通常の処理
                math_node = MathNode(
                    node_type=NodeType.MATH_INLINE,
                    content=math_content,
                    math_type="inline"
                )
            return math_node
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
