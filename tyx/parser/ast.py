"""
共通AST定義

TeXとTypstの構文を統一的なデータ構造で表現する。
"""

from dataclasses import dataclass, field
from typing import List, Optional, Union, Dict, Any
from enum import Enum


class NodeType(Enum):
    """ノードタイプの定義"""
    # 文書構造
    DOCUMENT = "document"
    SECTION = "section"
    SUBSECTION = "subsection"
    SUBSUBSECTION = "subsubsection"
    
    # 数式
    MATH_INLINE = "math_inline"
    MATH_DISPLAY = "math_display"
    MATH_ALIGN = "math_align"
    MATH_ALIGN_STAR = "math_align_star"
    
    # 定理環境
    THEOREM = "theorem"
    LEMMA = "lemma"
    PROPOSITION = "proposition"
    COROLLARY = "corollary"
    DEFINITION = "definition"
    REMARK = "remark"
    EXAMPLE = "example"
    PROOF = "proof"
    
    # 参照
    REF = "ref"
    EQREF = "eqref"
    CITE = "cite"
    
    # 数式要素
    ACCENT = "accent"
    FUNCTION = "function"
    SYMBOL = "symbol"
    VARIABLE = "variable"
    OPERATOR = "operator"
    FRACTION = "fraction"
    SUBSCRIPT = "subscript"
    SUPERSCRIPT = "superscript"
    
    # その他
    TEXT = "text"
    UNKNOWN = "unknown"


@dataclass
class ASTNode:
    """ASTノードの基底クラス"""
    node_type: NodeType
    content: str = ""
    children: List['ASTNode'] = field(default_factory=list)
    attributes: Dict[str, Any] = field(default_factory=dict)
    meta_comment: Optional[str] = None
    
    def add_child(self, child: 'ASTNode') -> None:
        """子ノードを追加"""
        self.children.append(child)
    
    def get_attribute(self, key: str, default: Any = None) -> Any:
        """属性を取得"""
        return self.attributes.get(key, default)
    
    def set_attribute(self, key: str, value: Any) -> None:
        """属性を設定"""
        self.attributes[key] = value


@dataclass
class DocumentNode(ASTNode):
    """文書ノード"""
    def __post_init__(self):
        self.node_type = NodeType.DOCUMENT


@dataclass
class SectionNode(ASTNode):
    """セクションノード"""
    level: int = 1
    title: str = ""
    
    def __post_init__(self):
        if self.level == 1:
            self.node_type = NodeType.SECTION
        elif self.level == 2:
            self.node_type = NodeType.SUBSECTION
        else:
            self.node_type = NodeType.SUBSUBSECTION


@dataclass
class MathNode(ASTNode):
    """数式ノード"""
    math_type: str = "inline"  # inline, display, align, align*
    label: Optional[str] = None
    alignment_points: List[int] = field(default_factory=list)
    
    def __post_init__(self):
        if self.math_type == "inline":
            self.node_type = NodeType.MATH_INLINE
        elif self.math_type == "display":
            self.node_type = NodeType.MATH_DISPLAY
        elif self.math_type == "align":
            self.node_type = NodeType.MATH_ALIGN
        elif self.math_type == "align*":
            self.node_type = NodeType.MATH_ALIGN_STAR


@dataclass
class TheoremNode(ASTNode):
    """定理ノード"""
    theorem_type: str = "theorem"  # theorem, lemma, proposition, etc.
    title: Optional[str] = None
    label: Optional[str] = None
    
    def __post_init__(self):
        if self.theorem_type == "theorem":
            self.node_type = NodeType.THEOREM
        elif self.theorem_type == "lemma":
            self.node_type = NodeType.LEMMA
        elif self.theorem_type == "proposition":
            self.node_type = NodeType.PROPOSITION
        elif self.theorem_type == "corollary":
            self.node_type = NodeType.COROLLARY
        elif self.theorem_type == "definition":
            self.node_type = NodeType.DEFINITION
        elif self.theorem_type == "remark":
            self.node_type = NodeType.REMARK
        elif self.theorem_type == "example":
            self.node_type = NodeType.EXAMPLE
        elif self.theorem_type == "proof":
            self.node_type = NodeType.PROOF


@dataclass
class ReferenceNode(ASTNode):
    """参照ノード"""
    ref_type: str = "ref"  # ref, eqref, cite
    target: str = ""
    supplement: Optional[str] = None
    
    def __post_init__(self):
        if self.ref_type == "ref":
            self.node_type = NodeType.REF
        elif self.ref_type == "eqref":
            self.node_type = NodeType.EQREF
        elif self.ref_type == "cite":
            self.node_type = NodeType.CITE


@dataclass
class AccentNode(ASTNode):
    """アクセントノード"""
    accent_type: str = ""  # dot, hat, bar, tilde, vec, etc.
    base: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.ACCENT


@dataclass
class FunctionNode(ASTNode):
    """関数ノード"""
    function_name: str = ""
    arguments: List[str] = field(default_factory=list)
    
    def __post_init__(self):
        self.node_type = NodeType.FUNCTION


@dataclass
class SymbolNode(ASTNode):
    """記号ノード"""
    symbol_name: str = ""
    unicode_char: Optional[str] = None
    
    def __post_init__(self):
        self.node_type = NodeType.SYMBOL


@dataclass
class VariableNode(ASTNode):
    """変数ノード"""
    variable_name: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.VARIABLE


@dataclass
class OperatorNode(ASTNode):
    """演算子ノード"""
    operator_name: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.OPERATOR


@dataclass
class FractionNode(ASTNode):
    """分数ノード"""
    numerator: str = ""
    denominator: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.FRACTION


@dataclass
class SubscriptNode(ASTNode):
    """下付き文字ノード"""
    base: str = ""
    subscript: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.SUBSCRIPT


@dataclass
class SuperscriptNode(ASTNode):
    """上付き文字ノード"""
    base: str = ""
    superscript: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.SUPERSCRIPT


@dataclass
class TextNode(ASTNode):
    """テキストノード"""
    def __post_init__(self):
        self.node_type = NodeType.TEXT


@dataclass
class UnknownNode(ASTNode):
    """未知ノード（退避用）"""
    original_content: str = ""
    
    def __post_init__(self):
        self.node_type = NodeType.UNKNOWN


# 型エイリアス
ASTNodeType = Union[
    DocumentNode, SectionNode, MathNode, TheoremNode, ReferenceNode,
    AccentNode, FunctionNode, SymbolNode, VariableNode, OperatorNode,
    FractionNode, SubscriptNode, SuperscriptNode, TextNode, UnknownNode
]
