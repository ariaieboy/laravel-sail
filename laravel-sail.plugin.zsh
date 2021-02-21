s() {
  if [ test -f "./vendor/bin/sail" ]; then
        bash ./vendor/bin/sail
      else
        echo "sail is not installed"
  fi
}
# alias s='bash ./vendor/bin/sail'
alias sup='s up'
alias sud='s up -d'
alias sdown='s down'
alias sa='s artisan'
alias sp='s php'
alias sc='s composer'
alias sn='s npm'
alias swatch='s npm run watch'
alias sprod='s npm run production'
alias sdev='s npm run dev'
alias st='s test'
alias sdusk='s dusk'
alias ss='s shell'
alias stinker='s tinker'
alias sb='s build'
alias sshare='s share'
