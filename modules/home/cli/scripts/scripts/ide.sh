#!/bin/sh
session=$1

tmux new-session -d -t $session

tmux rename-window Code
tmux new-window
tmux rename-window Debug
tmux new-window
tmux rename-window Terminal
tmux split-window -v -p 50
tmux select-pane -U
tmux select-window -t:1
