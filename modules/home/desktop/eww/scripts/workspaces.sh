#!/bin/sh

workspaces() {
    ws1=1
    ws2=2
    ws3=3
    ws4=4
    ws5=5
    ws6=6
    # Unoccupied
    un="0"

    # check if Occupied
    o1=$(bspc query -D -d .occupied --names | grep "$ws1")
    o2=$(bspc query -D -d .occupied --names | grep "$ws2")
    o3=$(bspc query -D -d .occupied --names | grep "$ws3")
    o4=$(bspc query -D -d .occupied --names | grep "$ws4")
    o5=$(bspc query -D -d .occupied --names | grep "$ws5")
    o6=$(bspc query -D -d .occupied --names | grep "$ws6")

    # check if Focused
    f1=$(bspc query -D -d focused --names | grep "$ws1")
    f2=$(bspc query -D -d focused --names | grep "$ws2")
    f3=$(bspc query -D -d focused --names | grep "$ws3")
    f4=$(bspc query -D -d focused --names | grep "$ws4")
    f5=$(bspc query -D -d focused --names | grep "$ws5")
    f6=$(bspc query -D -d focused --names | grep "$ws6")

    # le spagetti
    content1=""
    content2=""
    content3=""
    content4=""
    content5=""
    content6=""
    if [ "$f1" ]; then
        content1=""
    fi
    if [ "$f2" ]; then
        content2=""
    fi
    if [ "$f3" ]; then
        content3=""
    fi
    if [ "$f4" ]; then
        content4=""
    fi
    if [ "$f5" ]; then
        content5=""
    fi
    if [ "$f6" ]; then
        content6=""
    fi

    echo "(box	:class \"ws\" :orientation \"v\"	:halign \"center\"	:valign \"start\"	 :space-evenly \"false\" :spacing \"-5\" (button :onclick \"bspc desktop -f $ws1\"	:class	\"$un$o1$f1\"	\"$content1\") (button :onclick \"bspc desktop -f $ws2\"	:class \"$un$o2$f2\"	 \"$content2\") (button :onclick \"bspc desktop -f $ws3\"	:class \"$un$o3$f3\" \"$content3\") (button :onclick \"bspc desktop -f $ws4\"	:class \"$un$o4$f4\"	\"$content4\") (button :onclick \"bspc desktop -f $ws5\"	:class \"$un$o5$f5\" \"$content5\" )  (button :onclick \"bspc desktop -f $ws6\"	:class \"$un$o6$f6\" \"$content6\"))"
}

workspaces
bspc subscribe all | while read -r _ ; do
workspaces
done
