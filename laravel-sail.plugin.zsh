export APP_SERVICE=${APP_SERVICE:-"laravel.test"}
function _find_sail() {
  local dir=.
  until [ $dir -ef / ]; do
    if [ -f "$dir/sail" ]; then
      echo "$dir/sail"
      return 0
    elif [ -f "$dir/vendor/bin/sail" ]; then
      echo "$dir/vendor/bin/sail"
      return 0
    fi
    dir+=/..
  done
  return 1
}
function s() {
  local sail_path
  sail_path=$(_find_sail)

  if [[ $1 == "cinit" ]]; then
    docker run --rm \
      -u "$(id -u):$(id -g)" \
      -v $(pwd):/var/www/html \
      -w /var/www/html \
      laravelsail/php"${2:=82}"-composer:latest \
      composer install --ignore-platform-reqs
  elif [[ $1 == "ninit" ]]; then
    docker run --rm \
      -u "$(id -u):$(id -g)" \
      -v $(pwd):/var/www/html \
      -w /var/www/html \
      node:${2:=20} \
      npm install
  else
    if [ "$sail_path" = "" ]; then
        >&2 printf "laravel-sail: sail executable not found. Are you in a Laravel directory?\nif yes try install Dependencies using 's cinit' command\n"
        return 1
    fi
    $sail_path $*
  fi
}
function sa() {
  s artisan $*
}
function sc() {
  s composer $*
}
# alias s='bash ./vendor/bin/sail'
alias sup='s up'
alias sud='s up -d'
alias sdown='s down'
alias saqw='s artisan queue:work'
alias saql='s artisan queue:listen'
alias sasw='s artisan schedule:work'
alias sasr='s artisan schedule:run'
alias sp='s php'
alias sn='s npm'
alias spn='s exec -u sail $APP_SERVICE pnpm'
alias sy='s yarn'
alias swatch='s npm run watch'
alias sprod='s npm run production'
alias sdev='s npm run dev'
alias sbuild='s npm run build'
alias st='s test'
alias stp='s test --parallel'
alias sdusk='s dusk'
alias ss='s shell'
alias sroot='s root-shell'
alias stinker='s tinker'
alias sb='s build'
alias sbn='s build --no-cache'
alias sshare='s share'
alias stan='sp ./vendor/bin/phpstan'
alias spint='sp ./vendor/bin/pint'
alias spest='sp ./vendor/bin/pest'
compdef _artisan sa
compdef _composer sc
function _artisan() {
  if [ -f "./vendor/bin/sail" ]; then
    compadd $(sa --raw --no-ansi list | sed "s/[[:space:]].*//g")
  fi
}
function _composer() {
  if [ -f "./vendor/bin/sail" ]; then
    compadd $(sc --raw --no-ansi list | sed "s/[[:space:]].*//g")
  fi
}
