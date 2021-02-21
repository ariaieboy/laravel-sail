# laravel-sail
## Installation
1. you must install oh my zsh + git to use this plugin
2. after installing git and Oh My Zsh run command below
```
 git clone https://github.com/ariaieboy/laravel-sail ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/laravel-sail
```

3. now edit zsh config file located in ```~./zshrc```
4. add ```laravel-sail``` to your zsh config plugins 
5. start a new terminal session and use the aliases

## Usage

### General
| Alias | Description |
|:-:|:-:|
| `s`  |  `sail` |
| `sup`  |  `sail up` |
| `sud`  |  `sail up -d` |
| `sdown`  |  `sail down` |
|`sb`|`sail build`|

### artisan and Dependencies 
| Alias | Description |
|:-:|:-:|
| `sa`  |  `sail artisan` |
|`sp`|`sail php`|
|`sc`|`sail composer`|
|`sn`|`sail npm`|

### npm build commands
| Alias | Description |
|:-:|:-:|
|`swatch`|`sail npm run watch`|
|`sdev`|`sail npm run dev`|
|`sprod`|`sail npm run production`|

### Testing
| Alias | Description |
|:-:|:-:|
|`st`|`sail test`|
|`sdusk`|`sail dusk`|

### Others
| Alias | Description |
|:-:|:-:|
|`ss`|`sail shell`|
|`stinker`|`sail tinker`|
|`sshare`|`sail share`|