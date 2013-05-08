# vim: ft=zsh et
# Tips 
# http://www.rayninfo.co.uk/tips/zshtips.html

#=======================================
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="dunolie"

# Source after the  above 2 items
source $ZSH/oh-my-zsh.sh
#=======================================
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"
#ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=red,,bg=black')

#paths are coloured green
#ZSH_HIGHLIGHT_STYLES[path]='fg=green'


# To disable highlighting of globbing expressions
#ZSH_HIGHLIGHT_STYLES[globbing]='none'

# To differentiate aliases/functions from other command types
#ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
#ZSH_HIGHLIGHT_STYLES[function]='fg=magenta,bold'

#unknown are coloured yellow
#ZSH_HIGHLIGHT_STYLES[path]='fg=unknown-token'

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew vim last-working-dir github zsh-utilities)
#zstyle :omz:plugins:ssh-agent agent-forwarding on


#source $ZSH/custom/plugins/zsh-syntax-highlighting.zsh

#source $ZSH/custom/functions/functions.zsh




# Customize to your needs...
if [[ `uname` = "Darwin" ]]; then
	if [[ -f /usr/local/bin/gls ]]; then
		#export LS_OPTIONS='--color=auto'
		eval `/usr/local/bin/gdircolors ~/.dir_colors`
		#ls aliases for use with dircolors
		alias l='gls --color=auto -lAhF'
		alias l.='gls --color=auto -d .*'
		alias ls='gls --color=auto -hF'
		alias la='gls --color=auto -A'
		alias lf='gls --color=auto -Ff'
		alias ll='gls --color=auto -lhF'
		alias ld='gls --color=auto -daf'
		alias lll='gls --color=auto -all'
		alias lsd='gls --color=auto -d */'
		alias lss='gls --color=auto -Slh'                 #Size
		alias lst='gls --color=auto -altrhF'              #Time
		alias lsx='gls --color=auto -alh|sort'            #chmod
		alias lsf='gls --color=auto -lhF|grep -v /'       #Files
		alias lle='gls --color=auto -alhF| less'
		alias acl='/bin/ls -le' # View and validate the ACL modifications with the ls command
	else
		# http://www.infinitered.com/blog/?p=19
		#export LS_COLORS=gxgxcxdxbxegedabagacad
		#export LS_COLORS=cxfxcxdxBxegedabagacad
		# a black
		# b red
		# c green
		# d brown
		# e blue
		# f magenta
		# g cyan
		# h light grey
		# A bold black, usually shows up as dark grey
		# B bold red
		# C bold green
		# D bold brown, usually shows up as yellow
		# E bold blue
		# F bold magenta
		# G bold cyan
		# H bold light grey; looks like bright white
		# x default foreground or background
		# Order: dir - symlink - socket - pipe - exec - block special - char special - exec
		# setuid - exec setgid - public dir sticky bit - public dir no sticky bit
		export LSCOLORS=GxfxcxdxbxGgGdabagacad
		#ls aliases for use with OS X default colours
		alias l='ls -lAhF'
		alias l.='ls -d .*'
		alias ls='ls -CG'
		alias la='ls -A'
		alias lf='ls -Ff'
		alias ll='ls -af'
		alias ld='ls -daf'
		alias lll='ls -all'
		alias lsd='ls -d */'
		alias lss='ls -Slh'                          # Size
		alias lst='ls -altrhF'                       #Time
		alias lsx='ls -alh|sort'                     #chmod
		alias lsf='ls -lhF|grep -v /'                #Files
		alias lle='ls -alhF| less'
		alias acl='/bin/ls -le' # View and validate the ACL modifications with the ls command
	fi
fi

# -------------------------------------------------------------------------------
#                        GPG
# -------------------------------------------------------------------------------
#
if [[ $USER = "robbie" ]]; then
	export GPGKEYID="2249A56B"
fi
#
# -------------------------------------------------------------------------------
#                        GENERAL
# -------------------------------------------------------------------------------
#
umask 077
ulimit -c 0
#
# exclude resource forks when making tar|zip|gz files
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

# set UTF-8 encoding for pbcopy/pbpaste
export __CF_USER_TEXT_ENCODING=0x1F5:0x8000100:0x8000100
#
# prevent creation of the ._filename files when using tar
export COPYFILE_DISABLE=true
#

# -------------------------------------------------------------------------------
#                         AtomicParsley
# -------------------------------------------------------------------------------
# AtomicParsley options for mp4 art
export PIC_OPTIONS="MaxDimensions=500:DPI=72:MaxKBytes=150:AddBothPix=true:AllPixJPEG=true"
export PIC_OPTIONS="SquareUp:removeTempPix"
export PIC_OPTIONS="ForceHeight=999:ForceWidth=333:removeTempPix"
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
#git settings
# http://defunkt.io/hub/
if [[ -f /usr/local/bin/hub ]]; then
	alias git='/usr/local/bin/hub'
fi
# -------------------------------------------------------------------------------
#                        HISTORY
# -------------------------------------------------------------------------------
#
# my history settings
export HISTIGNORE="&:[ ]*:exit:ll:ls:bd:m:wr:soa:sof:sob:ea:eb:ebf:l:te:soar:soah:soax:"
export HISTSIZE=9999
export HISTFILESIZE=9999
# export HISTTIMEFORMAT="%s "
export HISTTIMEFORMAT='%a, %d %b %Y %l:%M:%S%p %z '
#
# --------------------------------------------------------------------------------
#                        TEXT EDIT
# --------------------------------------------------------------------------------
#
# Safe rm, cause sometimes things fuxor up (moves things to the trash insted of rm'ing)
# http://osxutils.sourceforge.net/http://osxutils.sourceforge.net/
if [[ `uname` = "Darwin" && -f /usr/local/bin/trash ]]; then
		alias rm='/usr/local/bin/trash'
	else
		alias rm='rm -i'
fi
#
#alias tclsh='/usr/bin/tclsh8.4'
#export TCLSH='/usr/bin/tclsh8.4'
#
#if [[ `uname` = "Darwin" ]]; then
#	export EDITOR='mate -w'
#else
#	export EDITOR='vim'
#fi

# vim aliases as I can't get it loaded in .vimrc :/
alias vim='vim -c "colorscheme xoria256"'
alias vi='vim -c "colorscheme xoria256"'
alias v='vim -c "colorscheme xoria256"'

export EDITOR="vim -c 'colorscheme xoria256'"
export GIT_EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-erX"
#export LESS="-e -i -M -R -X -F -S"
export LESSCHARSET="UTF-8"
#
# original version of vim man page viewer
# export MANPAGER='col -bx | vim -c ":set ft=man nonu nolist" -R -'
#
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

#Set my Default Browser
export BROWSER="open -a FireFox.app"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH            #brews
export PATH=${PATH}:~/bin:~/pbin                            #mine
export PATH=${PATH}:/bin:/sbin:/usr/sbin:/usr/bin           #system
export PATH=${PATH}:/usr/X11/bin:/opt/X11/bin               #x11
export PATH=${PATH}:/usr/games:/usr/share/games             #games
export PATH=${PATH}:/Developer/usr/bin:/Developer/usr/sbin  #dev
export PATH=$PATH}:/usr/local/mysql/bin                      #mysql (osx)
#
#export PATH=$PATH:/System/library/Frameworks/Ruby.framework/Versions/1.8/usr/bin
#export PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin
#export PATH=$PATH:/System/Library/Frameworks/Python.framework/Versions/Current/bin

#
# For non-root users, add the current directory to the search path:
if [ ! "`id -u`" = "0" ]; then
 PATH="$PATH:."
fi
#
# my manual (man pages) paths
export MANPATH=/usr/local/share/man:$MANPATH
export MANPATH=${MANPATH}/opt/X11/share/man:/usr/local/man:/usr/share/man
export MANPATH=${MANPATH}/Developer/usr/share/man:/Developer/usr/X11/man:/usr/X11/man:~/Sync/Bash/man
#

#export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
# perl paths
export ARCHFLAGS="-arch i386 -arch x86_64"
export VERSIONER_PERL_PREFER_32_BIT=no
# OSX Default perl paths. installed via sudo 
export PERL5LIB="/System/Library/Perl/5.12:/System/Library/Perl/5.10:/Library/Perl/5.12"
# My perl paths installed via homebrew
#export PERL5LIB="/Users/robbie/perl5/lib/perl5"
#
# Ruby Version manager  # get errors on loading
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Completion
load_completion() {
    # http://www.reddit.com/r/commandline/comments/kbeoe/you_can_make_readline_and_bash_much_more_user/
    # https://wiki.archlinux.org/index.php/Zsh
    autoload -U compinit
    fpath=($* $fpath)
    fignore=(.DS_Store $fignore)
    compinit -i
    zmodload -i zsh/complist
    setopt complete_in_word
    setopt auto_remove_slash
    unsetopt always_to_end
    has_brew && compctl -K _gimme gimme
    [[ -f ~/.ssh/known_hosts ]] && hosts=(`awk '{print $1}' ~/.ssh/known_hosts | tr ',' '\n' `)
    [[ -f ~/.ssh/config ]] && hosts=($hosts `grep '^Host' ~/.ssh/config | sed s/Host\ // | egrep -v '^\*$'`)
    zstyle ':completion:*' insert-tab pending
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    #highlights='${PREFIX:+=(#bi)($PREFIX:t)(?)*==31=1;32}':${(s.:.)LS_COLORS}}
    #highlights2='=(#bi) #([0-9]#) #([^ ]#) #([^ ]#) ##*($PREFIX)*==1;31=1;35=1;33=1;32=}'
    #zstyle -e ':completion:*' list-colors 'if [[ $words[1] != kill && $words[1] != strace ]]; then reply=( "'$highlights'" ); else reply=( "'$highlights2'" ); fi'
    ##unset highlights
	# For autocompletion with an arrow-key driven interface
	zstyle ':completion:*' menu select
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*' squeeze-slashes true
	zstyle ':completion:*' expand 'yes'
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:approximate:*' max-errors 1 numeric
    zstyle ':completion:*:hosts' hosts $hosts
    zstyle ':completion::complete:*' use-cache 1
    zstyle ':completion::complete:*' cache-path ./cache/
    zstyle ':completion:*:cd:*' ignore-parents parent pwd
	zstyle ':completion:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
    zstyle ':completion:*:ogg123:*' file-patterns '*.(ogg|OGG):ogg\ files *(-/):directories'
    zstyle ':completion:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
    zstyle ':completion:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
}
setopt completealiases
# colors on tab complete, untill I get a handle on zsh/complist
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=40}:${(s.:.)LS_COLORS}")';
export ZLS_COLORS=$LS_COLORS

# Settings
autoload colors; colors;
load_defaults() {
    setopt auto_name_dirs
    setopt pushd_ignore_dups
    setopt prompt_subst
    setopt no_beep
    setopt auto_cd
    setopt multios
    setopt cdablevarS
    setopt transient_rprompt
    setopt extended_glob
    autoload -U url-quote-magic
    zle -N self-insert url-quote-magic
    autoload -U zmv
    bindkey "^[m" copy-prev-shell-word
    HISTFILE=$HOME/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt hist_ignore_dups
    setopt hist_reduce_blanks
    setopt share_history
    setopt append_history
    setopt hist_verify
    setopt inc_append_history
    setopt extended_history
    setopt hist_expire_dups_first
    setopt hist_ignore_space
    bindkey "${key[Up]}" history-search-backward
    bindkey "${key[Down]}" history-search-forward
}
# bash completion settings (actually, these are readline settings)
#bindkey "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
#bindkey "set bell-style none"
#bindkey "set show-all-if-ambiguous on"
#bindkey Space:magic-space

#bindkey '"\C-t": possible-completions' # replaces 'transpose-chars'
#bindkey '"\M-t": menu-complete'        # replaces 'transpose-words'
# https://coderwall.com/p/a8uxma
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

#alias rvm-prompt=$HOME/.rvm/bin/rvm-prompt
#source ~/.zshrc

#source $ZSH/oh-my-zsh.sh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#  dpoggi  gianu  pygmalion  crunch
#==================================================

#source ~/.functions

source  ~/.aliases_bash
source ~/.aliases_bash_osx
source ~/.aliases_bash_robbie
source /usr/local/bin/z.sh
source ~/.zprofile
# from brew, for colorized output.
source "`brew --prefix`/etc/grc.bashrc"
# from brew 
fpath=(/usr/local/share/zsh-completions $fpath)
