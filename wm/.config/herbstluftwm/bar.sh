#!/bin/bash

# LAYOUT INDICATOR
#herbstclient -i |
#while read line; do
#	case $line in
#		window_title_changed*|focus_changed*|tag_changed*|layout_changed*|reset*)
#			layout=$(herbstclient layout | grep '\[FOCUS\]' | egrep -o 'vertical|horizontal|grid|max')
#			layout=$(echo $layout | cut -c 1-4)
#			tag=$(herbstclient list_monitors | grep '\[FOCUS\]' | cut -d'"' -f2)
#			windows=$(herbstclient attr tags.by-name.$tag.curframe_wcount)
#			case $layout in
#				vert*)
#					layout=""
#					;;
#				hori*)
#					layout=""
#					;;
#				max*)
#					layout=""
#					if (( "$windows" > 1 )); then
#						layout="%{F"#EF2E31"}$layout%{F-}"
#					fi
#					;;
#				grid*)
#					layout=""
#					;;
#			esac
#			window_id=$(xdotool getactivewindow)
#			cur_window=$(xprop -id $window_id | grep WM_CLASS\(STRING\) | grep -o \"[^,]*\"$ | sed 's/\"//g')
#			case $cur_window in
#				URxvt)
#					cur_window="Terminal";;
#				Thunar|"")
#					cur_window="Finder";;
#			esac
#			;;
#	esac
#	echo -e "      $layout        %{T2}$cur_window"
#done | $panel -n "lmenu1" -f "$font1" -f "$font2" -f "$font3" -f "$font4" -g x24 eDP-1 2> /dev/null | sh & 

#if [[ $(pgrep -f 'nvidia-xorg.conf') ]]; then
#	MONITOR='DP-3.1'
#else
#	MONITOR='eDP-1'
#fi

MONITOR='eDP-1'

panel="lemonbar -B #1a252b -F #e8e8e8"
#font_mono="Anonymous Pro:size=10"
font_mono="Fira Code:size=12"
#font1="SFNS Display:style=Regular:size=14"

herbstclient -i |
while read line; do
	case $line in
		window_title_changed*|focus_changed*|tag_changed*|layout_changed*)
			LAYOUT=$(herbstclient layout | grep '\[FOCUS\]' | egrep -o 'vert|hori|max|grid')
			TAG=$(herbstclient list_monitors | grep '\[FOCUS\]' | cut -d'"' -f2)
			;;
		time_changed*)
			TIME=$(date +'%b %Y.%m.%d %I:%M%P')
			herbstclient emit_hook bat_changed
			;;
		reset*)
			herbstclient emit_hook time_changed
			herbstclient emit_hook focus_changed
			;;
			
		bat_changed*|*)
			BAT_C=$(cat /sys/class/power_supply/BAT0/capacity)
			BAT_S=$(cat /sys/class/power_supply/BAT0/status)
			case "$BAT_S" in
				Charging)
					BAT_S="+"
					;;
				Discharging)
					BAT_S="-"
					;;
				Full|*)
					BAT_S=""
					;;
			esac
			;;
	esac
	echo -e "%{c} $TIME  $BAT_C$BAT_S  $LAYOUT  $TAG "
done | $panel -f "$font_mono" -g 1904x40+8 -b $MONITOR 2> /dev/null | sh &

herbstclient emit_hook reset

#while true; do
#	bat_c=$(cat /sys/class/power_supply/BAT0/capacity)
#	bat_s=$(cat /sys/class/power_supply/BAT0/status)
#	case "$bat_s" in
#		Charging)
#			bat_s="+"
#			;;
#		Discharging)
#			bat_s="-"
#			;;
#		Full|*)
#			bat_s=""
#			;;
#	esac
#	if [[ $bat_c -ge 80 ]]; then
#		bat_i=""
#	elif [[ $bat_c -ge 100 ]]; then
#		bat_s=""
#	elif [[ $bat_c -ge 60 && $bat_c -lt 80 ]]; then
#		bat_i=""
#	elif [[ $bat_c -ge 40 && $bat_c -lt 60 ]]; then
#		bat_i=""
#	elif [[ $bat_c -ge 20 && $bat_c -lt 40 ]]; then
#		bat_i=""
#	elif [[ $bat_c -lt 20 ]]; then
#		bat_i=""
#	fi
#	bat_status="$bat_i ($bat_s$bat_c%)"
#	ping -c 1 8.8.8.8 > /dev/null 2>&1 && net_status="connected" || net_status="disconnected"
#	WIFI_INTERFACE="wlp4s0"
#	WIRED_INTERFACE="enp0s31f6"
#	WIRED_CONNECTION=$(cat "/sys/class/net/$WIRED_INTERFACE/carrier")
#	WIFI_SIGNAL=$(iw "$WIFI_INTERFACE" link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')
#	WIFI_SSID=$(iw "$WIFI_INTERFACE" link | grep 'SSID' | sed 's/SSID: //')
#	if [[ $WIRED_CONNECTION -eq 1 ]]; then
#		net_status="Wired"
#	elif [[ $(iw "$WIFI_INTERFACE" link) != "Not connected." ]]; then
#		net_status="$WIFI_SSID"
#	else
#		net_status="disconnected"
#	fi
#	time_status="$(date '+%I:%M %p')"
#	echo -e "%{r} ($net_status)    $bat_status    $time_status           "
#	sleep 5;
#done | lemonbar -n "lmenu2" -f "$font1" -f "$font2" -f "$font3" -f "$font4" -g x24 2> /dev/null | sh & 
#
## TAGS
#for i in $(seq 0 1 3); do
#	herbstclient -i |
#	while read line; do
#		case $line in
#		tag_changed*|reset*)
#		tag=$(herbstclient list_monitors | grep '\[FOCUS\]' | cut -d'"' -f2)
#		if [ $tag -eq $(($i+1)) ]; then
#			tag_color="#EF2E31"
#		else
#			tag_color="#222222"
#		fi
#		;;
#		esac
#		echo -e "%{B$tag_color}         "
#	done | $panel -f "$font_mono" -b -g 50x5+$(($i*60+20)) -n lemon_tag_$(($i+1)) eDP-1 2> /dev/null | sh &
#done

#herbstclient emit_hook reset

# SOUND
#herbstclient -i |
#while read line; do
#        case $line in
#		sound*|reset*)
#		sleep 0.1
#		vol=$(amixer get Master | egrep -o "[0-9]+%" | egrep -o "[0-9]*")
#		vol_s=$(amixer get Master | grep "Front Left:" | awk '{ print $6 }')
#		if [ $vol_s == "[off]" ]; then
#			vol="0"
#		fi
#		;;
#	esac
#        echo -e "%{c}$vol"
#done | $panel -f "$font_mono" -g 80x50+230 -n 'lemon_sound' eDP-1-1 2> /dev/null | sh &
