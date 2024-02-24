source "$HOME/dotfiles/fish/prompt.fish"
source "$HOME/dotfiles/fish/colorscheme.fish"
source "$HOME/dotfiles/fish/keybinds.fish"

# Prepend to load custom completions before built-in completions
set -p fish_complete_path "$HOME/dotfiles/fish/completions"

# ignore certain commands in history
function ignorehistory --on-event fish_prompt
    history delete --exact --case-sensitive fg
end

fish_add_path "$HOME/dotfiles/utils"
fish_add_path "$HOME/.fzf/bin"
fish_add_path "$HOME/.pyenv/bin"

alias tms=tmux-sessionizer
