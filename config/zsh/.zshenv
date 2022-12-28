
# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# homebrew 
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# dotfiles
export DOTFILES=$HOME/dotfiles

# zsh_sessionsを作らない
export SHELL_SESSIONS_DISABLE=1

# ZDOTDIR
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# anaconda3
#export PATH=$PATH:$HOME/anaconda3/bin

export CONDARC=$XDG_CONFIG_HOME/conda/condarc

# flask
export FLASK_ENV=development
export FLASK_APP=api:app

# Go
export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOPATH/bin

# poetry
export PATH=$PATH:$HOME/.local/bin


# java tomcat
#export JAVA_HOME=$(/usr/libexec/java_home v 1.0)
#export PATH=$PATH:$JAVA_HOME/bin
#export PATH=/opt/homebrew/opt/tomcat@8/bin:$PATH
#export CATALINA_HOME=/opt/homebrew/opt/tomcat@8/libexec
#export CATALINA_OPTS='-Dfile.encoding=UTF-8'
#export CLASSPATH=$CATALINA_HOME/lib/servlet-api.jar
