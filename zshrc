source ~/.zplug/init.zsh

zplug "b4b4r07/enhancd", use:init.sh
zplug "supercrabtree/k"
zplug "MikeDacre/tmux-zsh-vim-titles"
# zplug "zsh-users/zsh-autosuggestions"

# zplug "jhawthorn/fzy", \
#   as:command, \
#   rename-to:fzy, \
#   hook-build:"make && make install"

zplug install
zplug load

set -o vi
