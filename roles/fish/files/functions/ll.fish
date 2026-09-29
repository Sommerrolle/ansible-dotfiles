function ll --wraps=ls --wraps='=eza -al' --wraps='eza -al' --description 'alias ll=eza -al'
  eza -al $argv
        
end
