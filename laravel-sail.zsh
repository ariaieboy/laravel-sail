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
      laravelsail/php"${2:=83}"-composer:latest \
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
      if [ $ZSH_SAIL_FALLBACK_TO_LOCAL = "true" ]; then
        $*
      else
        >&2 printf "laravel-sail: sail executable not found. Are you in a Laravel directory?\nif yes try install Dependencies using 's cinit' command\n"
        return 1
      fi
    fi
    $sail_path $*
  fi
}

function sail() {
  s $*
}

function sa() {
  s artisan $*
}

function sc() {
  s composer $*
}

# Aliases
alias sup='s up'
alias sud='s up -d'
alias sdown='s down'
alias saqw='s artisan queue:work'
alias saql='s artisan queue:listen'
alias sasw='s artisan schedule:work'
alias sasr='s artisan schedule:run'
alias sp='s php'
alias sn='s npm'
alias sbun='s bun'
alias sbunx='s bunx'
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

# Main completion function for s/sail
function _sail() {
  local -a commands
  if [[ CURRENT -eq 2 ]]; then
    # First argument: list top-level sail commands
    if [ -f "./vendor/bin/sail" ]; then
      # Get sail commands dynamically - try different approaches
      commands=("${(@f)$(s 2>&1 | grep -E 'sail' | awk '{print $2}' | sort -u)}")
      if [[ ${#commands[@]} -eq 0 ]]; then
        # Fallback: try without arguments to get help
        commands=("${(@f)$(s help 2>/dev/null | grep -E '^    [a-z]' | awk '{print $1}' | sort -u)}")
      fi
      if [[ ${#commands[@]} -eq 0 ]]; then
        # Another fallback: parse from sail script itself
        commands=("${(@f)$(grep -E '^[[:space:]]*"[a-z-]+"' ./vendor/bin/sail 2>/dev/null | sed 's/.*"\([^"]*\)".*/\1/' | sort -u)}")
      fi
      compadd -a commands
    fi
  elif [[ CURRENT -eq 3 ]]; then
    # Second argument, depending on first
    case ${words[2]} in
      artisan)
        if [ -f "./vendor/bin/sail" ]; then
          commands=("${(@f)$(sa list 2>/dev/null | grep -E '^  [a-z]' | awk '{print $1}' | sort -u)}")
          compadd -a commands
        fi
        ;;
      composer)
        if [ -f "./vendor/bin/sail" ]; then
          commands=("${(@f)$(sc list 2>/dev/null | grep -E '^  [a-z]' | awk '{print $1}' | sort -u)}")
          compadd -a commands
        fi
        ;;
    esac
  elif [[ CURRENT -gt 3 ]]; then
    # Third layer: options for specific commands
    case ${words[2]} in
      artisan)
        if [[ ${words[3]} != "" ]] && [ -f "./vendor/bin/sail" ]; then
          local options=("${(@f)$(sa ${words[2]} --help 2>/dev/null | grep -E '^[[:space:]]*--[a-zA-Z]' | sed 's/[[:space:]]*\(--[a-zA-Z-]*\).*/\1/' | sort -u)}")
          if [[ ${#options[@]} -gt 0 ]]; then
            compadd -a options
          fi
        fi
        ;;
      composer)
        if [[ ${words[3]} != "" ]] && [ -f "./vendor/bin/sail" ]; then
          local options=("${(@f)$(sc ${words[3]} --help 2>/dev/null | grep -E '^[[:space:]]*--[a-zA-Z]' | sed 's/[[:space:]]*\(--[a-zA-Z-]*\).*/\1/' | sort -u)}")
          if [[ ${#options[@]} -gt 0 ]]; then
            compadd -a options
          fi
        fi
        ;;
    esac
  fi
}

# Completion function for sa (sail artisan)
function _sa() {
  local -a commands
  if [[ CURRENT -eq 2 ]]; then
    if [ -f "./vendor/bin/sail" ]; then
      commands=("${(@f)$(sa list 2>/dev/null | grep -E '^  [a-z]' | awk '{print $1}' | sort -u)}")
      compadd -a commands
    fi
  elif [[ CURRENT -gt 2 ]]; then
    if [[ ${words[2]} != "" ]] && [ -f "./vendor/bin/sail" ]; then
      local options=("${(@f)$(sa ${words[2]} --help 2>/dev/null | grep -E '^[[:space:]]*--[a-zA-Z]' | sed 's/[[:space:]]*\(--[a-zA-Z-]*\).*/\1/' | sort -u)}")
      if [[ ${#options[@]} -gt 0 ]]; then
        compadd -a options
      fi
    fi
  fi
}

# Completion function for sc (sail composer)
function _sc() {
  local -a commands
  if [[ CURRENT -eq 2 ]]; then
    if [ -f "./vendor/bin/sail" ]; then
      commands=("${(@f)$(sc list 2>/dev/null | grep -E '^  [a-z]' | awk '{print $1}' | sort -u)}")
      compadd -a commands
    fi
  elif [[ CURRENT -gt 2 ]]; then
    if [[ ${words[2]} != "" ]] && [ -f "./vendor/bin/sail" ]; then
      local options=("${(@f)$(sc ${words[2]} --help 2>/dev/null | grep -E '^[[:space:]]*--[a-zA-Z]' | sed 's/[[:space:]]*\(--[a-zA-Z-]*\).*/\1/' | sort -u)}")
      if [[ ${#options[@]} -gt 0 ]]; then
        compadd -a options
      fi
    fi
  fi
}

# Register completions
compdef _sail s
compdef _sail sail
compdef _sa sa
compdef _sc sc
