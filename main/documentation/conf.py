# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here.
import os
import sys
#sys.path.insert(0, pathlib.Path(__file__).parents[2].resolve().as_posix())
sys.path.insert(0, os.path.abspath(".."))
sys.path.append(os.path.abspath("./_ext"))



#sys.path.append('/home/agnes/MTE/docs/source/')

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'MTE'
copyright = '2023, Agnes'
author = 'Agnes'
release = '0.1'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
numfig = True
html4_writer = True

numfig_format={'figure': 'Figure %s', 'code-block': '%s',}


extensions = [
        'sphinx.ext.doctest','sphinx.ext.autodoc',
        'sphinxcontrib.bibtex', 'sphinx.ext.mathjax',
        'sphinx.ext.todo','sphinx.ext.viewcode',
        'sphinx_toolbox.collapse','helloworld',
]

todo_include_todos = True

bibtex_bibfiles= ['references.bib']

templates_path = ['_templates']
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
#html_theme = 'sphinxawesome_theme'
html_theme = 'nature'

html_logo = "Logo2.png"

html_static_path = ['_static']
