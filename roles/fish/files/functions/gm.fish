function gm --wraps='git commit' --wraps='git commit -m' --description 'alias gm=git commit -m'
  git commit -m $argv
        
end
