#!/bin/sh
# .Xinitrc
# ---------------------------

# COLOR SETTINGS
# ---------------------------
xrdb -load ~/.Xresources

# PERIPHERAL SETTINGS
# ---------------------------
# P50
xinput set-prop "TPPS/2 IBM TrackPoint" 'libinput Accel Speed' -0.35
#xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0

# Drawing tablet
# xinput set-prop 'HUION H420 Pen Pen (0)' "Coordinate Transformation Matrix" -1, 0, 1, 0, -1, 1, 0, 0, 1

# NVIDIA
# ---------------------------
xrandr --setprovideroutputsource modesetting NVIDIA-0
if [[ $(xrandr | grep "^DP-3\.1.* connected") ]]; then
  xrandr --output DP-3.1 --auto --output eDP-1-1 --auto --pos 3840x1080 --dpi 96
else
  xrandr --auto --dpi 128
fi

# INPUT
# ---------------------------
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx

# START WM
# ---------------------------
exec herbstluftwm
#exec dbus-launch --exit-with-session herbstluftwm
