source ~/.zplug/init.zsh

zplug "b4b4r07/enhancd", use:init.sh
zplug "mikedacre/tmux-zsh-vim-titles"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

zplug "talal/mimir", from:gh-r, as:command

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
	zplug install
fi

zplug load

set -o vi

autoload -Uz add-zsh-hook
prompt_mimir_cmd() { ~/.zplug/bin/mimir }
add-zsh-hook precmd prompt_mimir_cmd

prompt_symbol="❯"
PROMPT="%(?.%F{magenta}.%F{red})${prompt_symbol}%f "
