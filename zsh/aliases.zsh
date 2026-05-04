# from wsl2
alias dco="docker compose"
alias sst="svn status"
alias sup="svn update"
alias ezsh="micro ~/.zshrc"
alias rzsh="source ~/.zshrc"
alias js="j -s"

#from uranus
alias hastop="dco stop homeassistant"
alias haup="dco up -d homeassistant"
alias harm="dco rm homeassistant"
alias halogs="dco logs  -f --tail=50 homeassistant"
alias haupdate="dco pull homeassistant; dco rm -sf homeassistant; dco up -d homeassistant; dco logs -f --tail=50 homeassistant"
alias hare="dco restart homeassistant"
alias u="TERM=xterm-256color micro"
alias desk="abduco -a desk1"
alias noderedupdate="dco pull node-red; dco rm -sf node-red; dco up -d node-red; dco logs -f --tail=50 node-red"
alias cda="cd /opt/homeassistant"
alias lzd='~/.local/bin/lazydocker'
alias sz='source ~/.zshrc'
alias sne="source ~/.env"
alias commitandpush='gaa; gcmsg "simple change"; gp'

#global
# added as links instead like so
# ln -s $(which fdfind) ~/.local/bin/fd
# ln -s $(which batcat) ~/.local/bin/bat
# alias bat='batcat'
# alias fd='fdfind'



# ---- Eza (better ls) ----- and other navigation aliases
alias -g ...=../..
alias -g ....=../../..
alias l='eza -1 -l --color=always --icons=always -a --group-directories-first --smart-group -h --git'
alias ls="eza --color=always --long --git --icons=always --no-time  --oneline --git-repos"
alias cd="z"

alias cat="bat"
alias e='fzf_helix'

alias fuzz="rg . | fzf "
#alias hx="helix"
# alias wezterm='flatpak run org.wezfurlong.wezterm'

# chezmoi
alias cz="chezmoi edit"
alias cua="chezmoi update -a -x=encrypted"
alias cch="cp ~/.config/helix/config.toml ~/.local/share/chezmoi/.chezmoitemplates/helix/config.toml; gaa ; gcmsg 'update helix config' ; gp "

# --- programs ---
alias lg="lazygit"
alias hk="hx"
alias en="y"
alias lj="lumo"
alias iss="intelli-shell"
alias ns="niri-session"
alias lt='lazytail "$(fd -I -e log | fzf --preview "bat {}")"'
alias fdif="fzf -m --preview 'bat --color=always {}' | xargs -r -n 2 delta"

# --- Zellij --- 
alias hh="zellij action new-tab --layout newr"
alias ct="zellij action close-tab"
alias nt="zellij action new-tab"
alias nl='f() { zellij action new-tab --layout stacked --name $1 };f'
alias nll='f() { zellij action new-tab --layout newstack --name $1 };f'
alias nln='f() { zellij a $1 --create };f'
alias za='zellij action toggle-floating-panes'
alias zls='zellij ls'
alias zt='zellij action new-tab'
alias zct="zellij action close-tab"
alias ct="zellij action close-tab"
alias nt="zellij action new-tab"
# --- repos stuff
alias svnu="svn update --username ${SVN_USER:-YOUR_SVN_USERNAME} --password $SVNPASS"
alias svnst="svn status --username ${SVN_USER:-YOUR_SVN_USERNAME} --password $SVNPASS"
alias svndiff="svndiff.sh"
alias ghc="gh repo list --limit 1000 | fzf  | awk '{print $1}' | xargs -r gh repo clone"




