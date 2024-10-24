alias ls='eza --git-ignore --icons'
alias la='eza -a --icons'
alias vim='sh  ~/.local/bin/lvim'
alias lc='eza -alh -snew --icons'
alias aliases="vim ~/.config/fish/conf.d/aliases.fish"
alias crash-houdini="killall -SEGV houdini-bin"
alias neofetch="neofetch --cpu_temp C --refresh_rate on --memory_percent on"
alias check-font="curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/bin/scripts/test-fonts.sh | bash"
alias public="curl icanhazip.com"
alias local="hostname -I"
alias py="python"
alias drives="df -h"
alias ..="cd .."
alias tree="eza -a --git-ignore --icons --tree"
alias cat="glow"
alias ga="git add ."
alias gs="git status"
alias gps="git push"
alias gpl="git pull"


for n in (seq 4 2 10)
    alias (string repeat -n $n ".")="cd_dots (string repeat -n $n ".")"
end


