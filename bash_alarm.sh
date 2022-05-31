#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/1000"
#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/

ConfigDir=${XDG_CONFIG_HOME:-$HOME/.config}/bash_alarm
if [ ! -d ${ConfigDir} ]; then
    mkdir -p ${ConfigDir}
fi
ConfigFile=$ConfigDir/bash_alarm.rc
StateDir=${XDG_STATE_HOME:-$HOME/.local/state}/bash_alarm
if [ ! -d ${StateDir} ]; then
    mkdir -p ${StateDir}
fi

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

end_processes(){
### Reads PID file, uses KILL to kill processes
    local kill_bin=$(which kill)
    pidfile="${1}"
    pidstring=$(cat "${pidfile}")
    while IFS= read -r line; do
        eval ${kill_bin} ${line}
    done <<< "${pidstring}"
    rm "${pidfile}"
}

kill_alarms() {
### select groups of alarms and feed the PID file to the kill function
    if [ "${1}" == "all" ];then
        for file in $(/usr/bin/ls -A "${StateDir}"/*.pid)
        do
            end_processes ${file}
        done
    else
        if [ -f "${StateDir}"/"${1}".pid ];then
            end_processes "${StateDir}"/"${1}".pid
        fi
    fi
}

snooze_processes(){
### Reads PID file, uses PKILL to issue STOP command then writes those PIDs to a new HHMM.sleep file
    local pkill_bin=$(which pkill)
    pidfile="${1}"
    pause_time="${2}"
    eval ${pkill_bin} -STOP -F ${pidfile}
    local FutureTime=$(date --date="${pause_time} minutes" +"%H%M")
    cat "${pidfile}" >> ${StateDir}/${FutureTime}.sleep
    rm "${pidfile}"
}

snooze_alarms() {
### Select groups of alarms and feed the PID file to the snooze function
    pause_time="${2}"
    if [ -z $pause_time ];then
        pause_time=5
    fi
    if [ "${1}" == "all" ];then
        for file in $(/usr/bin/ls -A "${StateDir}"/*.pid)
        do
            snooze_processes ${file} ${pause_time}
        done
    else
        if [ -f "${StateDir}"/"${1}".pid ];then
            snooze_processes "${StateDir}"/"${1}".pid ${pause_time}
        fi
    fi
}


wake_alarms() {
### Reads PID file, uses PKILL to issue STOP command then writes those PIDs to a new HHMM.sleep file
    local pkill_bin=$(which pkill)
    pidfile="${1}"
    eval ${pkill_bin} -CONT -F ${pidfile}
    rm "${pidfile}"    
}

create_alarm() {
### Activates the alarm command and writes the spawned processes' PIDs to a groupfile    
    Alarm_Group=$(echo "${1}" | awk -F ';' 'print {3}')
    Command=$(echo "${1}" | awk -F ';' 'print {4}')
    eval "${Command}"
    echo $! >> ${StateDir}/${Alarm_Group}.pid
}

cleanup_check(){
### Loops through PID files and sees if there are any that no longer exist (and then rewrites them?)
### TODO - I need a cleanup check for processes that have exited normally! 
}


alarm_check() {
### Determine if alarm is set to go, or if HHMM.sleep files exist for this time, and run them
    NowTime=$(date +"%H%M")
    RC_Match_String=sed -n '/^$NowTime/p' ${RC_FILE}
    # separate out if multi-line and run create alarm once per line
    while IFS= read -r line; do
        rc_dow=$(echo "${line}" | awk -F ';' 'print {2}')
        if [[ $rc_dow == *"$DOW"* ]]; then
            create_alarm $"{line}"
        fi
    done <<< "$RC_Match_String"
    if [ -f ${StateDir}/${NowTime}.sleep ];then
        wake_alarms "${StateDir}/${NowTime}.sleep"
    fi
    # one time alarms should be with .alarm extension and format group;command
    if [ -f ${StateDir}/${NowTime}.alarm ];then
        while IFS= read -r line; do
            line=";;${line}"
            create_alarm $"{line}"
        done <<< "${StateDir}/${NowTime}.alarm"
        rm "${StateDir}/${NowTime}.alarm"
    fi
    cleanup_check
}

show_help () {
### Show the help
    echo "-c should be run for when checked by cron"
    echo "-h is this"
    echo "-s [all|alarm_group] [mins] - snooze that group of alarms"
    echo "-k [all|alarm_group] - kill existing alarms"
}


### only checking cleanup with alarm_check to avoid weird conflicts
### the main process
case "${1}" in 
    -k) kill_alarms "${2}" ;;
    -s) snooze_alarms "${2}" "${3}";;
    -h) show_help ;;
    -c) alarm_check ;;
    *) show_help ;;
esac

exit



