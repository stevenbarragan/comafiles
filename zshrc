eval "$(starship init zsh)"

# https://github.com/sindresorhus/pure/issues/39#issuecomment-386371357
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export TERM="${TERM:-"xterm-256color"}"
export VOLTPATH="${HOME}/.config/volt"
export KEYTIMEOUT=1          # By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered
export PATH=${HOME}/go/bin:$PATH

bindkey "^?" backward-delete-char # https://github.com/denysdovhan/spaceship-prompt/issues/91#issuecomment-327996599

zplugin light "mikedacre/tmux-zsh-vim-titles"
zplugin light "zdharma/fast-syntax-highlighting"


set -o vi
export EDITOR=vim
export VISUAL=vim

autoload -U colors && colors # enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

setopt cdablevars            # With CDABLEVARS, if the argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory.
setopt correct               # CORRECT turns on spelling correction for commands, and the CORRECTALL option turns on spelling correction for all arguments.
setopt globdots              # GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
setopt appendhistory         # sessions will append their history list to the history file, rather than replace it.

zplugin light "zsh-users/zsh-history-substring-search"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

fpath=(/usr/local/share/zsh-completions $fpath)

here=$(dirname $0)
source ${here}/aliases

# Enable autocompletions
autoload -Uz compinit

typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

export ZSH_AUTOSUGGEST_USE_ASYNC=1
zplugin light "zsh-users/zsh-autosuggestions"
bindkey '^ ' autosuggest-accept
