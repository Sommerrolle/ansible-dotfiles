function ls --wraps='eza -al --color=always --group-directories-first' --description 'alias ls=eza -al --color=always --group-directories-first'
  eza -al --color=always --group-directories-first $argv
        
end
