#!/bin/dash

interval=0


cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
  printf "cpu: %s" "$cpu_val"
}

#pkg_updates() {
  #updates=""
	#updates=$(doas xbps-install -un | wc -l) # void
	# updates=$(checkupdates | wc -l)   # arch
	# updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

	#if [ -z "$updates" ]; then
		#printf "  ^c$green^    Fully Updated"
	#else
		#printf "  ^c$green^    $updates"" updates"
	#fi
#}

battery() {
	get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
	printf "   %s" "$get_capacity"
}

brightness() {
	printf "  %s " "$(cat /sys/class/backlight/*/brightness)"
}

mem() {
	printf "  %s" "$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "wlan:  Connected" ;;
	down) printf "wlan:  Disconnected" ;;
	esac
}

clock() {
	printf "%s" "$(date '+%H:%M')"
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ]
	interval=$((interval + 1))

	sleep 1 && xsetroot -name  "$(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
done
