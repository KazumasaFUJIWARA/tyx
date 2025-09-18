"""
簡易TeXパーサー

正規表現ベースのシンプルなTeXパーサー
"""

import re
from typing import List, Optional, Dict, Any, Tuple
from dataclasses import dataclass

from .ast import (
    ASTNode, DocumentNode, SectionNode, MathNode, TheoremNode, 
    ReferenceNode, AccentNode, FunctionNode, SymbolNode, 
    VariableNode, OperatorNode, FractionNode, SubscriptNode, 
    SuperscriptNode, TextNode, UnknownNode, NodeType
)
from ..utils.labels import label_extractor
from ..utils.unicode import unicode_converter


@dataclass
class ParseResult:
    """解析結果"""
    node: ASTNode
    remaining_text: str


class SimpleTeXParser:
    """簡易TeXパーサー"""
    
    def __init__(self):
        # 正規表現パターン
        self.patterns = {
            'section': re.compile(r'\\(section|subsection|subsubsection)\{([^}]+)\}'),
            'math_inline': re.compile(r'\$([^$]+)\$'),
            'math_display': re.compile(r'\\\[([^\]]+)\\\]'),
            'math_align': re.compile(r'\\begin\{align\}(.*?)\\end\{align\}', re.DOTALL),
            'math_align_star': re.compile(r'\\begin\{align\*\}(.*?)\\end\{align\*\}', re.DOTALL),
            'theorem': re.compile(r'\\begin\{(Theorem|Lemma|Proposition|Corollary|Definition|Remark|Example|Proof|theorem|lemma|proposition|corollary|definition|remark|example|proof)\}(.*?)\\end\{\1\}', re.DOTALL),
            'reference': re.compile(r'\\(ref|eqref|cite)\{([^}]+)\}'),
            'accent': re.compile(r'\\(dot|ddot|hat|bar|tilde|vec)\{([^}]+)\}'),
            'symbol': re.compile(r'\\(alpha|beta|gamma|delta|epsilon|zeta|eta|theta|iota|kappa|lambda|mu|nu|xi|omicron|pi|rho|sigma|tau|upsilon|phi|chi|psi|omega|infty|partial|nabla|pm|mp|times|div|leq|geq|neq|approx|equiv|propto)'),
            'fraction': re.compile(r'\\frac\{([^}]+)\}\{([^}]+)\}'),
            'subscript': re.compile(r'([a-zA-Z0-9]+)_\{([^}]+)\}'),
            'superscript': re.compile(r'([a-zA-Z0-9]+)\^\{([^}]+)\}'),
            'function': re.compile(r'\\(sin|cos|tan|log|ln|exp|sinh|cosh|erf)\(([^)]+)\)'),
            'operator': re.compile(r'\\(sum|int|prod|lim|max|min)'),
            'unknown_command': re.compile(r'\\([a-zA-Z]+)\{([^}]*)\}'),
        }
    
    def parse(self, tex_content: str) -> DocumentNode:
        """TeXコンテンツを解析"""
        document = DocumentNode(node_type=NodeType.DOCUMENT)
        remaining_text = tex_content.strip()
        
        while remaining_text:
            result = self._parse_next_element(remaining_text)
            if result:
                document.add_child(result.node)
                remaining_text = result.remaining_text.strip()
            else:
                # 解析できない部分はテキストとして処理
                if remaining_text:
                    text_node = TextNode(
                        node_type=NodeType.TEXT,
                        content=remaining_text[:100]  # 最初の100文字のみ
                    )
                    document.add_child(text_node)
                break
        
        return document
    
    def _parse_next_element(self, text: str) -> Optional[ParseResult]:
        """次の要素を解析"""
        # コメントをスキップ
        if text.strip().startswith('%'):
            # コメント行をスキップ
            lines = text.split('\n')
            non_comment_lines = []
            for line in lines:
                if line.strip().startswith('%'):
                    continue
                non_comment_lines.append(line)
            if non_comment_lines:
                return ParseResult(TextNode(node_type=NodeType.TEXT, content=""), '\n'.join(non_comment_lines))
            else:
                return ParseResult(TextNode(node_type=NodeType.TEXT, content=""), "")
        
        # ドキュメントクラス、パッケージ、メタデータをスキップ
        skip_patterns = [
            r'\\documentclass\[[^\]]*\]\{[^}]*\}',
            r'\\usepackage.*?(?=\n|$)',
            r'\\mathtoolsset\{[^}]*\}',
            r'\\newtheorem\{[^}]*\}\{[^}]*\}(?:\[[^\]]*\])?',
            r'\\begin\{document\}',
            r'\\end\{document\}',
            r'\\title\{[^}]*\}',
            r'\\author(?:\[[^\]]*\])?\{[^}]*\}',
            r'\\address(?:\[[^\]]*\])?\{[^}]*\}',
            r'\\email\{[^}]*\}',
            r'\\subjclass\{[^}]*\}',
            r'\\keywords\{[^}]*\}',
            r'\\maketitle',
            r'\\begin\{abstract\}.*?\\end\{abstract\}',
        ]
        
        for pattern in skip_patterns:
            match = re.search(pattern, text, re.DOTALL)
            if match:
                # スキップされた要素は残りのテキストを処理
                return self._parse_next_element(text[match.end():])
        
        # 定理（最優先）
        theorem_match = self._find_theorem_environment(text)
        if theorem_match:
            theorem_type, content, end_pos = theorem_match
            theorem_node = self._parse_theorem(theorem_type, content)
            return ParseResult(theorem_node, text[end_pos:])
        
        # セクション
        match = self.patterns['section'].search(text)
        if match:
            level_cmd, title = match.groups()
            level = self._get_section_level(level_cmd)
            section = SectionNode(
                node_type=NodeType.SECTION,
                level=level,
                title=title,
                content=title
            )
            return ParseResult(section, text[match.end():])
        
        # 数式（インライン）
        match = self.patterns['math_inline'].search(text)
        if match:
            content = match.group(1)
            math_node = MathNode(
                node_type=NodeType.MATH_INLINE,
                content=content,
                math_type="inline"
            )
            # 数式内容を解析
            self._parse_math_content(math_node, content)
            return ParseResult(math_node, text[match.end():])
        
        # 数式（ディスプレイ）
        match = self.patterns['math_display'].search(text)
        if match:
            content = match.group(1)
            math_node = MathNode(
                node_type=NodeType.MATH_DISPLAY,
                content=content,
                math_type="display"
            )
            self._parse_math_content(math_node, content)
            return ParseResult(math_node, text[match.end():])
        
        # 数式（align）
        match = self.patterns['math_align'].search(text)
        if match:
            content = match.group(1)
            math_node = MathNode(
                node_type=NodeType.MATH_ALIGN,
                content=content,
                math_type="align"
            )
            self._parse_math_content(math_node, content)
            return ParseResult(math_node, text[match.end():])
        
        # 数式（align*）
        match = self.patterns['math_align_star'].search(text)
        if match:
            content = match.group(1)
            math_node = MathNode(
                node_type=NodeType.MATH_ALIGN_STAR,
                content=content,
                math_type="align*"
            )
            self._parse_math_content(math_node, content)
            return ParseResult(math_node, text[match.end():])
        
        
        # 参照
        match = self.patterns['reference'].search(text)
        if match:
            ref_type, target = match.groups()
            ref_node = ReferenceNode(
                node_type=NodeType.REF,
                ref_type=ref_type,
                target=target,
                content=match.group(0)
            )
            return ParseResult(ref_node, text[match.end():])
        
        # テキスト（最初の単語）
        words = text.split()
        if words:
            word = words[0]
            text_node = TextNode(
                node_type=NodeType.TEXT,
                content=word
            )
            return ParseResult(text_node, text[len(word):])
        
        return None
    
    def _parse_math_content(self, math_node: MathNode, content: str) -> None:
        """数式内容を解析"""
        # アクセント
        for match in self.patterns['accent'].finditer(content):
            accent_type, base = match.groups()
            accent_node = AccentNode(
                node_type=NodeType.ACCENT,
                accent_type=accent_type,
                base=base,
                content=match.group(0)
            )
            math_node.add_child(accent_node)
        
        # 記号
        for match in self.patterns['symbol'].finditer(content):
            symbol_name = match.group(1)
            unicode_char = unicode_converter.tex_to_unicode_char(symbol_name)
            symbol_node = SymbolNode(
                node_type=NodeType.SYMBOL,
                symbol_name=symbol_name,
                unicode_char=unicode_char,
                content=match.group(0)
            )
            math_node.add_child(symbol_node)
        
        # 分数
        for match in self.patterns['fraction'].finditer(content):
            numerator, denominator = match.groups()
            fraction_node = FractionNode(
                node_type=NodeType.FRACTION,
                numerator=numerator,
                denominator=denominator,
                content=match.group(0)
            )
            math_node.add_child(fraction_node)
        
        # 下付き文字
        for match in self.patterns['subscript'].finditer(content):
            base, subscript = match.groups()
            subscript_node = SubscriptNode(
                node_type=NodeType.SUBSCRIPT,
                base=base,
                subscript=subscript,
                content=match.group(0)
            )
            math_node.add_child(subscript_node)
        
        # 上付き文字
        for match in self.patterns['superscript'].finditer(content):
            base, superscript = match.groups()
            superscript_node = SuperscriptNode(
                node_type=NodeType.SUPERSCRIPT,
                base=base,
                superscript=superscript,
                content=match.group(0)
            )
            math_node.add_child(superscript_node)
        
        # 関数
        for match in self.patterns['function'].finditer(content):
            function_name, args = match.groups()
            function_node = FunctionNode(
                node_type=NodeType.FUNCTION,
                function_name=function_name,
                arguments=[args],
                content=match.group(0)
            )
            math_node.add_child(function_node)
        
        # 演算子
        for match in self.patterns['operator'].finditer(content):
            operator_name = match.group(1)
            operator_node = OperatorNode(
                node_type=NodeType.OPERATOR,
                operator_name=operator_name,
                content=match.group(0)
            )
            math_node.add_child(operator_node)
    
    def _parse_theorem(self, theorem_type: str, content: str) -> TheoremNode:
        """定理を解析"""
        # タイトルを抽出
        title_match = re.search(r'\[([^\]]+)\]', content)
        title = title_match.group(1) if title_match else None
        
        # ラベルを抽出
        label_match = re.search(r'\\label\{([^}]+)\}', content)
        label = label_match.group(1) if label_match else None
        
        # 本文を抽出
        body = content
        if title_match:
            body = body.replace(title_match.group(0), '')
        if label_match:
            body = body.replace(label_match.group(0), '')
        body = body.strip()
        
        theorem_node = TheoremNode(
            node_type=NodeType.THEOREM,
            theorem_type=theorem_type,
            title=title,
            label=label,
            content=body
        )
        
        return theorem_node
    
    def _find_theorem_environment(self, text: str) -> Optional[Tuple[str, str, int]]:
        """定理環境を検索（ネストした環境に対応）"""
        theorem_types = ['Theorem', 'Lemma', 'Proposition', 'Corollary', 'Definition', 'Remark', 'Example', 'Proof',
                        'theorem', 'lemma', 'proposition', 'corollary', 'definition', 'remark', 'example', 'proof']
        
        for theorem_type in theorem_types:
            begin_pattern = f'\\\\begin\\{{{theorem_type}\\}}'
            end_pattern = f'\\\\end\\{{{theorem_type}\\}}'
            
            begin_match = re.search(begin_pattern, text)
            if begin_match:
                start_pos = begin_match.start()
                # 対応する\end{theorem_type}を検索
                search_start = begin_match.end()
                brace_count = 0
                pos = search_start
                
                while pos < len(text):
                    if text[pos:pos+len(f'\\end{{{theorem_type}}}')] == f'\\end{{{theorem_type}}}':
                        if brace_count == 0:
                            # 対応する\endが見つかった
                            content = text[search_start:pos]
                            end_pos = pos + len(f'\\end{{{theorem_type}}}')
                            return theorem_type, content, end_pos
                    elif text[pos:pos+len('\\begin{')] == '\\begin{':
                        # ネストした環境の開始
                        brace_count += 1
                        pos += len('\\begin{')
                    elif text[pos:pos+len('\\end{')] == '\\end{':
                        # ネストした環境の終了
                        brace_count -= 1
                        pos += len('\\end{')
                    else:
                        pos += 1
                
                # 対応する\endが見つからない場合は、最初のマッチを返す
                content = text[search_start:]
                return theorem_type, content, len(text)
        
        return None
    
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
    
    def extract_labels(self, tex_content: str) -> List[str]:
        """ラベルを抽出"""
        return label_extractor.extract_tex_labels(tex_content)
    
    def extract_references(self, tex_content: str) -> List[str]:
        """参照を抽出"""
        return label_extractor.extract_tex_references(tex_content)
    
    def extract_citations(self, tex_content: str) -> List[str]:
        """引用を抽出"""
        return label_extractor.extract_tex_citations(tex_content)


# グローバルインスタンス
simple_tex_parser = SimpleTeXParser()
