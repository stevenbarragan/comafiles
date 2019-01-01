source '/Users/steven/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

export VOLTPATH="${HOME}/.config/volt"

zplugin ice from"gh-r" as"program"
zplugin light talal/mimir

zplugin ice from"gh-r" as"program" mv"*volt* -> volt" atclone"volt get -l"
zplugin light vim-volt/volt

zplugin light "b4b4r07/enhancd"

# mimir prompt https://github.com/talal/mimir#zsh
autoload -Uz add-zsh-hook
prompt_mimir_cmd() { mimir }
add-zsh-hook precmd prompt_mimir_cmd

prompt_symbol="❯"
PROMPT="%(?.%F{magenta}.%F{red})${prompt_symbol}%f "

set -o vi
