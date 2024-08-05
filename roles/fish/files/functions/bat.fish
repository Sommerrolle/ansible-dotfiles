function bat --wraps=batcat --wraps='batcat -pp' --description 'alias bat=batcat -pp'
  batcat -pp $argv; 
end
