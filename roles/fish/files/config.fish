if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
# Set greeting message
#set -U fish_greeting ""

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end


# opencode
fish_add_path /home/cvt/.opencode/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/cvt/miniconda3/bin/conda
    eval /home/cvt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/cvt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/cvt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/cvt/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# init zoxide
zoxide init fish | source
