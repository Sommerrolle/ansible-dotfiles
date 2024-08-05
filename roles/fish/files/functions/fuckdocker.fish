function fuckdocker --wraps='docker container stop (docker ps -a -q) && docker container rm (docker ps -a -q)' --description 'alias fuckdocker=docker container stop (docker ps -a -q) && docker container rm (docker ps -a -q)'
  docker container stop (docker ps -a -q) -t=0 && docker container rm (docker ps -a -q) $argv; 
end
