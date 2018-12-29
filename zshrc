source ~/.zplug/init.zsh

zplug "b4b4r07/enhancd", use:init.sh
zplug "supercrabtree/k"
zplug "mikedacre/tmux-zsh-vim-titles"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

zplug install
zplug load

set -o vi
