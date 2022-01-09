if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
# Set greeting message
set -U fish_greeting ""

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

