"""
Unicode処理ユーティリティ

TeXコマンドとUnicode文字の相互変換を行う。
"""

from typing import Dict, Optional, Tuple
import unicodedata


class UnicodeConverter:
    """Unicode変換器"""
    
    def __init__(self):
        # TeXコマンド → Unicode文字のマッピング
        self.tex_to_unicode = {
            # ギリシャ文字
            'alpha': 'α', 'beta': 'β', 'gamma': 'γ', 'delta': 'δ',
            'epsilon': 'ε', 'zeta': 'ζ', 'eta': 'η', 'theta': 'θ',
            'iota': 'ι', 'kappa': 'κ', 'lambda': 'λ', 'mu': 'μ',
            'nu': 'ν', 'xi': 'ξ', 'omicron': 'ο', 'pi': 'π',
            'rho': 'ρ', 'sigma': 'σ', 'tau': 'τ', 'upsilon': 'υ',
            'phi': 'φ', 'chi': 'χ', 'psi': 'ψ', 'omega': 'ω',
            
            # 大文字ギリシャ文字
            'Alpha': 'Α', 'Beta': 'Β', 'Gamma': 'Γ', 'Delta': 'Δ',
            'Epsilon': 'Ε', 'Zeta': 'Ζ', 'Eta': 'Η', 'Theta': 'Θ',
            'Iota': 'Ι', 'Kappa': 'Κ', 'Lambda': 'Λ', 'Mu': 'Μ',
            'Nu': 'Ν', 'Xi': 'Ξ', 'Omicron': 'Ο', 'Pi': 'Π',
            'Rho': 'Ρ', 'Sigma': 'Σ', 'Tau': 'Τ', 'Upsilon': 'Υ',
            'Phi': 'Φ', 'Chi': 'Χ', 'Psi': 'Ψ', 'Omega': 'Ω',
            
            # 数学記号
            'infty': '∞', 'partial': '∂', 'nabla': '∇', 'pm': '±',
            'mp': '∓', 'times': '×', 'div': '÷', 'leq': '≤',
            'geq': '≥', 'neq': '≠', 'approx': '≈', 'equiv': '≡',
            'propto': '∝', 'in': '∈', 'notin': '∉', 'subset': '⊂',
            'supset': '⊃', 'subseteq': '⊆', 'supseteq': '⊇',
            'cup': '∪', 'cap': '∩', 'emptyset': '∅', 'varnothing': '∅',
            'rightarrow': '→', 'leftarrow': '←', 'leftrightarrow': '↔',
            'Rightarrow': '⇒', 'Leftarrow': '⇐', 'Leftrightarrow': '⇔',
            'sum': '∑', 'prod': '∏', 'int': '∫', 'oint': '∮',
            'bigcup': '⋃', 'bigcap': '⋂', 'bigoplus': '⊕',
            'bigotimes': '⊗', 'bigodot': '⊙',
            
            # 集合記号
            'mathbb{R}': 'ℝ', 'mathbb{N}': 'ℕ', 'mathbb{Z}': 'ℤ',
            'mathbb{Q}': 'ℚ', 'mathbb{C}': 'ℂ', 'mathbb{P}': 'ℙ',
            
            # フラクチャー文字
            'mathfrak{A}': '𝔄', 'mathfrak{B}': '𝔅', 'mathfrak{C}': 'ℭ',
            'mathfrak{D}': '𝔇', 'mathfrak{E}': '𝔈', 'mathfrak{F}': '𝔉',
            'mathfrak{G}': '𝔊', 'mathfrak{H}': 'ℌ', 'mathfrak{I}': 'ℑ',
            'mathfrak{J}': '𝔍', 'mathfrak{K}': '𝔎', 'mathfrak{L}': '𝔏',
            'mathfrak{M}': '𝔐', 'mathfrak{N}': '𝔑', 'mathfrak{O}': '𝔒',
            'mathfrak{P}': '𝔓', 'mathfrak{Q}': '𝔔', 'mathfrak{R}': 'ℜ',
            'mathfrak{S}': '𝔖', 'mathfrak{T}': '𝔗', 'mathfrak{U}': '𝔘',
            'mathfrak{V}': '𝔙', 'mathfrak{W}': '𝔚', 'mathfrak{X}': '𝔛',
            'mathfrak{Y}': '𝔜', 'mathfrak{Z}': 'ℨ',
            
            # カリグラフィー文字
            'mathcal{A}': '𝒜', 'mathcal{B}': 'ℬ', 'mathcal{C}': '𝒞',
            'mathcal{D}': '𝒟', 'mathcal{E}': 'ℰ', 'mathcal{F}': 'ℱ',
            'mathcal{G}': '𝒢', 'mathcal{H}': 'ℋ', 'mathcal{I}': 'ℐ',
            'mathcal{J}': '𝒥', 'mathcal{K}': '𝒦', 'mathcal{L}': 'ℒ',
            'mathcal{M}': 'ℳ', 'mathcal{N}': '𝒩', 'mathcal{O}': '𝒪',
            'mathcal{P}': '𝒫', 'mathcal{Q}': '𝒬', 'mathcal{R}': 'ℛ',
            'mathcal{S}': '𝒮', 'mathcal{T}': '𝒯', 'mathcal{U}': '𝒰',
            'mathcal{V}': '𝒱', 'mathcal{W}': '𝒲', 'mathcal{X}': '𝒳',
            'mathcal{Y}': '𝒴', 'mathcal{Z}': '𝒵',
        }
        
        # Unicode文字 → TeXコマンドの逆マッピング
        self.unicode_to_tex = {v: k for k, v in self.tex_to_unicode.items()}
    
    def tex_to_unicode_char(self, tex_command: str) -> Optional[str]:
        """TeXコマンドをUnicode文字に変換"""
        return self.tex_to_unicode.get(tex_command)
    
    def unicode_to_tex_command(self, unicode_char: str) -> Optional[str]:
        """Unicode文字をTeXコマンドに変換"""
        return self.unicode_to_tex.get(unicode_char)
    
    def is_tex_command(self, text: str) -> bool:
        """テキストがTeXコマンドかどうか判定"""
        return text in self.tex_to_unicode
    
    def is_unicode_math_symbol(self, char: str) -> bool:
        """文字がUnicode数学記号かどうか判定"""
        if len(char) != 1:
            return False
        
        # Unicodeカテゴリをチェック
        category = unicodedata.category(char)
        return category in ['Sm', 'So']  # Symbol, math; Symbol, other
    
    def normalize_unicode(self, text: str) -> str:
        """Unicode文字を正規化"""
        return unicodedata.normalize('NFC', text)
    
    def get_unicode_info(self, char: str) -> Tuple[str, str, str]:
        """Unicode文字の情報を取得"""
        if len(char) != 1:
            return "", "", ""
        
        name = unicodedata.name(char, "")
        category = unicodedata.category(char)
        decimal = ord(char)
        
        return name, category, str(decimal)


class MathSymbolConverter:
    """数学記号変換器"""
    
    def __init__(self):
        self.unicode_converter = UnicodeConverter()
    
    def convert_tex_math_symbols(self, text: str, use_unicode: bool = True) -> str:
        """TeX数学記号を変換"""
        if not use_unicode:
            return text
        
        # 単独のTeXコマンドをUnicodeに変換
        import re
        pattern = re.compile(r'\\([a-zA-Z]+)')
        
        def replace_command(match):
            command = match.group(1)
            unicode_char = self.unicode_converter.tex_to_unicode_char(command)
            if unicode_char:
                return unicode_char
            else:
                return match.group(0)  # 変換できない場合は元のまま
        
        return pattern.sub(replace_command, text)
    
    def convert_unicode_to_tex(self, text: str) -> str:
        """Unicode文字をTeXコマンドに変換"""
        result = ""
        for char in text:
            tex_command = self.unicode_converter.unicode_to_tex_command(char)
            if tex_command:
                result += f"\\{tex_command}"
            else:
                result += char
        
        return result
    
    def should_use_unicode(self, symbol: str) -> bool:
        """記号をUnicodeに変換すべきかどうか判定"""
        # 合字は保持（vec等）
        if symbol in ['vec', 'dot', 'hat', 'bar', 'tilde', 'ddot']:
            return False
        
        # 単独の数学記号はUnicodeに変換
        return self.unicode_converter.is_tex_command(symbol)


# グローバルインスタンス
unicode_converter = UnicodeConverter()
math_symbol_converter = MathSymbolConverter()
