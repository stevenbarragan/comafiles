source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# https://github.com/sindresorhus/pure/issues/39#issuecomment-386371357
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export TERM="${TERM:-"xterm-256color"}"
export VOLTPATH="${HOME}/.config/volt"

bindkey "^?" backward-delete-char # https://github.com/denysdovhan/spaceship-prompt/issues/91#issuecomment-327996599

zplugin ice from"gh-r" as"program"
zplugin load "talal/mimir"

zplugin ice from"gh-r" as"program" mv"*volt* -> volt" atclone".volt get -l"
zplugin load "vim-volt/volt"

zplugin light "b4b4r07/enhancd"
zplugin light "mikedacre/tmux-zsh-vim-titles"
zplugin light "zdharma/fast-syntax-highlighting"

export ZSH_AUTOSUGGEST_USE_ASYNC=1
zplugin light "zsh-users/zsh-autosuggestions"
bindkey '^ ' autosuggest-accept

# mimir prompt https://github.com/talal/mimir#zsh
autoload -Uz add-zsh-hook
prompt_mimir_cmd() { mimir }
add-zsh-hook precmd prompt_mimir_cmd
prompt_symbol="❯"
PROMPT="%(?.%F{magenta}.%F{red})${prompt_symbol}%f "

set -o vi
export EDITOR=vim
export VISUAL=vim
