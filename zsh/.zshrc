# Shell history
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt HIST_ignore_dups

# create tmux session, attach terminal
#if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
#	tmux new-session
#	exit
#fi

# Correct case errors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Ctrl-Left/Right jumps words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Enable completion
autoload -U compinit
compinit

# Backward word kill
bindkey '' backward-kill-word
autoload -U select-word-style
select-word-style bash


##################################
### Added by Zinit's installer ###
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zinit Packages
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
### End of Zinit ###
####################

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}
setopt prompt_subst

# User prompt
autoload -U colors && colors
PROMPT='%B%F{yellow}[%B%F{magenta}%n%b%F{magenta}@%B%F{magenta}%m%F{reset} %b%F{white}%~%B%F{yellow}]%F{reset}${vcs_info_msg_0_}'$'%-50(l:$%b :%B%F{green}  ==>%f\n$%b )'
#PROMPT='%B%F{yellow}[%B%F{magenta}%n%b%F{magenta}@%B%F{magenta}%m%F{reset} %b%F{white}%~%B%F{yellow}]%F{reset}${vcs_info_msg_0_}$(prompt_length_change)%b '

# Right prompt - holds command exit code
RPROMPT=$'%(?.. [%F{red}%B%?%b%F{reset}])'

# Use neovim to edit files
export EDITOR=nvim
export VISUAL=nvim

###################
### Command Aliases
alias nv='nvim'
alias ls='ls --color -h'

alias l='ls --color -h'
alias la='ls --color -ah'
alias ll='ls --color -lh'
alias lla='ls --color -lah'

alias grep='grep --color=always'
alias less='less -x 4 '
alias ip='ip -c'
alias py='python3'
alias ipy='ipython3'
alias clc='clear'

alias watch='watch -c '

# Config Aliases
alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
alias tmuxrc='nvim ~/.tmux.conf'
###################

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Display system info on terminal open
#neofetch 

# 4 space tab width
tabs 4

# Command not found handler
source /etc/zsh_command_not_found

# Print date and daily verse on login
printf "\x1b[33;1m===== \x1b[5m$(date)\x1b[0;33;1m =====\x1b[m\n"
printf "\x1b[1m$(verse)\x1b[m\n"
