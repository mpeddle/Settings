alias ll='ls -alt'
alias ge='grep -r '$1' . | grep -v test | grep -v migration'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


###---------------------------------------------------------------------------
### FUNCTIONS
###---------------------------------------------------------------------------

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function findpid {
    ps aux | grep $1 | awk '{print $2}'
}

function killmatch {
    pid=$1; shift
    findpid $pid | xargs kill "$@"
}

###---------------------------------------------------------------------------
### ALIASES
###---------------------------------------------------------------------------

alias sudo='sudo '     # allows you to pass aliases to sudo
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# navigation aliases
alias ..='cd ..'              # change to the parent directory
alias ...='cd ../..'          # change to the grandparent directory
alias -- -="cd -"             # go to previous dir
#alias ls='ls --color=auto -p' # add color
alias l.='ls -d .*'           # list hidden files
alias ll='ls -lahrt'          # shortcut for ls with extra info
alias lld='ls -lUd */'        # list directories only

# Git Aliases
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gd='git diff | vi'
alias gf='git fetch'
alias gl='git log --decorate --graph --date-order'
alias gll='git log --oneline --graph --decorate --left-right --boundary --date-order'
alias gp='git push'
alias gpl='git pull'
alias gr='git remote -v'
alias gs='git status'
alias gu='git up'

# system monitoring
#alias topcpu='ps aux | sort -n -k 2 | tail -10' # top 10 cpu processes
alias topcpu='top -o cpu'
alias topmem='ps aux | sort -b -k 4 | tail'
alias ispy='lsof -i | grep -E "(LISTEN|ESTABLISHED)"'
alias dush='du -sm * | sort -n | tail' # find megabyte eating files/directories
alias usingnet='lsof -P -i -n' # show all apps using the internet at the moment

###---------------------------------------------------------------------------
### Env
###---------------------------------------------------------------------------

# colorize Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

#source /home/mpeddle/.git_config_complete

# add color to the terminal
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # assumes black background
export CLICOLOR=1
export PS1='\W \u$ '

#xterm colors for vim
export TERM="xterm-256color"

# replace diff w/ colorizediff
#alias diff="colordiff"

# History configuration
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=erasedups

source ~/git-complete.bash
source ~/.profile
export GOPATH=$HOME/go
export GOROOT=/usr/local/go/bin/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/sbin 
