#zsh prompt
# dunolie.zshtheme
# dunolie @ gmail * com
# Last Modified:
# Credit to all those I've taken snips from :)
# colored exit: http://www.lowlevelmanager.com/2012/03/smile-zsh-prompt-happysad-face.html
# battery: https://gist.github.com/gworley3/3136888

autoload -U colors && colors

##ok for prompt ~ alignment issues with rprompt
#COLOURED_RETURN_VAL="%(▪▶$fg{green}$fg{red})▪▶"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}♺"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}☯"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}♺"
# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}▶"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg[green]%})%{$reset_color%}"



#-----------------------------------------
# Example : With [user@host] for ssh connection
#-----------------------------------------
function ssh_connection() {
if [[ -n $SSH_CONNECTION ]]; then
	echo '[%n@%m]'
fi
}

#-----------------------------------------
# Example : check if your on a mac laptop  and then load battery script
#-----------------------------------------

function laptop_battery () {
lappy="$(system_profiler SPPowerDataType | grep "Battery Installed: Yes")"
if [[ -z "$lappy" ]]; then
	echo ""
else
	#use this RPROMPT for a laptop (with the battery script)
	#echo "$(CUTE_BATTERY_INDICATOR=1 ~/bin/battery Discharging;CUTE_BATTERY_INDICATOR=1 ~/bin/battery Charging)"
	echo "$(~/bin/battery-prompt)"
fi
}

#-----------------------------------------

PROMPT='%{$fg[magenta]%}[%h][%T]$(ssh_connection) %{$reset_color%}%{$fg[green]%}%20<➥<%~%<< %{$reset_color%}%(?,%{$fg[cyan]%}%(!.#.▶)%{$reset_color%},%{$fg[red]%}%(!.#.▶)%{$reset_color%}) '
setopt promptsubst
setopt promptpercent
#RPROMPT='$(git_prompt_info)$(git_prompt_short_sha)%{$fg[magenta]%}[$(~/bin/battery-prompt)%]'
RPROMPT='$(git_prompt_info)$(git_prompt_short_sha)%{$fg[magenta]%}[$(laptop_battery)]%{$reset_color%}'
#PS2="%{$fg[cyan]%}▶ %{$reset_color%}"
#-----------------------------------------
# Example : check if your on a mac laptop  and then load battery script
#-----------------------------------------
#function laptop_battery () {
#if [ ! "$(pmset -g | grep Battery)" -eq 1 ]; then
#	echo ""
#	else
#	#echo "$(BAT_CHARGE)" 2>/dev/null
#	echo "$(~/bin/batcharge.py)" 2>/dev/null
#fi
#}
#function laptop_battery () {
#	echo "$(~/bin/batcharge)" 2>/dev/null
#}
#
#function laptop_battery () {
#	echo $(CUTE_BATTERY_INDICATOR=1 ~/bin/battery Discharging;CUTE_BATTERY_INDICATOR=1 ~/bin/battery Charging)
	#}
#-----------------------------------------
# Example : With [user@host] for ssh connection
#-----------------------------------------
#function ssh_connection() {
#  if [[ -n $SSH_CONNECTION ]]; then
#    echo "%{$fg[megenta]%}[%n@%m]"
#  fi
  #}
#PROMPT='%{$fg[magenta]%}[%h][%T]'$(ssh_connection)' %{$reset_color%}%{$fg[green]%}%20<➥<%~%<< %{$reset_color%}%(?,%{$fg[cyan]%}%(!.#.▶)%{$reset_color%},%{$fg[red]%}%(!.#.▶)%{$reset_color%}) '
#RPROMPT='$(git_prompt_info)$(git_prompt_short_sha)%{$fg[magenta]%}$(laptop_battery)%{$reset_color%}'
#-----------------------------------------
# Example : Colored prompt for root
#-----------------------------------------
#if [ $UID -eq 0 ]; then ROOT_COLOR="red"; else ROOT_COLOR="yellow"; fi

#PROMPT='%{$fg[$ROOT_COLOR]%}%c ➤ %{$reset_color%}'
#-----------------------------------------

#-----------------------------------------
# Example
#-----------------------------------------

# Color shortcuts
#RED=$fg[red]
#YELLOW=$fg[yellow]
#GREEN=$fg[green]
#WHITE=$fg[white]
#BLUE=$fg[blue]
#CYAN=$fg[cyan]
#MAGENTA=$fg[magenta]
#RED_BOLD=$fg_bold[red]
#YELLOW_BOLD=$fg_bold[yellow]
#GREEN_BOLD=$fg_bold[green]
#WHITE_BOLD=$fg_bold[white]
#BLUE_BOLD=$fg_bold[blue]
#CYAN_BOLD=$fg[cyan]
#MAGENTA_BOLD=$fg[magenta]
#RESET_COLOR=$reset_color

# Format for git_prompt_info()
#ZSH_THEME_GIT_PROMPT_PREFIX=""
#ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(*)"
#ZSH_THEME_GIT_PROMPT_CLEAN="{$GREEN%}"

# Format for git_prompt_status()
#ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
#ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}deleted"
#ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
#ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}modified"
#ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}added"
#ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}untracked"

# Format for git_prompt_ahead()
#ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
#ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
#ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

# Prompt format
#PROMPT='%{$GREEN_BOLD%}%n@%m%{$WHITE%}:%{$YELLOW%}%~%u$(parse_git_dirty)$(git_prompt_ahead)%{$RESET_COLOR%}%{$BLUE%}>%{$RESET_COLOR%} '


#RPROMPT='%{$GREEN_BOLD%}$(current_branch)$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%}'

#-----------------------------------------
# Testing
#-----------------------------------------
#PROMPT='%{$fg[magenta]%}[%h][%T][%n@%m] %{$reset_color%}%{$fg[green]%}%c %{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}▶%{$reset_color%}'

# With colored exit. http://www.lowlevelmanager.com/2012/03/smile-zsh-prompt-happysad-face.html
#PROMPT='%{$fg[magenta]%}[%h][%T][%n@%m] %{$reset_color%}%{$fg[green]%}%15<..<%~%<< %{$reset_color%}$(git_prompt_info)%(?,%{$fg[cyan]%}▶%{$reset_color%},%{$fg[red]%}▶%{$reset_color%})'



#PROMPT='%{$fg[magenta]%}[%h][%T] %{$reset_color%}%{$fg[green]%}%15<➥<%~%<< %{$reset_color%}$(git_prompt_info)%(?,%{$fg[cyan]%}%(!.#.▶)%{$reset_color%},%{$fg[red]%}%(!.#.▶)%{$reset_color%})'
#RPROMPT='$(git_prompt_info)'
# the prompt ’%10<...<%~%<<%# ’ will print a truncated representation of the current directory, followed by a ‘%’ or ‘#’, followed by a space. Without the ‘%<<’, those two characters would be included in the string to be truncated

