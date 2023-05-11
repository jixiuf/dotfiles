# Default config for sway
#
# Copy this to ~/.config/sway/config and edit it to your liking.
#
# Read `man 5 sway` for a complete reference.

### Variables
#pacman -S xorg-xmodmap
# xmodmap 
# control/shift/lock/mod1/mod4
# mod1=alt/meta
# mod4=cmd/win

# Spacekey   = Mod4+control = cmd+control
# Caplocks   =mod4+mod1     =cmd+alt

# Home row direction keys, like vim
set $left h
set $down j
set $up k
set $right l

# Your preferred terminal emulator
# wget https://github.com/alacritty/alacritty/blob/master/extra/alacritty.info
# sudo tic -xe alacritty,alacritty-direct ./alacritty.info
set $term alacritty
# Your preferred application launcher
# Note: pass the final command to swaymsg so that the resulting window can be opened
# on the original workspace that the command was run on.
set $menu dmenu_path | dmenu | xargs swaymsg exec --

### Output configuration
#
# Default wallpaper (more resolutions are available in /usr/share/backgrounds/sway/)
output * bg /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill
#
# Example configuration:
#
#   output HDMI-A-1 resolution 1920x1080 position 1920,0
#
# You can get the names of your outputs by running: swaymsg -t get_outputs

### Idle configuration
#
# Example configuration:
#
exec swayidle -w \
         timeout 300 'swaylock -f -c 000000' \
         timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
         before-sleep 'swaylock -f -c 000000'
#
# This will lock your screen after 300 seconds of inactivity, then turn off
# your displays after another 300 seconds, and turn your screens back on when
# resumed. It will also lock your screen before your computer goes to sleep.

### Input configuration
#
# Example configuration:
# man 5 sway-input
   input "type:touchpad" {
       dwt enabled              #disable-while-typing
       tap enabled
       natural_scroll enabled
       middle_emulation enabled
       pointer_accel 0.5  
       scroll_factor 0.5
       # drag_lock enabled
       drag enabled
   }
   # or input <identifier>
   input "type:keyboard" {
    repeat_delay 200
    #big->fast
    repeat_rate 36
   }
# You can get the names of your inputs by running: swaymsg -t get_inputs
# Read `man 5 sway-input` for more information about this section.

### Key bindings
#
# Basics:
#
    # Start a terminal
    bindsym spacekey+d exec $term
    # Kill focused window
    bindsym spacekey+q kill

    # Start your launcher
    bindsym caplocks+d exec $menu

    # Drag floating windows by holding down caplocks and left mouse button.
    # Resize them with right mouse button + caplocks.
    # Despite the name, also works for non-floating windows.
    # Change normal to inverse to use left mouse button for resizing and right
    # mouse button for dragging.
    floating_modifier control normal

    # Reload the configuration file
    bindsym caplocks+c reload

    # Exit sway (logs you out of your Wayland session)
    bindsym caplocks+control+Shift+l exec swaymsg exit
#
# Moving around:
#
    # Move your focus around
    bindsym caplocks+$left focus left
    bindsym caplocks+$down focus down
    bindsym caplocks+$up focus up
    bindsym caplocks+$right focus right
    # Or use caplocks+[up|down|left|right]
    bindsym caplocks+Left focus left
    bindsym caplocks+Down focus down
    bindsym caplocks+Up focus up
    bindsym caplocks+Right focus right

    # Move the focused window with the same, but add control
    bindsym caplocks+control+$left move left
    bindsym caplocks+control+$down move down
    bindsym caplocks+control+$up move up
    bindsym caplocks+control+$right move right
    # Ditto, with arrow keys
    bindsym caplocks+control+Left move left
    bindsym caplocks+control+Down move down
    bindsym caplocks+control+Up move up
    bindsym caplocks+control+Right move right
#
# Workspaces:
#
    # Switch to workspace
    bindsym caplocks+1 workspace number 1
    bindsym caplocks+2 workspace number 2
    bindsym caplocks+3 workspace number 3
    bindsym caplocks+4 workspace number 4
    bindsym caplocks+5 workspace number 5
    bindsym caplocks+6 workspace number 6
    bindsym caplocks+7 workspace number 7
    bindsym caplocks+8 workspace number 8
    bindsym caplocks+9 workspace number 9
    bindsym caplocks+0 workspace number 10
    # Move focused container to workspace
    bindsym caplocks+control+1 move container to workspace number 1
    bindsym caplocks+control+2 move container to workspace number 2
    bindsym caplocks+control+3 move container to workspace number 3
    bindsym caplocks+control+4 move container to workspace number 4
    bindsym caplocks+control+5 move container to workspace number 5
    bindsym caplocks+control+6 move container to workspace number 6
    bindsym caplocks+control+7 move container to workspace number 7
    bindsym caplocks+control+8 move container to workspace number 8
    bindsym caplocks+control+9 move container to workspace number 9
    bindsym caplocks+control+0 move container to workspace number 10
    # Note: workspaces can have any name you want, not just numbers.
    # We just use 1-10 as the default.
#
# Layout stuff:
#
    # You can "split" the current object of your focus with
    # caplocks+b or caplocks+v, for horizontal and vertical splits
    # respectively.
    bindsym caplocks+i splith
    bindsym caplocks+v splitv

    # Switch the current container between different layout styles
    bindsym caplocks+slash layout stacking
    bindsym caplocks+t layout tabbed
    bindsym caplocks+e layout toggle split

    # Make the current focus fullscreen
    bindsym spacekey+m fullscreen

    # Toggle the current focus between tiling and floating mode
    bindsym caplocks+f floating toggle

    # Swap focus between the tiling area and the floating area
    bindsym caplocks+space focus mode_toggle

    # Move focus to the parent container
    bindsym caplocks+u focus parent
#
# Scratchpad:
#
    # Sway has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
    bindsym caplocks+Shift+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
    bindsym caplocks+minus scratchpad show
#
# Resizing containers:
#
mode "resize" {
    # left will shrink the containers width
    # right will grow the containers width
    # up will shrink the containers height
    # down will grow the containers height
    bindsym $left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym $right resize grow width 10px

    # Ditto, with arrow keys
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym caplocks+r mode "resize"

#
# Status Bar:
#
# Read `man 5 sway-bar` for more information about this section.
bar {
    position top

    # When the status_command prints a new line to stdout, swaybar updates.
    # The default just shows the current date and time.
    status_command while date +'%Y-%m-%d %I:%M:%S %p'; do sleep 1; done

    colors {
        statusline #ffffff
        background #323232
        inactive_workspace #32323200 #32323200 #5c5c5c
    }
}

include /etc/sway/config.d/*

