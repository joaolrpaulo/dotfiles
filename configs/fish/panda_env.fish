set -xg EDITOR 'vim'
set -xg TERM "xterm-256color"

set -xg WORK_PATH $HOME/coding
set -xg GOPATH $HOME/coding/go
set -xg PATH $PATH $HOME/.rvm/bin $WORK_PATH/bin $HOME/.local/bin $HOME/.ghcup/bin

set -xg _Z_DATA $HOME/.config/z

bind \e\[1\;3D cd_undo
bind \e\[1\;3C cd_redo
