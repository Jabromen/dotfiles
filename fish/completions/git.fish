# Source built-in git completions since this file being named 'git.fish' would otherwise prevent it from being loaded.
source "/usr/share/fish/completions/git.fish"

# Modified __fish_git_ranges to add range completions for commit hashes
function __complete_git_commit_ranges
    set -l both (commandline -ot | string replace -r '\.{2,3}' \n\$0\n)
    set -l from $both[1]
    set -l dots $both[2]
    # If we didn't need to split (or there's nothing _to_ split), complete only the first part
    # Note that status here is from `string replace` because `set` doesn't alter it
    if test -z "$from" -o $status -gt 0
        if commandline -ct | string match -q '*..*'
            # The cursor is right of a .. range operator, make sure to include them first.
            __fish_git_commits | string replace -r '' "$dots"
        else
            __fish_git_commits | string replace \t "$dots"\t
        end
        return 0
    end

    set -l from_refs
    if commandline -ct | string match -q '*..*'
        # If the cursor is right of a .. range operator, only complete the right part.
        set from_refs $from
    else
        set from_refs (__fish_git_commits | string match -e "$from" | string replace -r \t'.*$' '')
    end

    set -l to $both[3]
    # Remove description from the from-ref, not the to-ref.
    for from_ref in $from_refs
        for to_ref in (__fish_git_commits | string match "*$to*") # if $to is empty, this correctly matches everything
            printf "%s%s%s\n" $from_ref $dots $to_ref
        end
    end
end

# sc
complete -f -c git -n __fish_git_needs_command -a sc -d "alias: Show commits for current branch or range"
complete -f -c git -n '__fish_git_using_command sc' -ka '(__fish_git_commits)'
complete -f -c git -n '__fish_git_using_command sc' -ka '(__fish_git_refs)'
complete -f -c git -n '__fish_git_using_command sc' -ka '(__fish_git_ranges)'
complete -f -c git -n '__fish_git_using_command sc' -ka '(__complete_git_commit_ranges)'

# cmb
complete -f -c git -n __fish_git_needs_command -a cmb -d "alias: Cleanup branch merged remotely"

# fm
complete -f -c git -n __fish_git_needs_command -a fm -d "alias: Update main/master to remote w/o checkout"

# h/head/hp
complete -f -c git -n __fish_git_needs_command -a h -d "alias: Log head"
complete -f -c git -n __fish_git_needs_command -a head -d "alias: Log head"
complete -f -c git -n __fish_git_needs_command -a hp -d "alias: Log head with patch"

# r/ra/l/la
complete -f -c git -n __fish_git_needs_command -a r -d "alias: Log recent commits for current branch"
complete -f -c git -n __fish_git_needs_command -a ra -d "alias: Log recent commits for all refs"
complete -f -c git -n __fish_git_needs_command -a l -d "alias: Log all commits for current branch"
complete -f -c git -n __fish_git_needs_command -a la -d "alias: Log all commits for all refs"

# b/bs
complete -f -c git -n __fish_git_needs_command -a b -d "alias: All branches"
complete -f -c git -n __fish_git_needs_command -a bs -d "alias: All branches sorted by last commit date"
