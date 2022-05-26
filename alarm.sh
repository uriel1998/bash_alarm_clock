#!/bin/bash

#Changing this process to idle io priority
#https://friedcpu.wordpress.com/2007/07/17/why-arent-you-using-ionice-yet/
ionice -c3 -p$$


export XDG_RUNTIME_DIR="/run/user/1000"
#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/

Weekend="False"

case "$(date +%a)" in 
  Sat|Sun) Weekend="True";;
esac

if [ "$1" = "-h" ];then
    echo "Edit the script to play the stuff you want at the time you want."
    echo "Call it from cron at the appropriate time and it'll hit the case right."
    echo "-km - kill the music ones"
    echo "-ka - kill all"
fi


if [ -z "$1" ];then 
    NowTime=$(date +"%H%M")
else
    NowTime="$1"
fi

#mplayer commandline tweaked via https://itectec.com/ubuntu/ubuntu-help-using-crontab-to-play-a-sound/

if [ "$Weekend" = "False" ]; then
    case "$NowTime" in
            "0600")
                /usr/bin/mplayer -ao pulse -volume 100 -really-quiet "/home/steven/documents/background_tunes/relax/01-simon slator-antarctica.mp3" &
                echo $! >/tmp/alarm_1.pid
            ;;
            "0545") 
                /home/steven/scripts/briefing.sh
                /usr/bin/mplayer -ao pulse -volume 100 -really-quiet -playlist "/home/steven/briefing/play.m3u" &
                echo $! >/tmp/alarm_2.pid
            ;;
            "0650")     
                /usr/bin/mplayer -ao pulse -volume 100 -really-quiet -loop 5 "/home/steven/music/the essential nilsson/01-harry nilsson-gotta get up.mp3" &
                echo $! >/tmp/alarm_3.pid
            ;;
            "0655") 
                /usr/bin/mplayer -ao pulse -volume 100 -really-quiet -loop 5 "/home/steven/music/goru bihu song/rainbow trip-goru bihu song.mp3" &
                echo $! >/tmp/alarm_4.pid
            ;;
            "-km")
                kill -9 $(cat /tmp/alarm_1.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_3.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_4.pid) &> /dev/null
                rm /tmp/alarm_1.pid
                rm /tmp/alarm_3.pid
                rm /tmp/alarm_4.pid
            ;;
            "-ka")
                kill -9 $(cat /tmp/alarm_1.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_2.pid) &> /dev/null            
                kill -9 $(cat /tmp/alarm_3.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_4.pid) &> /dev/null
                rm /tmp/alarm_1.pid
                rm /tmp/alarm_2.pid
                rm /tmp/alarm_3.pid
                rm /tmp/alarm_4.pid
            ;;
    esac
else
    case "$1" in
            "km")
                kill -9 $(cat /tmp/alarm_1.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_3.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_4.pid) &> /dev/null
            ;;
            "ka")
                kill -9 $(cat /tmp/alarm_1.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_2.pid) &> /dev/null            
                kill -9 $(cat /tmp/alarm_3.pid) &> /dev/null
                kill -9 $(cat /tmp/alarm_4.pid) &> /dev/null
            ;;
    esac
fi
