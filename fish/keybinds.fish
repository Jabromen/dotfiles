function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

abbr -a vims --position command --set-cursor 'vim -S ~/.sessions/%'

function fish_user_key_bindings
    for mode in default insert visual
        # ctrl+o
        bind -M $mode \co accept-autosuggestion execute

        # ctrl+backspace
        bind -M $mode \b backward-kill-word

        # ctrl+delete
        bind -M $mode \e\[3\;5~ kill-word

        # ctrl+up
        bind -M $mode \e\[1\;5A 'cd ..; commandline -f repaint'

        # ctrl+down
        bind -M $mode \e\[1\;5B 'cd -; commandline -f repaint'
    end
end
