# vi mode
bindkey -v
export KEYTIMEOUT=1

# history completion
bindkey '^o' autosuggest-execute
bindkey '^ ' autosuggest-accept

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey '^[[1;5C' forward-word  # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word # [Ctrl-LeftArrow] - move backward one word
bindkey '^H' backward-kill-word # [Ctrl-Backspace] - delete last word
bindkey '^[[3;5~' kill-word     # [Ctrl-Delete] - delete forward word

bindkey -s '^[[1;5A' 'cd ..\n' # [Ctrl-UpArrow] - cd to parent directory
bindkey -s '^[[1;5B' 'cd -\n'  # [Ctrl-DownArrow] - cd to previous directory
