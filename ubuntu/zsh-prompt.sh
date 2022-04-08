#Git Prompt

autoload -Uz vcs_info
precmd () {
  vcs_info
}

NL=$'\n%% '
# Minimal style
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

setopt PROMPT_SUBST
#PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_}> '
PROMPT='%F{yellow}%n%F{white} %F{blue}in%F{white} %F{green}${PWD/#$HOME/~}%F{white} %F{magenta}${vcs_info_msg_0_}>%F{white} %F{cyan}${NL}%F{white}'
