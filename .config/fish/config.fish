# https://fishshell.com/docs/current/tutorial.html
# https://github.com/jorgebucaran/fish-shell-cookbook
# https://github.com/fish-shell/fish-shell/blob/master/share/config.fish
# https://github.com/fish-shell/fish-shell/blob/da32b6c172dcfe54c9dc4f19e46f35680fc8a91a/share/config.fish#L257-L269

set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
# set -x XDG_DATA_DIRS /usr/share /usr/local/share
set -x XDG_DESKTOP_DIR $HOME/Desktop
set -x XDG_DOWNLOAD_DIR $HOME/Downloads
set -x XDG_DOCUMENTS_DIR $HOME/Documents
set -x XDG_MUSIC_DIR $HOME/Music
set -x XDG_PICTURES_DIR $HOME/Pictures
set -x XDG_VIDEOS_DIR $HOME/Movies

if test (arch) = "arm64"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
end
# output is -
# export HOMEBREW_PREFIX="/usr/local"
# export HOMEBREW_CELLAR="/usr/local/Cellar"
# export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
# export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}"
# export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:"
# export INFOPATH="/usr/local/share/info:${INFOPATH:-}"
set -gx HOMEBREW_NO_ANALYTICS 1

fish_add_path "$HOME/.local/bin"
# fish_add_path "/opt/homebrew/bin"

if status is-interactive
  # Commands to run in interactive sessions can go here

# fish_vi_key_bindings
# User


# Editor variables
set -gx PAGER less
set -gx EDITOR vim
set -gx VISUAL (which subl) -w

# # Colorize man pages.
# # mb - blink
# set -gx LESS_TERMCAP_mb (set_color -o cyan)
# # md - bold
# set -gx LESS_TERMCAP_md (set_color -o cyan)
# # me - end
# set -gx LESS_TERMCAP_me (set_color normal)
# # so/se - standout
# set -gx LESS_TERMCAP_so (set_color -b white black)
# set -gx LESS_TERMCAP_se (set_color normal)
# # us/ue - underline
# set -gx LESS_TERMCAP_us (set_color -u magenta)
# set -gx LESS_TERMCAP_ue (set_color normal)


# Browser
switch (uname -s)
case Darwin
    set -gx BROWSER open
end

set -x BAT_CONFIG_PATH "~/.config/bat/config"
set -x RIPGREP_CONFIG_PATH "~/ripgrep/ripgreprc"

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow -g \"!.git/\" 2> /dev/null"
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
# FZF custom tokyo-night theme
# set -gx FZF_DEFAULT_OPTS "--color=fg:#a9b1d6,bg:#1a1b26,preview-fg:#c8d3f5,preview-bg:#222436,hl:#6d91de,fg+:#c0caf5,bg+:#161720,gutter:#161720,hl+:#e0af68,info:#646e9c,border:#565f89,prompt:#0db9d7,pointer:#dbc08a,marker:#9d7cd8,spinner:#9d599d,header:#61bdf2'"

[ -r ~/.aliases.fish ] && source ~/.aliases.fish
[ -r ~/.abbr.fish ] && source ~/.abbr.fish

# add function subdirs to fish_function_path
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path

# add completion subdirs to fish_completion_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

## Hooks
test -d $XDG_DATA_HOME/fish/generated_completions; or fish_update_completions

# Silently load SSH keys from the keychain if needed
ssh-add -l >/dev/null || ssh-add -A 2>/dev/null

# Source functions for asdf, a multi-purpose version manager
if test -f /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end



op completion fish | source
zoxide init fish | source
starship init fish | source

export ITERM2_SQUELCH_MARK=1
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

end
