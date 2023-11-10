# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here.
import os
import sys
#sys.path.insert(0, pathlib.Path(__file__).parents[2].resolve().as_posix())
#sys.path.insert(0, os.path.abspath(".."))
#sys.path.insert(0, os.path.abspath("../.."))

sys.path.insert(0, os.path.abspath('../'))
sys.path.append(os.path.abspath("./_ext"))

#sys.path.append('/home/agnes/MTE/docs/source/')

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'MTE'
copyright = '2023, A.E. Hendrickx'
author = 'A.E. Hendrickx'
release = '1.0'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
numfig = True
numfig_format={'figure': 'Figure %s'}


extensions = [
        'sphinx.ext.doctest','sphinx.ext.autodoc',
        'sphinxcontrib.bibtex', 'sphinx.ext.mathjax',
        'sphinx.ext.todo','sphinx.ext.viewcode',
        'sphinx_toolbox.collapse','sphinx_rtd_theme',
]
#'sphinxawesome_theme.highlighting',
todo_include_todos = True

from pygments.styles import get_all_styles
styles = list(get_all_styles())

autodoc_mock_imports = [
    'numpy', 'scipy', 'numba',
    # ... other modules to mock ...
]


pygments_style = 'monokai'


bibtex_bibfiles= ['references.bib']

templates_path = ['_templates']
exclude_patterns = []

bibtex_reference_style = 'author_year'
#bibtex_reference_style = 'super'

#bibtex_default_style = 'plain'


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
##html_theme = 'sphinxawesome_theme'
html_theme = "sphinx_rtd_theme"
html_theme_options = {
    'analytics_anonymize_ip': False,
    'logo_only': True,
    'display_version': True,
    'prev_next_buttons_location': 'bottom',
    'style_external_links': True,
    'vcs_pageview_mode': '',
    'style_nav_header_background': 'white',
    # Toc options
    'collapse_navigation': True,
    'sticky_navigation': True,
    'navigation_depth': 4,
    'includehidden': True,
    'titles_only': False
}

html_show_sourcelink = False

#html_theme = "furo"
#html_theme_options = {
#    "sidebar_hide_name": True,
#    "navigation_with_keys": True,
#    }

html_logo = "Logo2r2.png"
html_static_path = ['_static']
html_css_files = [
    'custom.css',
]
