source "$HOME/dotfiles/fish/config.fish"

export TMUX_SESSIONIZER_DIRS=""

if test -x nvim
    alias vim='nvim'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
