"""
メタコメント処理ユーティリティ

ラウンドトリップ変換の可逆性を保証するためのメタコメントを処理する。
"""

import re
from typing import Dict, Optional, List, Tuple
from dataclasses import dataclass


@dataclass
class MetaComment:
    """メタコメントのデータ構造"""
    comment_type: str  # formula, ref, theorem, etc.
    subtype: Optional[str] = None  # display, align, ref, eqref, etc.
    supplement: Optional[str] = None  # Theorem, etc.
    attributes: Dict[str, str] = None
    
    def __post_init__(self):
        if self.attributes is None:
            self.attributes = {}


class MetaCommentParser:
    """メタコメントパーサー"""
    
    def __init__(self):
        # メタコメントの正規表現パターン
        self.pattern = re.compile(
            r'//\[([^\]]+)\]',
            re.MULTILINE
        )
    
    def parse_meta_comment(self, comment_text: str) -> Optional[MetaComment]:
        """メタコメントを解析"""
        if not comment_text.startswith('//[') or not comment_text.endswith(']'):
            return None
        
        # 括弧内の内容を抽出
        content = comment_text[3:-1]
        
        # キー=値のペアを解析
        attributes = {}
        parts = content.split(',')
        
        for part in parts:
            part = part.strip()
            if ':' in part:
                key, value = part.split(':', 1)
                attributes[key.strip()] = value.strip()
            else:
                # 単一の値の場合
                if not attributes:
                    attributes['type'] = part
        
        # メタコメントタイプを決定
        comment_type = attributes.get('type', '')
        subtype = attributes.get('subtype')
        supplement = attributes.get('supplement')
        
        return MetaComment(
            comment_type=comment_type,
            subtype=subtype,
            supplement=supplement,
            attributes=attributes
        )
    
    def extract_meta_comments(self, text: str) -> List[Tuple[str, MetaComment]]:
        """テキストからメタコメントを抽出"""
        comments = []
        matches = self.pattern.finditer(text)
        
        for match in matches:
            comment_text = match.group(0)
            meta_comment = self.parse_meta_comment(comment_text)
            if meta_comment:
                comments.append((comment_text, meta_comment))
        
        return comments
    
    def remove_meta_comments(self, text: str) -> str:
        """テキストからメタコメントを削除"""
        return self.pattern.sub('', text).strip()


class MetaCommentGenerator:
    """メタコメント生成器"""
    
    def generate_formula_meta_comment(self, math_type: str) -> str:
        """数式のメタコメントを生成"""
        return f"//[formula type:{math_type}]"
    
    def generate_ref_meta_comment(self, ref_type: str, supplement: Optional[str] = None) -> str:
        """参照のメタコメントを生成"""
        if supplement:
            return f"//[ref type:{ref_type} supplement:{supplement}]"
        else:
            return f"//[ref type:{ref_type}]"
    
    def generate_theorem_meta_comment(self, theorem_type: str) -> str:
        """定理のメタコメントを生成"""
        return f"//[{theorem_type}]"
    
    def generate_custom_meta_comment(self, comment_type: str, **kwargs) -> str:
        """カスタムメタコメントを生成"""
        parts = [f"{k}:{v}" for k, v in kwargs.items()]
        if parts:
            return f"//[{comment_type} {','.join(parts)}]"
        else:
            return f"//[{comment_type}]"


# グローバルインスタンス
meta_comment_parser = MetaCommentParser()
meta_comment_generator = MetaCommentGenerator()
