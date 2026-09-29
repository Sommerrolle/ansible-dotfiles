function tldr
	if [ $argv ]
		command tldr $argv
	else
		command tldr --list | fzf --preview 'command tldr {} --color always' | xargs -r tldr
	end
end
