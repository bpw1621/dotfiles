
# shell settings
set -o vi
set -o notify
set -o ignoreeof

shopt -s nocaseglob
shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

ulimit -c unlimited

# hist settings
export HISTCONTROL="ignoredups"
export HISTIGNORE="[   ]*:&:bg:fg:exit"
export PROMPT_COMMAND="history -a"

# comp settings
COMP_CVS_REMOTE=1
COMP_CONFIGURE_HINTS=1
COMP_TAR_INTERNAL_PATHS=1
case $- in
  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion
       [[ -f "${HOME}/.git-completion.sh" ]] && . "${HOME}/.git-completion.sh"
       ;;
esac


#. "${HOME}/ps1.sh"
function _update_ps1() { export PS1="$(~/powerline-bash.py $?)" }
export PROMPT_COMMAND="_update_ps1"

export LS_COLORS='di=38;5;108:fi=00:ln=38;5;116:ex=38;5;186'

# local perl modules
#export PERL5LIB="${HOME}/perl/lib:${HOME}/perl/lib/perl5/5.8.8:${HOME}/perl/lib/perl5/site_perl:${PERL5LIB}"
#export MANPATH="${MANPATH}:${HOME}/perl/man"

# gcc
#GCC_VERSION='4.7.0'
GCC_VERSION='4.6.3'
#GCC_VERSION='4.5.3'
#GCC_VERSION='4.5.1'
#GCC_VERSION='4.4.1'
#GCC_VERSION='3.4.6'

#export LC_ALL=en_US.UTF-8

export CC="ccache distcc gcc-${GCC_VERSION}/bin/gcc"
export CXX="ccache distcc gcc-${GCC_VERSION}/bin/g++"
export PATH="/usr/local/ccache/bin:/usr/local/distcc/bin:/usr/local/gcc-${GCC_VERSION}/bin"

#export CC="/usr/local/gcc-${GCC_VERSION}/bin/gcc"
#export CXX="/usr/local/gcc-${GCC_VERSION}/bin/g++"
#export PATH="/usr/local/gcc-${GCC_VERSION}/bin"

#export CC="${HOME}/gcc-${GCC_VERSION}/bin/gcc"
#export CXX="${HOME}/gcc-${GCC_VERSION}/bin/g++"
#export PATH="${HOME}/gcc-${GCC_VERSION}/bin"

#CXXFLAGS="${CXXFLAGS} -Wfatal-errors"
#CPPFLAGS="${CPPFLAGS} -Wfatal-errors -m32"
CPPFLAGS="${CPPFLAGS} -Wfatal-errors"

# gen exports
#export BOOST_ROOT="${HOME}/boost_1_48_0"
export BOOST_ROOT="/usr/local/boost-1.49.0"
export PATH=".:${PATH}:${HOME}/local/bin:/usr/local/vim-7.3/bin:${HOME}/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/git-1.7.7.2/bin:/usr/local/protobuf-2.4.1/bin"
export LD_LIBRARY_PATH="${HOME}/local/lib:/usr/local/lib:${BOOST_ROOT}/lib:${SQLITEROOT}/lib:/usr/local/protobuf-2.4.1/lib"

#export EDITOR=/usr/bin/vim
export EDITOR=/usr/local/vim-7.3/bin/vim
export PAGER=/usr/bin/less

export MANPATH="${MANPATH}:${HOME}/man"

#export CDPATH=".:${OLDPWD}"

# cvs
export CVSROOT=:ext:bpwood@cvs.solipsys.com:/cvs
export CVS_RSH=/usr/bin/ssh

# java
export JAVA_HOME='/usr/local/java/jdk1.6.0_18'
export JAVA_EXE="${JAVA_HOME}/bin/java"
#export ANT_HOME='/usr/local/apache-ant-1.7.0'
#export CLASSPATH=".:${ANT_HOME}/lib/ant-apache-log4j.jar"
#export THREADS_FLAGS=green
#export PATH="${PATH}:${JAVA_HOME}/bin:${ANT_HOME}/bin"

# solipsys
#export MSCT_CHANNEL=7
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
fi

MSCT_REPOS=( 'solinet' 'solimath' 'slate' 'tadil' 'dis' )
for REPO in ${MSCT_REPOS[@]}; do
  UREPO=$( echo "${REPO}" | tr [:lower:] [:upper:] )
  ROOT="${UREPO}ROOT"
  LOCAL_ROOT="${WORK}/${REPO}"
  MSCT_README_REQ="${MSCTROOT}/README.requirements"
  if [ -e  ${LOCAL_ROOT} ]; then
    export ${ROOT}="${LOCAL_ROOT}"
  elif [ -e ${MSCT_README_REQ} ]; then
    SED_STR="s|^setenv\s*${ROOT}\s*\${SOLIDEPS}/${REPO}-\(.*\)/|\1|p"
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

OPT_REPOS=( 'radarsim' 'regression' 'msct-ivv' 'cac2sp2' 'analysisLib' 'JtcwInterface' 'esmif' 'tcnapi' 'acmamsct' 'jadge' ) 
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

#export SQLITEROOT="${WORK}/sqlite"
export SQLITEROOT="/usr/local/sqlite3/"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${SQLITEROOT}/lib"
export PATH="${PATH}:${HOME}/gnuplot/bin"

#if [ -e "${WORK}/buildTools" ]; then
#  export PATH="${PATH}:${WORK}/buildTools"
#fi

#export PATH="${PATH}:${WORK}/bin"
#export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${WORK}/lib"
export PATH="${WORK}/bin:${PATH}"
export LD_LIBRARY_PATH="${WORK}/lib:${LD_LIBRARY_PATH}"

export PATH="${PATH}:${HOME}/mpi/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${HOME}/mpi/lib"

export DEBUG_TRACKER=3
export DEBUG_FUSION=9
#export DEBUG_REGISTRATION=9
#export DEBUG_RELATIVE=9

# spine/dds
OSPROOT="/usr/local/OpenSplice"
OSPVERS="V5.4.1"
OSPARCH="x86.linux2.6-dev"
#OSPENV="RTS" # Run Time
OSPENV="HDE" # Host Dev
SCRIPT="$OSPROOT/$OSPVERS/$OSPENV/$OSPARCH/release.com"
[ -f $SCRIPT ] && source $SCRIPT
export DDSROOT=$OSPL_HOME

# sourcings
if [ -f ${HOME}/.bash_alias ]; then . "${HOME}/.bash_alias"; fi
if [ -f ${HOME}/.bash_function ]; then . "${HOME}/.bash_function"; fi

