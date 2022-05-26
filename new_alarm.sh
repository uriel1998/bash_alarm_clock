#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/1000"
#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/

# GET CONFIG DIRECTORY
# GET DIRECTORY FOR PID FILES


DOW=""
case "$(date +%w)" in 
  0) DOW="U";;
  1) DOW="M";;
  2) DOW="T";;
  3) DOW="W";;
  4) DOW="R";;
  5) DOW="F";;
  6) DOW="S";;
esac


kill_alarms() {
    if [ "${1}" == "all" ];then
        # loop through .pid files and kill them all, clean up pid files
    else
        # match string (as group name) with string.pid, kill those, clean up pid files
    fi
}

create_alarm() {
    
    Alarm_Group=$(echo "${1}" | awk -F ';' 'print {3}')
    Command=$(echo "${1}" | awk -F ';' 'print {4}')
    eval "${Command}"
    echo $! >> ${CONFIG_DIR}/${Alarm_Group}.pid
}




if [ "${1}" == "-k" ];then 
    kill_alarms "${2}"
else
    #get_minute
    NowTime=$(date +"%H%M")
    RC_Match_String=sed -n '/^$NowTime/p' ${RC_FILE}
    # separate out if multi-line and run create alarm once per line
    while IFS= read -r line; do
        rc_dow=$(echo "${line}" | awk -F ';' 'print {2}')
        if [[ $rc_dow == *"$DOW"* ]]; then
            create_alarm $"{line}"
        fi
    done <<< "$RC_Match_String"
fi
