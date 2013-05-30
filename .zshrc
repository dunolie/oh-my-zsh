# vim : filetype=zsh
# File: .zshrc
# Author: dunolie ~ dunolie @ gmail * com
# Description: my ~/.zshrc
# Last Modified: Fri May 10, 2013  03:16am
# link: https://github.com/robbyrussell/oh-my-zsh
#
# Tips & Info
# http://www.rayninfo.co.uk/tips/zshtips.html

E_WHITE='\[\033[1;37m\]'
E_BLACK='\[\033[0;30m\]'
E_BLUE='\[\033[0;34m\]'
E_L_BLUE='\[\033[1;34m\]'
E_GREEN='\[\033[0;32m\]'
E_L_GREEN='\[\033[1;32m\]'
E_CYAN='\[\033[0;36m\]'
E_L_CYAN='\[\033[1;36m\]'
E_RED='\[\033[0;31m\]'
E_L_RED='\[\033[1;31m\]'
E_PURPLE='\[\033[0;35m\]'
E_L_PURPLE='\[\033[1;35m\]'
E_YELLOW='\[\033[1;33m\]'
E_L_YELLOW='\[\033[0;33m\]'
E_GRAY='\[\033[1;30m\]'
E_L_GRAY='\[\033[0;37m\]'
E_NC='\[\033[0m\]'
#
# colours for use in scripts and notices
export NC='\033[0m' # No Color
export WHITE='\033[1;37m'
export BLACK='\033[0;30m'
export BLUE='\033[0;34m'
export L_BLUE='\033[1;34m'
export GREEN='\033[0;32m'
export L_GREEN='\033[1;32m'
export CYAN='\033[0;36m'
export L_CYAN='\033[1;36m'
export RED='\033[0;31m'
export L_RED='\033[1;31m'
export PURPLE='\033[0;35m'
export L_PURPLE='\033[1;35m'
export YELLOW='\033[1;33m'
export L_YELLOW='\033[0;33m'
export GRAY='\033[1;30m'
export L_GRAY='\033[0;37m'
#=======================================
#alias rvm-prompt=$HOME/.rvm/bin/rvm-prompt
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
#ZSH_HIGHLIGHT_STYLES[etopt correct lias]='fg=magenta,bold'
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
plugins=(vi-mode ruby git brew vim github zsh-utilities comlpeat)
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

export PATH=/usr/local/bin:/usr/local/sbin:$PATH            #brews & osx
export PATH=${PATH}:~/bin:~/pbin                            #mine
export PATH=${PATH}:/bin:/sbin:/usr/sbin:/usr/bin           #system
export PATH=${PATH}:/usr/X11/bin:/opt/X11/bin               #x11
export PATH=${PATH}:/usr/games:/usr/share/games             #games
export PATH=${PATH}:/Developer/usr/bin:/Developer/usr/sbin  #dev
export PATH=${PATH}:/usr/local/mysql/bin                    #mysql (osx)
#export PATH=${PATH}:~/.rmv/bin:~/.rvm/scripts               #ruby
export PATH=${PATH}:/usr/local/share/npm/bin                #npm
#
#Python paths
#export PATH=/System/library/Frameworks/Ruby.framework/Versions/2.7/usr/bin:$PATH
#export PATH=$PATH:/System/Library/Frameworks/Python.framework/Versions/Current/bin
#export PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin

#
# For non-root users, add the current directory to the search path:
if [ ! "`id -u`" = "0" ]; then
    PATH="$PATH:."
fi
#
# my manual (man pages) paths
export MANPATH=/usr/local/share/man:$MANPATH
export MANPATH=${MANPATH}:/opt/X11/share/man:/usr/local/man:/usr/share/man
export MANPATH=${MANPATH}:/Developer/usr/share/man:/Developer/usr/X11/man:/usr/X11/man:~/Sync/Bash/man
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
# Make sure programs that want readline can find my configuration.
export INPUTRC=~/.inputrc

# Ruby Gems
export GEM_HOME='~/.gem'
export GEMPATH"=~/.gem/:/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8:/Library/Ruby/Gems/1.8"
load_completion() {
# Completion
    # http://www.reddit.com/r/commandline/comments/kbeoe/you_can_make_readline_and_bash_much_more_user/
    # https://wiki.archlinux.org/index.php/Zsh
autoload -U compinit
fpath=($* $fpath)
fignore=(.DS_Store $fignore)
compinit -i
zmodload -i zsh/complist
setopt extendedglob
setopt complete_in_word
setopt auto_remove_slash
unsetopt always_to_end
    #has_brew && compctl -K _gimme gimme
	# Provide tab completion for hosts in known_hosts file.
    #[[ -f ~/.ssh/known_hosts ]] && hosts=(`awk '{print $1}' ~/.ssh/known_hosts | tr ',' '\n' `)
    #[[ -f ~/.ssh/config ]] && hosts=($hosts `grep '^Host' ~/.ssh/config | sed s/Host\ // | egrep -v '^\*$'`)
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:*:open:*' matcher 'm:{a-z}={A-Z} r: ||[^ ]=**'
	#highlights='${PREFIX:+=(#bi)($PREFIX:t)(?)*==31=1;32}':${(s.:.)LS_COLORS}}
	#highlights2='=(#bi) #([0-9]#) #([^ ]#) #([^ ]#) ##*($PREFIX)*==1;31=1;35=1;33=1;32=}'
	#zstyle -e ':completion:*' list-colors 'if [[ $words[1] != kill && $words[1] != strace ]]; then reply=( "'$highlights'" ); else reply=( "'$highlights2'" ); fi'
	##unset highlights
	# For autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' expand 'yes'
	#zstyle ':completion:*:approximate:*' max-errors 1 numeric
	# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ./cache/
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:ogg123:*' file-patterns '*.(ogg|OGG):ogg\ files *(-/):directories'

# kill completion
zstyle ':completion:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
#zstyle ':completion:*:kill:*' insert-ids single
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
#zstyle ':completion:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
	
#zstyle ':completion:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
	# for all completions: grouping / headline / ...
	#zstyle ':completion:*:messages' format $'\e[01;35m -- %d -- \e[00;00m'
	#zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found -- \e[00;00m'
	#zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d -- \e[00;00m'
zstyle ':completion:*:corrections' format $'\e[01;33m -- %d -- \e[00;00m'

	
# statusline for many hits
zstyle ':completion:*:default' select-prompt $'\e[01;35m ▶ Match %M %P \e[00;00m'
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=238;01;34'
zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'

zstyle ':completion:*:messages' format $'%{\e[0;31m%}▶ %d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}▶ No matches: %d%{\e[0m%}'
}
# colors on tab complete, untill I get a handle on zsh/complist
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=40}:${(s.:.)LS_COLORS}")';
export ZLS_COLORS=$LS_COLORS

# 'ctrl-x r' will complete the 12 last modified (mtime) files/directories
zle -C newest-files complete-word _generic
bindkey '^Xr' newest-files
zstyle ':completion:newest-files:*' completer _files
zstyle ':completion:newest-files:*' file-patterns '*~.*(omN[1,12])'
zstyle ':completion:newest-files:*' menu select yes
zstyle ':completion:newest-files:*' sort false
zstyle ':completion:newest-files:*' matcher-list 'b:=*' # important


# Provide tab completion for hosts in known_hosts file.
# http://unix.stackexchange.com/questions/14155/ignore-hosts-file-in-zsh-ssh-scp-tab-complete
# use /etc/hosts and known_hosts for hostname completion
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
knownhosts=("$_ssh_config[@]" "$_ssh_hosts[@]")
#local knownhosts
zstyle ':completion:*:(ssh|scp|sftp):*' $knownhosts 2>/dev/null

setopt completealiases
#compdef pkill=kill
#compdef pkill=killall
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

#bindkey '"\C-t": possible-completions' # replaces 'transpose-chars'
#bindkey '"\M-t": menu-complete'        # replaces 'transpose-words'
# https://coderwall.com/p/a8uxma
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Bind escape + number to last command variables.
# 0 = Last, other numbers as is.
bindkey -s '\e0' "!$"
bindkey -s '\e1' "!:1"
bindkey -s '\e2' "!:2"
bindkey -s '\e3' "!:3"
bindkey -s '\e4' "!:4"
bindkey -s '\e5' "!:5"

# Ctrl-t to print date
function unix_ts { 
LBUFFER="${LBUFFER}$(date '+%Y-%m-%d')" 
}
zle -N unix_ts
bindkey "^d" unix_ts
#==================================================
# Ruby Version manager  # get errors on loading
#alias rvm-prompt='$HOME/.rvm/bin/rvm-prompt'
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#
#[[ -r $HOME/.rvm/scripts/completion ]] && . $HOME/.rvm/scripts/completion #rvm tab completion
#
#__rvm_project_rvmrc
#
#==================================================
autoload -U zmv
unsetopt auto_name_dirs
unsetopt correct_all
setopt complete_aliases

# complete g=git alias
#complete -o default -o nospace -F _git g
# from brew, for colorized output.
source `brew --prefix`/etc/grc.bashrc

source ~/.oh-my-zsh/custom/plugins/aliases.zsh
source ~/.oh-my-zsh/custom/plugins/functions.zsh
source ~/.aliases_bash
source ~/.aliases_bash_osx
source ~/.aliases_bash_robbie
source /usr/local/bin/z.sh

# from brew
fpath=(/usr/local/share/zsh-completions $fpath)

## Vim mode
bindkey -M viins 'jj' vi-cmd-mode
vim_ins_mode="[INS]"
vim_cmd_mode="[CMD]"
vim_mode=$vim_ins_mode

zle-line-init() { zle -K viins; }
zle -N zle-line-init

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish
# VI MODE KEYBINDINGS (ins mode)
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins '^k'    kill-line
bindkey -M viins '^r'    history-incremental-pattern-search-backward
bindkey -M viins '^s'    history-incremental-pattern-search-forward
bindkey -M viins '^p'    up-line-or-history
bindkey -M viins '^n'    down-line-or-history
bindkey -M viins '^y'    yank
bindkey -M viins '^w'    backward-kill-word
bindkey -M viins '^u'    backward-kill-line
bindkey -M viins '^h'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^_'    undo
bindkey -M viins '^x^r'  redisplay
bindkey -M viins '\eOH'  beginning-of-line # Home
bindkey -M viins '\eOF'  end-of-line       # End
bindkey -M viins '\e[2~' overwrite-mode    # Insert
bindkey -M viins '\ef'   forward-word      # Alt-f
bindkey -M viins '\eb'   backward-word     # Alt-b
bindkey -M viins '\ed'   kill-word         # Alt-d                    

# VI MODE KEYBINDINGS (cmd mode)
bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^k'    kill-line
bindkey -M vicmd '^r'    history-incremental-pattern-search-backward
bindkey -M vicmd '^s'    history-incremental-pattern-search-forward
bindkey -M vicmd '^p'    up-line-or-history
bindkey -M vicmd '^n'    down-line-or-history
bindkey -M vicmd '^y'    yank
bindkey -M vicmd '^w'    backward-kill-word
bindkey -M vicmd '^u'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '\ef'   forward-word                      # Alt-f
bindkey -M vicmd '\eb'   backward-word                     # Alt-b
bindkey -M vicmd '\ed'   kill-word                         # Alt-d
bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp
bindkey -M vicmd '\e[6~' history-beginning-search-forward  # PageDown