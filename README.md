# Lamine

My personal setup for neovim, pure lua, lazy.nvim based

## Author

Copyright © 2024 Robert Dober robert.dober@gmail.com

# LICENSE

GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007 or later. Please refer to [LICENSE](LICENSE) for details.

## DEVNOTES
### 2025-01-12

do completion for ruby
rspec_config completion for ruby

### 2025-01-10
    Road to v0.1.1
    
    LAST
    
        elixir autocompletion WIP
    
    STARTUP
        - startup script WIP (lnb and tabs for files ✓, colorschemes, nerdtree
            etc, missing)
    
    CONFIGURATION
        - speced lua ftplugin settings
        - gitcommit settings
    
    KEYBINDINGS
        - speced all defined keymappings
        - working on keymappings to replace vimine keymappings
            - plugin dependent -> <Leader>co for Commentary
        - progress on tmux mappings WIP
        - win navigation better <space>q, Gf for <c-w>g-f
        - allow <leader><space> to escape from command mode
    
    COMMANDS
    
    AUTOCOMPLETION
        - autocompletion WIP
            - negative col offsets fixed
            - basic continuations (set cursor) ✓
            - basic continuations Integretation Specs WIP
            - refactored context and api ✓
            - refactoring with the almighty replace_matches_and_add_lines ✓
            - keybinding for input mode and autocomplete defined ✓
            - autocompletions to be speced and implemented WIP
            - abort function to allow replacers to abort a match
            - replacers C.get_function (from predefined) C.match_against_table (to replace a generic match from a table or abort
            - created common patterns module
    
        Filetype Autocompletion
    
            - MARKDOWN WIP (fn%d for footnotes, hl%d for headlines)
            - GENERAL
                arrows ✓
                %functions WIP
    
            - ELIXIR
                started -> 'do', '|>', fn, #{}, doc, moduledoc
                started subtype test -> describe and test, desc and test
                    oneline completions
    
            - LUA
                req,  local req (with var assignment), ERR ✓
                simple word replacements WIP lo ✓
    
            - RUBY
                string interpolation @@@, def, case, OK, NOK ✓
                requires ✓
                continuing keywords WIP attr_reader → ✓
                starting keywords WIP priv, definit → ✓
    
            - TYPST
               footnote, hl%d, inc, pbr, # for empty ✓
    
    LIBRARY
        - tools.combine can be aborted
    
    INTERNAL
        - Redundant specs removed

<!--SPDX-License-Identifier: AGPL-3.0-or-later-->
