autoload -U colors && colors

source ~/dotfiles/zsh/git-prompt.sh

setopt PROMPT_SUBST

git_prompt() {
    if git rev-parse --is-inside-work-tree 2> /dev/null | grep -q 'true' ; then
        local GITPROMPT=", "
        GITPROMPT+="%{$fg[magenta]%}$(__git_ps1 '%s')%{$reset_color%}"

        # Number of changed files: https://github.com/Parth/dotfiles/blob/master/zsh/prompt.sh
        local STATUS=$(git status --short | wc -l)
        if [ $STATUS -gt 0 ]; then
            GITPROMPT+="%{$fg[green]%}+$STATUS%{$reset_color%}"
        fi

        echo $GITPROMPT
    fi
}

PS1='['

# working directory
PS1+='%{$fg_bold[blue]%}%1~%{$reset_color%}'
# last status code if not 0
PS1+='%(?.., %{$fg[red]%}%?%{$reset_color%})'
# git status
PS1+='$(git_prompt)'

PS1+=']: '

