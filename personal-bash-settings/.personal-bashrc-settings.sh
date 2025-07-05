### Pavel Soroka's settings
## Add to .bashrs line:
## source ~/.personal-bashrc-settings.sh

# PS1="\[\e]0; \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ (parse_git_branch)"
PS1="\[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

# export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$HOME/anaconda3/bin:$HOME/.local/bin:$PATH"

export EDITOR=gnome-text-editor

## --- Aliases ---------------------------------------------------------------
alias l="ls -1lh --group-directories-first --color=auto"
alias la="ls -1lah --group-directories-first --color=auto"
alias ls='ls --color=auto'
alias md=mkdir
alias cls=clear
alias dirsize='du -h --max-depth=1'
alias ds='du -hc --max-depth=1'
alias weather="curl -3 wttr.in/Kharkov"
alias mem="free -m"
alias hiber="systemctl suspend"
alias hyber="systemctl suspend"
alias ..="cd .."
alias ...="cd ../.."
alias na="nano -u"
alias p3=python3
alias ls='ls --color=auto'
alias tr="tree -I '__pycache__|tmp.*|node_modules|\.git|venv|env'"
alias pss='(echo "F S UID PID PPID C PRI NI ADDR SZ WCHAN TTY TIME CMD"; ps -el | grep 'pts/[12]' | grep -v grep) | column -t'
alias pi="ping example.com"

# Find the process listening on a specific port (replace PORT with the desired port number)
alias findport="sudo netstat -tuln | grep PORT"

alias greph="grep --color=auto"
alias grep='grep --color=auto'
alias hgrep="history | grep"
alias p3=python3
alias upd="sudo apt update; sudo apt upgrade"
alias dfh="df -h"
alias dps="docker ps"
alias clip="xsel --input --clipboard <"
alias von="source .venv/bin/activate"
alias voff="deactivate"
alias htmlinit='inithtml.sh'

alias cde="cd ~/Documents/English"


alias jup="conda activate; jupyter notebook"
alias ca='qalc'
alias q='qalc'
alias edit='gnome-text-editor'
alias gedit='gnome-text-editor'
alias alarm=~/scripts/inspire.sh
alias version='lsb_release -a'
alias ver='lsb_release -a'
alias ipy='ipython3'

# Net logging
alias here-gosprom='echo flat_gosprom > ~/.current_location; export MY_PLACE=$(cat ~/.location_tag 2>/dev/null)'
alias here-esenina='echo flat_esenina > ~/.current_location; export MY_PLACE=$(cat ~/.location_tag 2>/dev/null)'
alias here-kolomenskaya='echo flat_kolomenskaya > ~/.current_location; export MY_PLACE=$(cat ~/.location_tag 2>/dev/null)'
alias whereami='cat ~/.current_location'
alias netlog='cat -n ~/.local/share/netlog/speedtest_log.csv'
alias nettail='(head -n1 ~/.local/share/netlog/speedtest_log.csv && tail -n 10 ~/.local/share/netlog/speedtest_log.csv)'

## --- Docker aliases --------------------------------------------------------

# Список всех контейнеров (включая остановленные)
alias dpsa='docker ps -a'

# Список только запущенных контейнеров
alias dps='docker ps'

# Удалить все остановленные контейнеры
alias drm_all='docker container prune -f'

# Удалить конкретный контейнер по имени/ID
alias drm='docker rm'

# Останавливает запущенный контейнер, если он единственный
alias dstopone='bash ~/scripts/stop_the_only_running_docker_container.sh'

# Запустить контейнер'
alias drun='docker run'

# Остановить контейнер
alias dstop='docker stop'

# Остановить контейнер жёстко
alias dkill='docker kill'

# Список образов
alias dimages='docker images'

## --- Functions -------------------------------------------------------------
# Take notice also at custom commands
# bac: /usr/local/bin/bac

mdcd() {
   mkdir -p "$1" && cd "$1";
}

function gccexe() {
    gcc "$1" -o "$(basename "$1" .c).exe"
}

# alias bak='cp "$1" "$1".bak'

## --- git setup -------------------------------------------------------------
# git aliases
alias gh='git log --pretty=format:"%C(yellow)%h %C(white)%ad | %C(green)%s%d %C(white)[%an]" --graph --date=short'
alias gha='gh --all'
alias gl='git log --graph --all --pretty=format:"%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gla='gl --all'
alias gs='git status '
alias ga='git add '
alias gaa='git add .'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
# alias gcm='git checkout master'
alias gcm='if git show-ref --verify --quiet refs/heads/master; then git checkout master; elif git show-ref --verify --quiet refs/heads/main; then git checkout main; else echo "No master or main branch found"; fi'
alias grs='git restore'
alias gst='git stash'
alias gsp='git stash pop'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gp='git pull --rebase'
alias gamend='git commit --amend --no-edit'
alias got='git '    	# handling typos
alias get='git '    	# handling typos

parse_git_branch() {
 	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
