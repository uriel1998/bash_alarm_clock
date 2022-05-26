#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/1000"
#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/

# GET CONFIG DIRECTORY
# GET DIRECTORY FOR PID FILES

kill_alarms() {
    if [ "${1}" == "all" ];then
        # loop through .pid files and kill them all, clean up pid files
    else
        # match string (as group name) with string.pid, kill those, clean up pid files
    fi
}

create_alarm() {
    # already read the rc file, have this string fed directly to the 
    # and parse with awk
    #TIME;DOW[MTWRFSS];ALARM_GROUP;[MUSIC|SCRIPT|COMMAND]
    # launch the command 
    # use $! to capture the PID
    # echo $! > /tmp/alarm_2.pid
    # create (or append to) $ALARM_GROUP.pid 
}


if [ "${1}" == "-k" ];then 
    kill_alarms "${2}"
else
    #get_minute
    NowTime=$(date +"%H%M")
    RC_Match_String=sed -n '/^$NowTime/p' ${RC_FILE}
    # separate out if multi-line and run create alarm once per line
    #check_time_vs_ini
        create_alarm ${THE STRING FROM THE RC FILE}
        #play alarm
