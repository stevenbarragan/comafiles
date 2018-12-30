source ~/.zplug/init.zsh

if ! zplug check; then
  zplug install
fi

zplug load

set -o vi

# mimir prompt https://github.com/talal/mimir#zsh
autoload -Uz add-zsh-hook
prompt_mimir_cmd() { ~/.zplug/bin/mimir }
add-zsh-hook precmd prompt_mimir_cmd

prompt_symbol="❯"
PROMPT="%(?.%F{magenta}.%F{red})${prompt_symbol}%f "
