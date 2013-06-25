
# shell settings
set -o vi
set -o notify
set -o ignoreeof

shopt -s nocaseglob
shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
shopt -s checkwinsize

ulimit -c unlimited

# hist settings
export HISTFILE="${HOME}/tmp/bash_history.txt"
export HISTCONTROL=ignoreboth
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# comp settings
COMP_CVS_REMOTE=1
COMP_CONFIGURE_HINTS=1
COMP_TAR_INTERNAL_PATHS=1

case $- in
  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion
       [[ -f "${HOME}/.dotfiles/git-completion.bash" ]] && . "${HOME}/.dotfiles/git-completion.bash"
       [[ -f "${HOME}/.dotfiles/git-prompt.sh" ]] && . "${HOME}/.dotfiles/git-prompt.sh"
       ;;
esac

#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWCOLORHINTS=1
#export GIT_PS1_SHOWUPSTREAM='auto git'
#export GIT_PS1_DESCRIBE_STYLE='branch'
#export PROMPT_COMMAND='__git_ps1 "\w " "\\\$ " " (%s)"'

export PROMPT_DIRTRIM=3

function update_ps1_() {
  export PS1="$(${HOME}/.dotfiles/powerline-shell.py $?)"
}
export PROMPT_COMMAND="update_ps1_"

export LS_COLORS='di=38;5;108:fi=00:ln=38;5;116:ex=38;5;186'

export MAKE_OPTIMIZE=1

# gcc
#GCC_VERSION='4.7.2'
#GCC_VERSION='4.7.1'
#GCC_VERSION='4.7.0'
#GCC_VERSION='4.6.3'
#GCC_VERSION='4.5.3'
GCC_VERSION='4.5.1'
#GCC_VERSION='4.4.1'
#GCC_VERSION='3.4.6'

#export LC_ALL=en_US.UTF-8

#export CC="ccache distcc gcc-${GCC_VERSION}/bin/gcc"
#export CXX="ccache distcc gcc-${GCC_VERSION}/bin/g++"
#export PATH="/usr/local/ccache/bin:/usr/local/distcc/bin:/usr/local/gcc-${GCC_VERSION}/bin"

export CC="/usr/local/gcc-${GCC_VERSION}/bin/gcc"
export CXX="/usr/local/gcc-${GCC_VERSION}/bin/g++"
export PATH="/usr/local/gcc-${GCC_VERSION}/bin"

#CXXFLAGS="${CXXFLAGS} -Wfatal-errors"
CPPFLAGS="${CPPFLAGS} -Wfatal-errors"

# gen exports
export BOOST_ROOT='/usr/local/boost-1.49.0'
export BOOSTROOT=${BOOST_ROOT}
export PATH=".:${PATH}:${HOME}/local/bin:/usr/local/python/bin:/usr/local/vim-7.3/bin:/usr/local/git-1.8.0/bin:/usr/local/protobuf-2.4.1/bin:/usr/local/autoconf-2.63/bin:${HOME}/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin"
export LD_LIBRARY_PATH="${HOME}/local/lib:/usr/local/lib:${BOOST_ROOT}/lib:${SQLITEROOT}/lib:/usr/local/protobuf-2.4.1/lib"

export EDITOR='/usr/local/vim-7.3/bin/vim'
export PAGER='/usr/bin/less'
export GREP_OPTIONS='--color=auto'

export MANPATH="${MANPATH}:${HOME}/man"

# for colorful less (and manpage) output
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#export CDPATH=".:${OLDPWD}"

# cvs
export CVSROOT=:ext:bpwood@cvs.solipsys.com:/cvs
export CVS_RSH=/usr/bin/ssh

# java
export JAVA_HOME='/usr/local/java/jdk1.6.0_18'
export JAVA_EXE="${JAVA_HOME}/bin/java"
export ANT_HOME='/usr/local/ant'
export CLASSPATH=".:${ANT_HOME}/lib/ant-apache-log4j.jar"
export THREADS_FLAGS=green
export PATH="${PATH}:${JAVA_HOME}/bin:${ANT_HOME}/bin"

# solipsys
export MSCT_CHANNEL=7
export MTM_CHANNEL=${MSCT_CHANNEL}
export SOLINET_PORT=37777

export WORK="${HOME}/work"
export DBDIR="${HOME}/db"
export DXLOGDIR="${DBDIR}"

# tdf
export LICENSE_DIR="${DBDIR}/lic"
export ASSAULT_HOME="${WORK}/assault/release"
export ANT_OPTS="-Xmx128m -DJAVA_HOME=${JAVA_HOME} -DASSAULT_HOME=${ASSAULT_HOME} -Djava.endorsed.dirs=${ASSAULT_HOME}/lib/xalan-2.7 -DLicense.dir=${LICENSE_DIR}"
export ANT_ARGS="-s build.xml"
export PATH="${ASSAULT_HOME}/ant/bin:${ASSAULT_HOME}/bin:${PATH}"

# msct
if [ -f '/etc/redhat-release' ]; then
  case $( cat '/etc/redhat-release' ) in
    *Nahant*)  OSREL='-RH4';;
    *Tikanga*) OSREL='-RH5';;
    *)         OSREL=
  esac
fi
export SOLIDEPS="/usr/local/solideps/Linux${OSREL}-gcc${GCC_VERSION}"
export SCOLDROOT="${SOLIDEPS}"

MSCTROOT="${WORK}/msct"
if [ -e ${MSCTROOT} ]; then
  export MSCTROOT
  export PATH="${PATH}:${MSCTROOT}/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${MSCTROOT}/lib"
  MSCT_REPOS=( 'solinet' 'solimath' 'slate' 'tadil' 'dis' 'vmf' )
  OPT_REPOS=( 'radarsim' 'regression' 'msct-ivv' 'cac2sp2' 'plugged' 'JtcwInterface' 'esmif' 'tcnapi' 'tcnutils' 'acmamsct' 'jadge' 'tdelrr' )
elif [ -e "${WORK}/mtm" ]; then
  MSCTROOT="${WORK}/mtm"
  MTMROOT=$MSCTROOT
  export MTMROOT
  export PATH="${PATH}:${MSCTROOT}/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${MSCTROOT}/lib"
  MSCT_REPOS=( 'solinet' 'solimath' 'dis' )
  OPT_REPOS=( 'radarsim' 'regression' 'mtm-ivv' )
fi

for REPO in ${MSCT_REPOS[@]}; do
  UREPO=$( echo "${REPO}" | tr [:lower:] [:upper:] )
  ROOT="${UREPO}ROOT"
  LOCAL_ROOT="${WORK}/${REPO}"
  MSCT_README_REQ="${MSCTROOT}/README.requirements"
  if [ -e  ${LOCAL_ROOT} ]; then
    export ${ROOT}="${LOCAL_ROOT}"
  elif [ -e ${MSCT_README_REQ} ]; then
    #SED_STR="s|^setenv\s*${ROOT}\s*\${SOLIDEPS}/${REPO}-\(.*\)/|\1|p"
    SED_STR="s|^setenv\s*${ROOT}\s*\${SOLIDEPS}/${REPO}-\(.*\)|\1|p"
    REPO_VERSION=$( sed -n ${SED_STR} < ${MSCT_README_REQ} )
    export ${ROOT}="${SOLIDEPS}/${REPO}-${REPO_VERSION}" 
  fi
  ROOT_VALUE=$(eval echo \$${ROOT})
  export PATH="${PATH}:${ROOT_VALUE}/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT_VALUE}/lib"
  export CLASSPATH="${CLASSPATH}:${ROOT_VALUE}/src/java/${REPO}.jar"
  if [ ${REPO} = 'solinet' ]; then
    export CLASSPATH="${CLASSPATH}:${ROOT_VALUE}/src/java/log4j.jar"
  fi
done

for REPO in ${OPT_REPOS[@]}; do
  UREPO=$( echo "${REPO}" | tr -d '-' | tr [:lower:] [:upper:] )
  ROOT="${UREPO}ROOT"
  LOCAL_ROOT="${WORK}/${REPO}"
  if [ -e  ${LOCAL_ROOT} ]; then
    export ${ROOT}="${LOCAL_ROOT}"
    ROOT_VALUE=$(eval echo ${LOCAL_ROOT})
    export PATH="${PATH}:${ROOT_VALUE}/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT_VALUE}/lib"
    export CLASSPATH="${CLASSPATH}:${ROOT_VALUE}/src/java/${REPO}.jar"
  fi
done

#if [ ! -e ${MSCTROOT}]; then
#fi

export PATH="${WORK}/bin:${PATH}"
export LD_LIBRARY_PATH="${WORK}/lib:${LD_LIBRARY_PATH}"

#export DEBUG_TRACKER=3
#export DEBUG_FUSION=9
#export DEBUG_REGISTRATION=9
#export DEBUG_RELATIVE=9

# sourcings
if [ -e ${HOME}/.bash_alias ]; then . "${HOME}/.bash_alias"; fi
if [ -e ${HOME}/.bash_function ]; then . "${HOME}/.bash_function"; fi

