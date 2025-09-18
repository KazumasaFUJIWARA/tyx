from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="tyx",
    version="1.0.0",
    author="tyx project",
    description="TeX ⇄ Typst 変換器",
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
    python_requires=">=3.8",
    install_requires=[
        "lark>=1.1.0",
        "pyparsing>=3.0.0",
        "regex>=2023.0.0",
        "pyyaml>=6.0",
        "click>=8.0.0",
        "rich>=13.0.0",
        "loguru>=0.7.0",
    ],
    extras_require={
        "dev": [
            "pytest>=7.0.0",
            "pytest-cov>=4.0.0",
            "black>=23.0.0",
            "flake8>=6.0.0",
            "mypy>=1.0.0",
        ],
    },
    entry_points={
        "console_scripts": [
            "tex2typst=tyx.cli.main:tex2typst",
            "typst2tex=tyx.cli.main:typst2tex",
            "roundtrip_check=tyx.cli.main:roundtrip_check",
        ],
    },
)
