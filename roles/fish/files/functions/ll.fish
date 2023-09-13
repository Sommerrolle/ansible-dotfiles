function ll --wraps=ls --wraps='=exa -al' --wraps='exa -al' --description 'alias ll=exa -al'
  exa -al $argv
        
end
