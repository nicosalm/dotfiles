typeset -gA zgit_info
zgit_info=()

zgit_chpwd_hook() {
    zgit_info_update
}

zgit_preexec_hook() {
    if [[ $2 == git\ * ]] || [[ $2 == *\ git\ * ]]; then
        zgit_precmd_do_update=1
    fi
}

zgit_precmd_hook() {
    if [ $zgit_precmd_do_update ]; then
        unset zgit_precmd_do_update
        zgit_info_update
    fi
}

zgit_info_update() {
    zgit_info=()

    local gitdir="$(git rev-parse --git-dir 2>/dev/null)"
    if [ $? -ne 0 ] || [ -z "$gitdir" ]; then
        return
    fi

    zgit_info[dir]=$gitdir
    zgit_info[bare]=$(git rev-parse --is-bare-repository)
    zgit_info[inwork]=$(git rev-parse --is-inside-work-tree)
}

zgit_isgit() {
    if [ -z "$zgit_info[dir]" ]; then
        return 1
    else
        return 0
    fi
}

zgit_inworktree() {
    zgit_isgit || return
    if [ "$zgit_info[inwork]" = "true" ]; then
        return 0
    else
        return 1
    fi
}

zgit_isbare() {
    zgit_isgit || return
    if [ "$zgit_info[bare]" = "true" ]; then
        return 0
    else
        return 1
    fi
}

zgit_head() {
    zgit_isgit || return 1

    if [ -z "$zgit_info[head]" ]; then
        local name=''
        name=$(git symbolic-ref -q HEAD)
        if [ $? -eq 0 ]; then
            if [[ $name == refs/(heads|tags)/* ]]; then
                name=${name#refs/(heads|tags)/}
            fi
        else
            name=$(git name-rev --name-only --no-undefined --always HEAD)
            if [ $? -ne 0 ]; then
                return 1
            elif [[ $name == remotes/* ]]; then
                name=${name#remotes/}
            fi
        fi
        zgit_info[head]=$name
    fi

    echo $zgit_info[head]
}

zgit_branch() {
    zgit_isgit || return 1
    zgit_isbare && return 1

    if [ -z "$zgit_info[branch]" ]; then
        local branch=$(git symbolic-ref HEAD 2>/dev/null)
        if [ $? -eq 0 ]; then
            branch=${branch##*/}
        else
            branch=$(git name-rev --name-only --always HEAD)
        fi
        zgit_info[branch]=$branch
    fi

    echo $zgit_info[branch]
    return 0
}

function zgit_isindexclean() {
    zgit_isgit || return 1
    if git diff --quiet --cached 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

function zgit_isworktreeclean() {
    zgit_isgit || return 1
    if git diff --quiet 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

function zgit_hasuntracked() {
    zgit_isgit || return 1
    local -a flist
    flist=($(git ls-files --others --exclude-standard 2>/dev/null))
    if [ $#flist -gt 0 ]; then
        return 0
    else
        return 1
    fi
}

zgitinit() {
    typeset -ga chpwd_functions
    typeset -ga preexec_functions
    typeset -ga precmd_functions
    chpwd_functions+='zgit_chpwd_hook'
    preexec_functions+='zgit_preexec_hook'
    precmd_functions+='zgit_precmd_hook'
}

zgitinit
zgit_info_update