if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g theme_display_git_default_branch yes

# adding cool stuff to flex on other linux users
# eval neofetch
alias config='/usr/bin/git --git-dir=/home/joke/.dotfiles/ --work-tree=/home/joke'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/joke/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
