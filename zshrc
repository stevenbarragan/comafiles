#!/usr/bin/env zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# https://github.com/sindresorhus/pure/issues/39#issuecomment-386371357
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export TERM="${TERM:-"xterm-256color"}"
export KEYTIMEOUT=1          # By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered

zinit light zdharma-continuum/fast-syntax-highlighting

bindkey -v

set -o vi
export EDITOR=vim
export VISUAL=vim

autoload -U colors && colors # enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

setopt cdablevars            # With CDABLEVARS, if the argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory.
setopt correct               # CORRECT turns on spelling correction for commands, and the CORRECTALL option turns on spelling correction for all arguments.
setopt globdots              # GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
setopt appendhistory         # sessions will append their history list to the history file, rather than replace it.

zinit light zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

here=$(dirname $0)
source ${here}/zsh/aliases

# source ${here}/zsh/dotenv.zsh # Disable custom dotenv plugin

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

## History file configuration https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # remove older duplicate entries from history
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_reduce_blanks     # remove superfluous blanks from history items
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # save history entries as soon as they are entered
setopt share_history          # share history between different instances of the shell

export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
export ZSH_AUTOSUGGEST_COMPLETION_IGNORE="git *"
zinit light zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept

zmodload -i zsh/complist

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

zinit light mikedacre/tmux-zsh-vim-titles

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
