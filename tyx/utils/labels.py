"""
ラベル管理ユーティリティ

TeXとTypstのラベル参照を管理する。
"""

import re
from typing import Dict, Set, Optional, List
from dataclasses import dataclass


@dataclass
class LabelInfo:
    """ラベル情報"""
    label: str
    label_type: str  # theorem, eq, fig, table, section
    title: Optional[str] = None
    line_number: Optional[int] = None
    file_path: Optional[str] = None


class LabelManager:
    """ラベル管理クラス"""
    
    def __init__(self):
        self.labels: Dict[str, LabelInfo] = {}
        self.references: Set[str] = set()
        self.conflicts: List[str] = []
    
    def add_label(self, label: str, label_type: str, title: Optional[str] = None, 
                  line_number: Optional[int] = None, file_path: Optional[str] = None) -> None:
        """ラベルを追加"""
        if label in self.labels:
            # ラベル衝突を記録
            self.conflicts.append(f"Label '{label}' already exists")
            return
        
        self.labels[label] = LabelInfo(
            label=label,
            label_type=label_type,
            title=title,
            line_number=line_number,
            file_path=file_path
        )
    
    def add_reference(self, ref: str) -> None:
        """参照を追加"""
        self.references.add(ref)
    
    def get_label_info(self, label: str) -> Optional[LabelInfo]:
        """ラベル情報を取得"""
        return self.labels.get(label)
    
    def is_label_defined(self, label: str) -> bool:
        """ラベルが定義されているかチェック"""
        return label in self.labels
    
    def is_reference_valid(self, ref: str) -> bool:
        """参照が有効かチェック"""
        return ref in self.labels
    
    def get_undefined_references(self) -> List[str]:
        """未定義の参照を取得"""
        return list(self.references - set(self.labels.keys()))
    
    def get_unused_labels(self) -> List[str]:
        """未使用のラベルを取得"""
        return list(set(self.labels.keys()) - self.references)
    
    def normalize_label(self, label: str) -> str:
        """ラベルを正規化"""
        # 正規化IDの接頭辞を追加
        if not any(label.startswith(prefix) for prefix in ['theorem:', 'eq:', 'fig:', 'table:', 'section:']):
            # ラベルタイプを推測して接頭辞を追加
            if 'theorem' in label.lower() or 'lemma' in label.lower() or 'proposition' in label.lower():
                return f"theorem:{label}"
            elif 'eq' in label.lower() or 'equation' in label.lower():
                return f"eq:{label}"
            elif 'fig' in label.lower() or 'figure' in label.lower():
                return f"fig:{label}"
            elif 'table' in label.lower():
                return f"table:{label}"
            elif 'section' in label.lower() or 'sec' in label.lower():
                return f"section:{label}"
        
        return label
    
    def denormalize_label(self, normalized_label: str) -> str:
        """正規化されたラベルを元に戻す"""
        for prefix in ['theorem:', 'eq:', 'fig:', 'table:', 'section:']:
            if normalized_label.startswith(prefix):
                return normalized_label[len(prefix):]
        return normalized_label
    
    def clear(self) -> None:
        """ラベル管理をクリア"""
        self.labels.clear()
        self.references.clear()
        self.conflicts.clear()


class LabelExtractor:
    """ラベル抽出器"""
    
    def __init__(self):
        # TeXラベルの正規表現
        self.tex_label_pattern = re.compile(r'\\label\{([^}]+)\}')
        self.tex_ref_pattern = re.compile(r'\\(?:ref|eqref)\{([^}]+)\}')
        self.tex_cite_pattern = re.compile(r'\\cite\{([^}]+)\}')
        
        # Typstラベルの正規表現
        self.typst_label_pattern = re.compile(r'<([^>]+)>')
        self.typst_ref_pattern = re.compile(r'@([a-zA-Z0-9_:]+)')
    
    def extract_tex_labels(self, text: str) -> List[str]:
        """TeXからラベルを抽出"""
        labels = []
        matches = self.tex_label_pattern.finditer(text)
        for match in matches:
            labels.append(match.group(1))
        return labels
    
    def extract_tex_references(self, text: str) -> List[str]:
        """TeXから参照を抽出"""
        refs = []
        matches = self.tex_ref_pattern.finditer(text)
        for match in matches:
            refs.append(match.group(1))
        return refs
    
    def extract_tex_citations(self, text: str) -> List[str]:
        """TeXから引用を抽出"""
        citations = []
        matches = self.tex_cite_pattern.finditer(text)
        for match in matches:
            citations.append(match.group(1))
        return citations
    
    def extract_typst_labels(self, text: str) -> List[str]:
        """Typstからラベルを抽出"""
        labels = []
        matches = self.typst_label_pattern.finditer(text)
        for match in matches:
            labels.append(match.group(1))
        return labels
    
    def extract_typst_references(self, text: str) -> List[str]:
        """Typstから参照を抽出"""
        refs = []
        matches = self.typst_ref_pattern.finditer(text)
        for match in matches:
            refs.append(match.group(1))
        return refs


# グローバルインスタンス
label_manager = LabelManager()
label_extractor = LabelExtractor()
