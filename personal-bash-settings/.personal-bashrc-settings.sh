### -----------------------------
### PROMPT
### -----------------------------
# Git branch in prompt
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# PS1
PS1="\[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

### -----------------------------
### PATH
### -----------------------------
export PATH="$HOME/scripts:$HOME/anaconda3/bin:$HOME/.local/bin:$PATH"

### -----------------------------
### EDITOR
### -----------------------------
export EDITOR=gnome-text-editor

### -----------------------------
### COMMON ALIASES
### -----------------------------
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
alias tr="tree -I '__pycache__|tmp.*|node_modules|\.git|venv|env'"
alias pss='(echo "F S UID PID PPID C PRI NI ADDR SZ WCHAN TTY TIME CMD"; ps -el | grep "pts/[12]" | grep -v grep) | column -t'
alias pi="ping example.com"
alias ports='ss -tulpn'
alias greph="grep --color=auto"
alias grep='grep --color=auto'
alias hgrep="history | grep"
alias upd="sudo apt update && sudo apt upgrade"
alias dfh="df -h"
alias clip="xsel --input --clipboard <"

### -----------------------------
### VIRTUAL ENVIRONMENTS
### -----------------------------
alias von='[ -d .venv ] && source .venv/bin/activate || echo ".venv not found"'
alias voff='command -v deactivate >/dev/null && deactivate || echo "No venv active"'
alias vmake='python3 -m venv .venv && echo "Virtual env created in .venv"'

### -----------------------------
### HTML / PROJECT
### -----------------------------
alias htmlinit='inithtml.sh'

### -----------------------------
### DIRECTORIES
### -----------------------------
alias cde="cd ~/Documents/English"

### -----------------------------
### JUPYTER / CONDA
### -----------------------------
alias jup="conda activate && jupyter notebook"

### -----------------------------
### CALCULATOR
### -----------------------------
alias ca='qalc'
alias q='qalc'

### -----------------------------
### EDITORS
### -----------------------------
alias edit='gnome-text-editor'
alias gedit='gnome-text-editor'
alias ipy='ipython3'

### -----------------------------
### PRETTIER / CODE
### -----------------------------
alias pretty='prettier -write .'

### -----------------------------
### ALARM
### -----------------------------
alias alarm=~/scripts/inspire.sh

### -----------------------------
### SYSTEM INFO
### -----------------------------
alias version='lsb_release -a'
alias ver='lsb_release -a'

### -----------------------------
### NET LOGGING / LOCATION
### -----------------------------
alias here-gosprom='echo flat_gosprom > ~/.current_location; export MY_PLACE=$(cat ~/.location_tag 2>/dev/null)'
alias here-esenina='echo flat_esenina > ~/.current_location; export MY_PLACE=$(cat ~/.location_tag 2>/dev/null)'
alias here-kolomenskaya='echo flat_kolomenskaya > ~/.current_location; export MY_PLACE=$(cat ~/.location_tag 2>/dev/null)'
alias whereami='cat ~/.current_location'
alias netlog='cat -n ~/.local/share/netlog/speedtest_log.csv'
alias nettail='(head -n1 ~/.local/share/netlog/speedtest_log.csv && tail -n 10 ~/.local/share/netlog/speedtest_log.csv)'

### -----------------------------
### DOCKER ALIASES
### -----------------------------
alias dstatus="docker ps -a && docker images"
alias dpsa='docker ps -a'
alias dps='docker ps'
alias drmall='docker container prune -f'
alias drm='docker rm'
alias dstopall="docker stop $(docker ps -q)"
alias drun='docker run'
alias dstop='docker stop'
alias dstart='docker start'
alias dkill='docker kill'
alias dimages='docker images'

### -----------------------------
### FUNCTIONS
### -----------------------------
mdcd() {
   mkdir -p "$1" && cd "$1";
}

gccexe() {
    gcc "$1" -o "$(basename "$1" .c).exe"
}

port() {
    if [ -z "$1" ]; then
        echo "Usage: port <number>"
    else
        ss -tulpn | grep ":$1"
    fi
}

### -----------------------------
### GIT ALIASES
### -----------------------------
alias gh='git log --pretty=format:"%C(yellow)%h %C(white)%ad | %C(green)%s%d %C(white)[%an]" --graph --date=short'
alias gh1='gh -1'
alias gh3='gh -3'
alias gh5='gh -5'
alias gha='gh --all'
alias gl='git log --graph --all --pretty=format:"%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gl1='gl -1'
alias gl3='gl -3'
alias gl5='gl -5'
alias gla='gl --all'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gcm='if git show-ref --verify --quiet refs/heads/master; then git checkout master; elif git show-ref --verify --quiet refs/heads/main; then git checkout main; else echo "No master or main branch found"; fi'
alias grs='git restore'
alias gst='git stash'
alias gsp='git stash pop'
alias gk='gitk --all &'
alias gx='gitx --all'
alias gp='git pull --rebase'
alias gamend='git commit --amend --no-edit'
alias got='git'     # handling typos
alias get='git'     # handling typos
