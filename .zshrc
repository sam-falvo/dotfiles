
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
if [ -x ~/.login-sequence ]
then
  . ~/.login-sequence
fi

export HISTFILE="$HOME/.zhistory"
export HISTSIZE=5000
export SAVEHIST=5000

setopt autocd
setopt prompt_subst
setopt extended_history
setopt append_history
setopt hist_expire_dups_first
setopt hist_lex_words
setopt hist_no_store
setopt hist_verify
setopt inc_append_history
setopt sh_word_split

function __current_time() {
  echo $(date)
}

function rprompt() {
  echo "$PWD :: $(__current_time)"
}

export RPS1='$(rprompt)'
export PS1='$ '
fpath=(/usr/local/share/zsh-completions $fpath)

bindkey -v
bindkey \^R history-incremental-search-backward

