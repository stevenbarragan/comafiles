if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug load

set -o vi

# mimir prompt https://github.com/talal/mimir#zsh
autoload -Uz add-zsh-hook
prompt_mimir_cmd() { ~/.zplug/bin/mimir }
add-zsh-hook precmd prompt_mimir_cmd

prompt_symbol="❯"
PROMPT="%(?.%F{magenta}.%F{red})${prompt_symbol}%f "
