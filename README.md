# laravel-sail
![Ariaieboy Laravel-Sail](https://preview.dragon-code.pro/Ariaieboy/Laravel-Sail.svg)
This plugin adds some useful aliases for sail commands to the zsh shell.

* It will auto-discover sail executable and you can run its aliases from any Project Directory.
* It provides auto-completion for `artisan` and `composer` commands when you use sail.
* It also have `s cinit` alias for installing composer Dependencies and `s ninit` for installing npm Dependencies on your project, when sail is not installed.

## Installation
1. you must install oh my zsh + git to use this plugin
2. after installing git and Oh My Zsh run command below
```
 git clone --depth=1 https://github.com/ariaieboy/laravel-sail ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/laravel-sail
```

3. now edit zsh config file located in ```~/.zshrc```
4. add ```laravel-sail``` to your zsh config plugins 
5. start a new terminal session and use the aliases

## Usage

### Pre Sail Installation Commands
| Alias |                                           Description                                            |
|:-:|:------------------------------------------------------------------------------------------------:|
| `s cinit 80` | run `composer install --ignore-platform-reqs` using php version 8.0 - default php version is 8.3 |
| `s ninit 16` |                   run `npm install` using node 16 - default node version is 20                   |

### General
| Alias | Description |
|:-:|:-:|
| `s`  |  `sail` |
| `sup`  |  `sail up` |
| `sud`  |  `sail up -d` |
| `sdown`  |  `sail down` |
|`sb`|`sail build`|
|`sbn`|`sail build --no-cache`|

### General Artisan Commands
| Alias | Description |
|:-:|:-:|
| `saqw`  |  `sail artisan queue:work` |
| `saql`  |  `sail artisan queue:listen` |
| `sasw`  |  `sail artisan schedule:work` |
| `sasr`  |  `sail artisan schedule:run` |

### artisan and Dependencies 
| Alias | Description |
|:-:|:-:|
| `sa`  |  `sail artisan` |
|`sp`|`sail php`|
|`sc`|`sail composer`|
|`sn`|`sail npm`|
|`spn`|`sail pnpm`|
|`sbun`|`sail bun`|
|`sbunx`|`sail bunx`|
|`sy`|`sail yarn`|

### npm build commands
| Alias | Description |
|:-:|:-:|
|`swatch`|`sail npm run watch`|
|`sdev`|`sail npm run dev`|
|`sbuild`|`sail npm run build`|
|`sprod`|`sail npm run production`|


### Testing
| Alias | Description |
|:-:|:-:|
|`st`|`sail test`|
|`stp`|`sail test --parallel`|
|`sdusk`|`sail dusk`|
|`stan`|`./vendor/bin/phpstan`|
|`spint`|`./vendor/bin/pint`|
|`spest`|`./vendor/bin/pest`|

### Others
| Alias | Description |
|:-:|:-:|
|`ss`|`sail shell`|
|`sroot`|`sail root-shell`|
|`stinker`|`sail tinker`|
|`sshare`|`sail share`|
