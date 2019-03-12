# https://github.com/sindresorhus/pure/issues/39#issuecomment-386371357
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export TERM="${TERM:-"xterm-256color"}"
export VOLTPATH="${HOME}/.config/volt"
export KEYTIMEOUT=1          # By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered

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

autoload -Uz add-zsh-hook    # mimir prompt https://github.com/talal/mimir#zsh
prompt_mimir_cmd() { mimir }
add-zsh-hook precmd prompt_mimir_cmd
prompt_symbol="❯"
PROMPT="%(?.%F{magenta}.%F{red})${prompt_symbol}%f "

set -o vi
export EDITOR=vim
export VISUAL=vim

autoload -U colors && colors # enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

setopt autocd                # Using the AUTOCD option, you can simply type the name of a directory, and it will become the current directory.
setopt cdablevars            # With CDABLEVARS, if the argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory.
setopt correct               # CORRECT turns on spelling correction for commands, and the CORRECTALL option turns on spelling correction for all arguments.
setopt globdots              # GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
setopt appendhistory         # sessions will append their history list to the history file, rather than replace it.

zplugin light "zsh-users/zsh-history-substring-search"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -Uz compinit        # https://gist.github.com/ctechols/ca1035271ad134841284
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;
