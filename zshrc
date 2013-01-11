# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(mercurial git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

if [ -d "/usr/local/go/bin" ] ; then
  PATH=$PATH:/usr/local/go/bin
fi

### Solarized dircolors for ls --color=always
eval `dircolors ~/dotfiles/dircolors-solarized/dircolors.256dark`

### Aliases and Functions
alias tmux="tmux -2" # 256color support
alias lsa='ls -lah'
alias l='ls -lA1h'
alias ll='ls -lh'
alias la='ls -lAh'

if [ "$PS1" != "" -a "${STARTED_TMUX:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
  tmux_session='wolf'
  STARTED_TMUX=1; export STARTED_TMUX
  sleep 1
  ( (tmux has-session -t $tmux_session && tmux attach-session -t $tmux_session) || (tmux new-session -s $tmux_session) ) && exit 0

  echo "tmux failed to start"
fi
