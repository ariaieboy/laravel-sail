function s() {
    if [[ $1 == "cinit" ]]; then
        docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v $(pwd):/var/www/html \
    -w /var/www/html \
    laravelsail/php${2:=81}-composer:latest \
    composer install --ignore-platform-reqs
    elif [[ $1 == "ninit" ]]; then
        docker run --rm \
        -u "$(id -u):$(id -g)" \
        -v $(pwd):/var/www/html \
        -w /var/www/html \
        node:${2:=17} \
        npm install
    else
        bash ./vendor/bin/sail $*
    fi
}
# alias s='bash ./vendor/bin/sail'
alias sup='s up'
alias sud='s up -d'
alias sdown='s down'
alias sa='s artisan'
alias saqw='s artisan queue:work'
alias saql='s artisan queue:listen'
alias sasw='s artisan schedule:work'
alias sasr='s artisan schedule:run'
alias sp='s php'
alias sc='s composer'
alias sn='s npm'
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
