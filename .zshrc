# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Starship prompt (load immediately for visual feedback)
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Turbo-load plugins (deferred after prompt)
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Load fzf-tab after compinit
zinit wait lucid for \
  Aloxaf/fzf-tab

# Add in snippets (deferred)
zinit wait lucid for \
    OMZL::git.zsh \
    atload"unalias grv" OMZP::git

# Preferred editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[w' kill-region
bindkey '^?' backward-delete-char

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias vim='nvim'
alias c='clear'

UPDATE_TASKS=(
  'echo "Updating Homebrew..."; brew update && brew upgrade; brew cleanup; echo "✓ Homebrew done"'
  'echo "Updating Zinit..."; zinit self-update && zinit update --parallel; echo "✓ Zinit done"'
)
update() {
  local pids=()
  for task in "${UPDATE_TASKS[@]}"; do
    (eval "$task") &
    pids+=($!)
  done
  wait
  echo "✅ All updates complete"
}

alias ll="eza -l --git --icons=always"
alias la="eza -la --git --icons=always"
alias ls="eza -a --git --icons=always"
alias clean-branches="git branch -vv | grep ': gone]'|  grep -v '\*' | awk '{ print $1; }' | xargs -r git branch -D"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PATH="$HOME/.amp/bin:$PATH"

# Cache mise activation to avoid subshell on every startup
_mise_path="$(brew --prefix)/bin/mise"
if [[ -x "$_mise_path" ]]; then
  eval "$("$_mise_path" activate zsh)"
fi
unset _mise_path

# Local machine-specific config (not tracked in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
