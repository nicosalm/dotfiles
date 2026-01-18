alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ~='cd ~'
alias -- -='cd -'

alias createlog='cd /Users/nicosalm/dev/salm.dev && ./create-log.sh'

alias ez='nvim ~/.config/zsh/'
alias eg='nvim ~/.gitconfig'
alias ev='cd ~/.config/nvim/ && nvim .'
alias et='nvim ~/.tmux.conf'
alias lc='cd ~/dev/.leetcode && nvim .'
alias golings='cd ~/go/pkg/mod/github.com/mauricioabreu/golings@v0.8.0/exercises'
alias python='python3'

alias j='jobs'
alias ut='uptime'
alias so='source'
alias v='nvim'
alias c='clear'
alias ff='fastfetch'
alias pn='pnpm'
alias py="python3"
alias pyi="pyinstrument"
alias r='radian'
alias wipetmp='setopt nonomatch; rm -rf /Users/nicosalm/tmp/{*,.*} 2>/dev/null; unsetopt nonomatch'

rgd() {
    rg --json -C 2 "$@" | delta
}

export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
