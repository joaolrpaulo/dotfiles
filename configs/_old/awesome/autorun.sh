#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}

function check-enpass {
    if [[ $( ps aux | grep Enpass | grep -v grep | wc -l ) == 0 ]]; then
      run /opt/enpass/Enpass -minimize
    fi
}

# Set display resolution -> 3440x1440 @ 100 Hz
# if [[ $(hostname) == "athena" ]]; then
#   run nvidia-settings --assign CurrentMetaMode="3440x1440_100 +0+0"
# fi

# Boot every daemon
run nm-applet
run compton --shadow-exclude '!focused'
run xautolock -time 5 -locker "dm-tool lock"
run thunar --daemon
run blueman-applet
run msm_notifier
run sh -c "~/coding/dotfiles/scripts/mx_ergo_sensibility.sh"

# Boot Enpass
check-enpass

# Set the keyoard layout
setxkbmap -layout us -variant mac