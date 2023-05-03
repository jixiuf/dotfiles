#!/bin/bash

# Check if Emacs is running
if [[ $(xdotool search --onlyvisible --name "Chromium") ]]; then
    # Check if the current window is Emacs
    active_window=$(xdotool getactivewindow)
    emacs_window=$(xdotool search --onlyvisible --name "Chromium")
    if [[ $active_window == $emacs_window ]]; then
        # Hide Emacs if it is the active window
        xdotool windowminimize $active_window
    else
        # Bring Emacs to front if it is not the active window
        xdotool windowactivate $emacs_window
    fi
else
    # Launch Emacs if it is not running
    chromium&
fi