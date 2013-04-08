#!/bin/bash
#
# Make a fancy prompt (Google others if this doesn't suit you) ---------------
#

# Henning's awesome TRON prompt 2.0.2 with current Git branch and success state of the last command (the syntax coloring here does not do it justice):
#export PS1='`if [ $? = 0 ]; then echo "\[\033[01;32m\]✔"; else echo "\[\033[01;31m\]✘"; fi` \[\033[01;30m\]\h\[\033[01;34m\] \w\[\033[35m\]$(__git_ps1 " %s") \[\033[01;30m\]>\[\033[00m\] '

#PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'

#function EXT_COLOR () { echo -ne "\e[38;5;$1m"; }
#function CLOSE_COLOR () { echo -ne '\e[m'; }
#export PS1="\[`EXT_COLOR 187`\]@\h\[`CLOSE_COLOR`\]\[`EXT_COLOR 174`\] \w \$ \[`CLOSE_COLOR`\]"
#export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#export PS1='$(EXT_COLOR 187)@\h$(CLOSE_COLOR) $(EXT_COLOR 51)\w$(CLOSE_COLOR)$(__git_ps1 " (%s)")\n\$ '

# Henning's awesome TRON prompt 2.0.2 with current Git branch and success state of the last command (the syntax coloring here does not do it justice):
#export PS1='`if [ $? = 0 ]; then echo "\[\033[01;32m\]✔"; else echo "\[\033[01;31m\]✘"; fi` \[\033[01;30m\]\h\[\033[01;34m\] \w\[\033[35m\]$(__git_ps1 " %s") \[\033[01;30m\]>\[\033[00m\] '

# Arne's epic timestamped prompt with return status indicator and status-colored (green or red, if unstaged) git branch:
#export PS1='\[\e[01;30m\]\t `if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` \[\e[00;37m\]\u\[\e[01;37m\]:`[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "\[\e[31m\]" || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '
#export PS1='\[\e[01;30m\]\t `if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` \[\e[00;37m\]\u\[\e[01;37m\]:`[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "\[\e[31m\]" || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '

# Slight mod to the Arne
export PS1='\[\e[01;30m\]\u@\h `if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` `[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "\[\e[31m\]" || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\] \w\[\e[00m\]\n\$ '
