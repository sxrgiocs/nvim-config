local M = {}

M.query = [[
; Comments & docstrings / strings
(comment) @comment
(string) @string
(escape_sequence) @string.escape

; Keywords
"def" @keyword.function
"return" @keyword.return
[ "import" "from" "as" ] @keyword.import
[
  "class"
  "if"
  "elif"
  "else"
  "for"
  "while"
  "break"
  "continue"
  "try"
  "except"
  "finally"
  "with"
  "in"
  "is"
  "not"
  "and"
  "or"
  "yield"
  "pass"
  "raise"
  "lambda"
] @keyword

; Operators
[
  "-" "-=" ":=" "!=" "*" "**" "**=" "*=" "/" "//" "//=" "/="
  "&" "&=" "%" "%=" "^" "^=" "+" "+=" "<" "<<" "<<=" "<=" "<>"
  "=" "==" ">" ">=" ">>" ">>=" "@" "@=" "|" "|=" "~" "->"
] @operator

; Delimiters & brackets
[ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket
[ "," "." ":" ";" ] @punctuation.delimiter

; Constants, booleans, numbers
[ (true) (false) ] @boolean
(none) @constant.builtin
(float) @number.float
(integer) @number
((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

; Special variables (self, cls)
((identifier) @variable.builtin
  (#any-of? @variable.builtin "self" "cls"))

; Builtin types (used as values e.g. dtype=bool, isinstance(x, int))
((identifier) @type.builtin
  (#any-of? @type.builtin
    "bool" "int" "float" "str" "bytes" "list" "tuple" "dict" "set"
    "frozenset" "object" "type" "complex" "range"
    "Exception" "ValueError" "TypeError" "KeyError" "IndexError"))

; Types in annotations
(type (identifier) @type)
(type (generic_type (identifier) @type))
(type (attribute attribute: (identifier) @type))

; Module / package imports
(import_statement name: (dotted_name (identifier) @module))
(import_from_statement module_name: (dotted_name (identifier) @module))
(aliased_import name: (dotted_name (identifier) @module))
(aliased_import alias: (identifier) @module)
(attribute object: (identifier) @module)

; Functions
(function_definition
  name: (identifier) @function)

(call
  function: (identifier) @function.call)

(call
  function: (attribute attribute: (identifier) @function.call))

; Parameters (in function definitions and call-site keyword arguments)
(parameters (identifier) @variable.parameter)
(parameters (default_parameter name: (identifier) @variable.parameter))
(typed_parameter (identifier) @variable.parameter)
(typed_default_parameter name: (identifier) @variable.parameter)
(parameters (list_splat_pattern (identifier) @variable.parameter))
(parameters (dictionary_splat_pattern (identifier) @variable.parameter))
(keyword_argument name: (identifier) @variable.parameter)
(default_parameter name: (identifier) @variable.parameter)
]]

function M.setup()
    -- Register the custom Tree-sitter highlighting query for Python
    vim.treesitter.query.set("python", "highlights", M.query)

    -- Auto-start native Tree-sitter for python buffers
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
            pcall(vim.treesitter.start, args.buf, "python")
        end,
    })
end

-- Auto-run setup when required
M.setup()

return M
