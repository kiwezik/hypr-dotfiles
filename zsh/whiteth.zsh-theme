# This is completely white ohmyzsh theme. Copy this file in "~/.oh-my-zsh/themes/whiteth.zsh-theme" and enable: omz theme set whiteshit
# Or you can try it in your current session first: omz theme use whiteth
PROMPT="%(?:%{$fg_bold[white]%}%1{➜%} :%{$fg_bold[white]%}%1{➜%} ) %{$fg[white]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}git:(%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}) %{$fg[white]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%})"
