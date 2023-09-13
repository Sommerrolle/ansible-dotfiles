function glog --wraps='git log --graph --decorate --oneline' --description 'alias glog=git log --graph --decorate --oneline'
  git log --graph --decorate --oneline $argv
        
end
