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

welcome() {
    #------------------------------------------
    #------WELCOME MESSAGE---------------------
    # customize this first message with a message of your choice.
    # this will display the username, date, time, a calendar, the amount of users, and the up time.
    #clear
    # Gotta love ASCII art with figlet
    figlet "Welcome, " $USER;
    #toilet "Welcome, " $USER;
    echo -e ""; cal ;
    echo -ne "Today is "; date #date +"Today is %A %D, and it is now %R"
    echo -e ""
    echo -ne "Up time:";uptime | awk /'up/'
    #echo -en "Local IP Address :"; /sbin/ifconfig wlan0 | awk /'inet addr/ {print $2}' | sed -e s/addr:/' '/ 
    echo "";
}
welcome;

# get IP adresses
#function my_ip() # get IP adresses
#my_ip () {
#        MY_IP=$(/sbin/ifconfig wlan0 | awk "/inet/ { print $2 } " | sed -e s/addr://)
#                #/sbin/ifconfig | awk /'inet addr/ {print $2}'
#        MY_ISP=$(/sbin/ifconfig wlan0 | awk "/P-t-P/ { print $3 } " | sed -e s/P-t-P://)
#}
# get current host related info
ii () {
    echo -e "\nYou are logged on ${red}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${red}Users logged on:$NC " ; w -h
    echo -e "\n${red}Current date :$NC " ; date
    echo -e "\n${red}Machine stats :$NC " ; uptime
    echo -e "\n${red}Memory stats :$NC " ; free
    echo -en "\n${red}Local IP Address :$NC" ; /sbin/ifconfig wlan0 | awk /'inet addr/ {print $2}' | sed -e s/addr:/' '/
    #my_ip 2>&. ;
    #my_ip 2>&1 ;
    #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:."Not connected"}
    #echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:."Not connected"}
    #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP} #:."Not connected"}
    #echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP} #:."Not connected"}
    echo
}
# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
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
