#!/bin/bash
#
#   Bash Alarm Clock - make a cool acronym
#
# by Steven Saus

########################################################################
# Initialize
########################################################################

init (){
# Music Player

# Display Variable (if needed)

# source files (if needed)

# snooze length

#existence of alarm.rc
    AlarmRc
}


##############################################################################
# Show help
########################################################################

show_help (){
    
	echo "usage: bash_alarm.sh [-h][-c][-y]"
	echo " "
	echo "Download and display album art or display embedded album art"
	echo " "
	echo "optional arguments:"
	echo "   -h     show this help message and exit"
-z (optional) Snooze for length
-s (optional) Skip all alarms for length
-a Add new alarm
-d Delete an alarm

}


##############################################################################
# Get alarms from alarm RC or create blank template if needed
########################################################################


get_alarms () {  
    if [ -f "$AlarmRc" ]; then
        IFS=$';' Alarm_Array=( $(cat "$AlarmRc" | awk '!/^ *#/ { print; }') );
    else
        echo "########################################################################" > "$AlarmRc"
        echo "# Alarms" >> "$AlarmRc"
        echo "########################################################################" >> "$AlarmRc"
        echo "#TIME;DOW[MTWRFSS];NUMRUNS[0-10];ALARM_GROUP;[MUSIC|SCRIPT]" >> "$AlarmRc"
}

list_alarms (){
    
    counter="${#Alarm_Array[@]}"
    if [ $counter -gt 0 ]; then  #not sure if this is right or if it should be -z 
        #for ZERO TO COUNTER LIST THEM OUT HERE
        #TIME;DOW[MTWRFSS];NUMRUNS[0-10];ALARM_GROUP;[MUSIC|SCRIPT]    
    else
        echo "No alarms defined"
}

get_currtime (){
    NowTime=$(date +"%H%M")
}

snooze_alarms (){
    
}

enter_skip (){
    
}

remove_skip (){
    
}

enter_alarm (){
    
}

remove_alarm (){
    
}

stop_group1 (){
    
}

stop_group2 () {
    
}

stop_group3 () {
    
}

stop_group4 () {
    
}

stop_all () {
    stop_group1
    stop_group2
    stop_group3
    stop_group4
}

stop_for_day () {
    stop_all
    enter_skip #for rest of today?
    
}

run_alarm (){
    
}

main (){
    
}
