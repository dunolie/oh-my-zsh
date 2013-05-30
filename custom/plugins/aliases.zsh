# vim : filetype=zsh et
# File: aliases.zsh
# Author: dunolie ~ dunolie @ gmail * com
# Description: zsh aliases
# Last Modified: Sun May 26, 2013  02:06am
# link:

#awk aliases
alias -g A1="| awk '{print \$1}'"
alias -g A2="| awk '{print \$2}'"
alias -g A3="| awk '{print \$3}'"
alias -g A4="| awk '{print \$4}'"
alias -g A5="| awk '{print \$5}'"
alias -g A6="| awk '{print \$6}'"
alias -g A7="| awk '{print \$7}'"
alias -g A8="| awk '{print \$8}'"
alias -g A9="| awk '{print \$9}'"
alias -g EA='|& awk '

# Paging with less / head / tail
alias -g L='| less'
alias -g LS='| less -S'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g H='| head -20'
alias -g T='| tail -20'

# Sorting / counting
alias -g C='| wc -l'
alias -g S='| sort'
alias -g US='| sort -u'
alias -g NS='| sort -n'
alias -g RNS='| sort -nr'


alias mza='mate ~/.oh-my-zsh/custom/plugins/aliases.zsh'
alias mzf='mate ~/.oh-my-zsh/custom/plugins/functions.zsh'

alias sza='source ~/.oh-my-zsh/custom/plugins/aliases.zsh'
alias szf='source ~/.oh-my-zsh/custom/plugins/functions.zsh'
