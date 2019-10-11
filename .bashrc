# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# TAKEN FROM: https://superuser.com/questions/187455/right-align-part-of-prompt/1203400
# BEGIN Stack Overflow Excerpt

prompt_pre() {
  # Put current directory on the RHS of the screen, instead of the left, leaving the left
  # side to focus on the command that I'm working with.  If a Github repository, color it
  # green; otherwise, red.

  color="\e[0;1;31m"
  if (git rev-parse  --is-inside-work-tree > /dev/null 2>&1); then
    color="\e[0;1;32m"
    status=$(git status -s | wc -l)
    if [ ! $status == '0' ]; then
      color="\e[0;1;33m"
    fi
  fi

  # Create a string like:  "[ Apr 25 16:06 ]" with time in RED.
  printf -v PS1RHS "\e[0m[ ${color}$(pwd) \e[0m]"

  # Strip ANSI commands before counting length
  # From: https://www.commandlinefu.com/commands/view/12043/remove-color-special-escape-ansi-codes-from-text-with-sed
  PS1RHS_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$PS1RHS")

  # Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
  Save='\e[s' # Save cursor position
  Rest='\e[u' # Restore cursor to save point

  # Save cursor position, jump to right hand edge, then go left N columns where
  # N is the length of the printable RHS string. Print the RHS string, then
  # return to the saved position and print the LHS prompt.

  # Note: "\[" and "\]" are used so that bash can calculate the number of
  # printed characters so that the prompt doesn't do strange things when
  # editing the entered text.

  PS1='[\u@\h]\$ '
  PS1="\[${Save}\e[${COLUMNS:-$(tput cols)}C\e[${#PS1RHS_stripped}D${PS1RHS}${Rest}\]${PS1}"
}

export PROMPT_COMMAND='prompt_pre'

# END Stack Overflow Excerpt

