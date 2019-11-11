# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
#
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
#
# setopt XTRACE

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/cameron/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# zsh_theme="robbyrussell"
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ] ; then
  ZSH_THEME=powerlevel10k/powerlevel10k
else
  echo '*** Install PL10K with "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k"'
  ZSH_THEME="robbyrussell"
fi

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Set fzf installation directory path
# export FZF_BASE=/usr/share/fzf

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
[[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]] && echo '*** Install zsh-syntax-highlighting with "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"'

[[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]] && echo '*** Install zsh-syntax-highlighting with "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"'

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  kube-ps1
  minikube
  helm
  kubectl
)

source $ZSH/oh-my-zsh.sh

# You can customize your prompt by editing ~/.p10k.zsh.
# To run Powerlevel10k configuration wizard, type 'p9k_configure'.
source ~/.p10k.zsh

# source in the vte settings for tilix to work
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# stop minikube checking for updates
export MINIKUBE_WANTUPDATENOTIFICATION=false

# add nvim as editor, if installed
if [ -e "$(which nvim)" ] ; then
  export EDITOR="$(which nvim)"
fi

alias mydotfiles='git --git-dir=$HOME/.my-dotfiles/ --work-tree=$HOME'
alias mdf='mydotfiles'

export MINIKUBE_HOME="/data/cameron"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# configure NPM to use locally install globals
if [ -d "$HOME/.npm-packages/bin" ] ; then
    NPM_PACKAGES="${HOME}/.npm-packages"
    PATH="$NPM_PACKAGES/bin:$PATH"
    
    # Unset manpath so we can inherit from /etc/manpath via the `manpath` command
    unset MANPATH # delete if you already modified MANPATH elsewhere in your config
    export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
fi

# # set PATH so it includes global yarn binaries if it exists
# if [ -d "$HOME/.yarn/bin" ] ; then
#     PATH="$HOME/.yarn/bin:$PATH"
# fi

# set PATH so it includes adr tools if it exists
if [ -d "$HOME/.local/adr-tools-2.1.0/src" ] ; then
    PATH="$HOME/.local/adr-tools-2.1.0/src:$PATH"
fi

# java config
if [ -d "/usr/lib/jvm/java-openjdk" ]; then
  export JAVA_HOME=/usr/lib/jvm/java-openjdk
  PATH="$JAVA_HOME/bin;$PATH"
fi


# android config
export ANDROID_SDK_ROOT=/data/cameron/applications/Android/Sdk
if [ -d "$ANDROID_SDK_ROOT" ] ; then
    PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
    PATH="$ANDROID_SDK_ROOT/tools:$PATH"
    PATH="$ANDROID_SDK_ROOT/tools/bin$PATH"
    PATH="$ANDROID_SDK_ROOT/emulator:$PATH"
    # PATH="$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH"
fi

# # shift the android AVD home off to the data drive (they are mostly nothing but large disk images)
# export ANDROID_EMULATOR_HOME=/data/cameron/applications/.android/
# export ANDROID_AVD_HOME=/data/cameron/applications/.android/avd/

if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi

eval $(thefuck --alias) # enable thefuck properly



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/cameron/.sdkman"
[[ -s "/home/cameron/.sdkman/bin/sdkman-init.sh" ]] && source "/home/cameron/.sdkman/bin/sdkman-init.sh"

# unsetopt XTRACE
# exec 2>&3 3>&-
