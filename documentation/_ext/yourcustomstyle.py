from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, Token, \
     Number, Operator, Generic, Whitespace, Punctuation, Other, Literal

class YourStyle(Style):
    """
    This style mimics the Monokai color scheme.
    """


    line_number_color = "#B3B3B3"
    line_number_background_color = "#2B303B"
    #line_number_background_color = "#24241F"

    #line_number_special_color = "#242933"
    #line_number_special_background_color = "#D8DEE9"

    background_color = "#2E3440"
    highlight_color = "#3B4252"


    #background_color = "#272822"
    #highlight_color = "#49483e"

    styles = {
        # No corresponding class for the following:
        Token:                     "#f8f8f2", # class:  ''
        Whitespace:                "",        # class: 'w'
        Error:                     "#ed007e bg:#1e0010", # class: 'err'
        Other:                     "",        # class 'x'

        Comment:                   "#6a9953", # class: 'c'
        Comment.Multiline:         "",        # class: 'cm'
        Comment.Preproc:           "",        # class: 'cp'
        Comment.Single:            "",        # class: 'c1'
        Comment.Special:           "",        # class: 'cs'

        Keyword:                   "bold #C04C4C", # class: 'k'
        Keyword.Constant:          "nobold #3f90d0",        # class: 'kc'
        Keyword.Declaration:       "",        # class: 'kd'
        Keyword.Namespace:         "nobold #CBAEEC", # class: 'kn'
        Keyword.Pseudo:            "",        # class: 'kp'
        Keyword.Reserved:          "",        # class: 'kr'
        Keyword.Type:              "",        # class: 'kt'

        Operator:                  "#F5B60B", # class: 'o'
        Operator.Word:             "bold #3f90d0",        # class: 'ow' - like keywords

        Punctuation:               "#f8f8f2", # class: 'p'

        Name:                      "#B5D3DF", # class: 'n'
        Name.Attribute:            "#a6e22e", # class: 'na' - to be revised
        Name.Builtin:              "#25E6C6",        # class: 'nb'
        Name.Builtin.Pseudo:       "",        # class: 'bp'
        Name.Class:                "#7A7A00", # class: 'nc' - to be revised
        Name.Constant:             "#66d9ef", # class: 'no' - to be revised
        Name.Decorator:            "#a6e22e", # class: 'nd' - to be revised
        Name.Entity:               "",        # class: 'ni'
        Name.Exception:            "#a6e22e", # class: 'ne'
        Name.Function:             "#a6e22e", # class: 'nf'
        Name.Property:             "",        # class: 'py'
        Name.Label:                "",        # class: 'nl'
        Name.Namespace:            "",        # class: 'nn' - to be revised
        Name.Other:                "bold #C04C4C", # class: 'nx'
        Name.Tag:                  "#ff4689", # class: 'nt' - like a keyword
        Name.Variable:             "",        # class: 'nv' - to be revised
        Name.Variable.Class:       "",        # class: 'vc' - to be revised
        Name.Variable.Global:      "",        # class: 'vg' - to be revised
        Name.Variable.Instance:    "",        # class: 'vi' - to be revised

        Number:                    "#a6ce96", # class: 'm'
        Number.Float:              "",        # class: 'mf'
        Number.Hex:                "",        # class: 'mh'
        Number.Integer:            "",        # class: 'mi'
        Number.Integer.Long:       "",        # class: 'il'
        Number.Oct:                "",        # class: 'mo'

        Literal:                   "#ae81ff", # class: 'l'
        Literal.Date:              "#e6db74", # class: 'ld'

        String:                    "#AA6844", # class: 's'
        String.Backtick:           "",        # class: 'sb'
        String.Char:               "",        # class: 'sc'
        String.Doc:                "",        # class: 'sd' - like a comment
        String.Double:             "",        # class: 's2'
        String.Escape:             "#ae81ff", # class: 'se'
        String.Heredoc:            "",        # class: 'sh'
        String.Interpol:           "",        # class: 'si'
        String.Other:              "",        # class: 'sx'
        String.Regex:              "",        # class: 'sr'
        String.Single:             "",        # class: 's1'
        String.Symbol:             "",        # class: 'ss'


        Generic:                   "",        # class: 'g'
        Generic.Deleted:           "#ff4689", # class: 'gd',
        Generic.Emph:              "italic",  # class: 'ge'
        Generic.Error:             "",        # class: 'gr'
        Generic.Heading:           "",        # class: 'gh'
        Generic.Inserted:          "#a6e22e", # class: 'gi'
        Generic.Output:            "#66d9ef", # class: 'go'
        Generic.Prompt:            "bold #ff4689", # class: 'gp'
        Generic.Strong:            "bold",    # class: 'gs'
        Generic.EmphStrong:        "bold italic",  # class: 'ges'
        Generic.Subheading:        "#959077", # class: 'gu'
        Generic.Traceback:         "",        # class: 'gt'
    }
