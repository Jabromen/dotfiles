function fish_prompt
    # save last return code before executing any other commands
    set -l return_code $status

    printf '['
    # current directory: ~ if home
    printf '%s%s%s' (set_color brblue) (test $PWD = $HOME; and echo '~'; or basename $PWD) (set_color normal)
    # return code if non-zero
    if test $return_code -ne 0
        printf ', %s%s%s' (set_color red) $return_code (set_color normal)
    end
    # git prompt if in repo: string sub to remove parens from fish_vcs_prompt
    if set vcs_prompt (fish_vcs_prompt | string sub -s 3 -e -1)
        printf ', %s%s' (set_color magenta) $vcs_prompt
        # number of changed files since last commit
        set -l num_changed_files (git status --short | wc -l)
        if test $num_changed_files -gt 0
            printf '%s+%s' (set_color green) $num_changed_files
        end
        printf '%s' (set_color normal)
    end
    printf '] '
end
