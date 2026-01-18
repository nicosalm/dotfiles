autoload -U colors && colors

revstring() {
    git describe --always $1 2>/dev/null ||
    git rev-parse --short $1 2>/dev/null
}

coloratom() {
    local off=$1 atom=$2
    if [[ $atom[1] == [[:upper:]] ]]; then
        off=$(( $off + 60 ))
    fi
    echo $(( $off + $colorcode[${(L)atom}] ))
}

colorword() {
    local fg=$1 bg=$2 att=$3
    local -a s

    if [ -n "$fg" ]; then
        s+=$(coloratom 30 $fg)
    fi
    if [ -n "$bg" ]; then
        s+=$(coloratom 40 $bg)
    fi
    if [ -n "$att" ]; then
        s+=$attcode[$att]
    fi

    echo "%{\e[${(j:;:)s}m%}"
}

minutes_since_last_commit() {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1 2>/dev/null`
    if $lastcommit ; then
      seconds_since_last_commit=$((now-last_commit))
      minutes_since_last_commit=$((seconds_since_last_commit/60))
      echo $minutes_since_last_commit
    else
      echo "-1"
    fi
}

prompt_grb_setup() {
    local verbose
    if [[ $TERM == screen* ]] && [ -n "$STY" ]; then
      verbose=
    else
      verbose=1
    fi
  
    typeset -A colorcode
    colorcode[black]=0
    colorcode[red]=1
    colorcode[green]=2
    colorcode[yellow]=3
    colorcode[blue]=4
    colorcode[magenta]=5
    colorcode[cyan]=6
    colorcode[white]=7
    colorcode[default]=9
    colorcode[k]=$colorcode[black]
    colorcode[r]=$colorcode[red]
    colorcode[g]=$colorcode[green]
    colorcode[y]=$colorcode[yellow]
    colorcode[b]=$colorcode[blue]
    colorcode[m]=$colorcode[magenta]
    colorcode[c]=$colorcode[cyan]
    colorcode[w]=$colorcode[white]
    colorcode[.]=$colorcode[default]
  
    typeset -A attcode
    attcode[none]=00
    attcode[bold]=01
    attcode[faint]=02
    attcode[standout]=03
    attcode[underline]=04
    attcode[blink]=05
    attcode[reverse]=07
    attcode[conceal]=08
    attcode[normal]=22
    attcode[no-standout]=23
    attcode[no-underline]=24
    attcode[no-blink]=25
    attcode[no-reverse]=27
    attcode[no-conceal]=28
  
    local -A pc
    pc[default]='default'
    pc[date]='Cyan'
    pc[time]='Cyan'
    pc[host]='Green'
    pc[user]='Cyan'
    pc[punc]='Cyan'
    pc[line]='Magenta'
    pc[hist]='Green'
    pc[path]='Blue'
    pc[shortpath]='Blue'
    pc[rc]='Red'
    pc[scm_branch]='Magenta'
    pc[scm_commitid]='Cyan'
    pc[scm_status_dirty]='Red'
    pc[scm_status_staged]='Green'
    pc[scm_time_short]='Green'
    pc[scm_time_medium]='Yellow'
    pc[scm_time_long]='Red'
    pc[scm_time_uncommitted]='Magenta'
    pc[#]='Cyan'
    for cn in ${(k)pc}; do
      case $cn in
        rc)
          pc[${cn}]=$(colorword $pc[$cn] . bold)
          ;;
        *)
          pc[${cn}]=$(colorword $pc[$cn])
          ;;
      esac
    done
    pc[reset]=$(colorword . . 00)

    typeset -Ag wunjo_prompt_colors
    wunjo_prompt_colors=(${(kv)pc})

    PROMPT="$pc[reset]"
    PROMPT+="$pc[host]nico$pc[reset]@$pc[user]mbp$pc[reset]::"
    PROMPT+="$pc[shortpath]%1~$pc[reset]"
    PROMPT+="\$(prompt_grb_scm_branch)"
    PROMPT+=" $pc[#]%#$pc[reset] "

    export PROMPT RPROMPT
    precmd_functions+='prompt_grb_precmd'
}

prompt_grb_precmd() {
    local ex=$?
    psvar=()

    if [[ $ex -ge 128 ]]; then
        sig=$signals[$ex-127]
        psvar[1]="sig${(L)sig}"
    else
        psvar[1]="$ex"
    fi
}

prompt_grb_scm_branch() {
    zgit_isgit || return
    local -A pc
    pc=(${(kv)wunjo_prompt_colors})

    echo -n "($pc[punc]$pc[scm_branch]$(zgit_head)"
    
    if zgit_inworktree; then
        local -a dirty_indicators
        
        if ! zgit_isindexclean; then
            dirty_indicators+='+'  # staged changes
        fi
        
        if ! zgit_isworktreeclean; then
            dirty_indicators+='!'  # unstaged changes
        fi
        
        if zgit_hasuntracked; then
            dirty_indicators+='?'  # untracked files
        fi
        
        if [ $#dirty_indicators -gt 0 ]; then
            echo -n "$pc[scm_status_dirty]${(j::)dirty_indicators}"
        fi
    fi
    
    echo -n "$pc[reset])"
}

prompt_grb_setup "$@"