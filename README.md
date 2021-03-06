# bash_alarm_clock
A fully featured bash alarm clock leveraging cron

## Contents
 1. [About](#1-about)
 2. [License](#2-license)
 3. [Prerequisites](#3-prerequisites)
 4. [How to use](#4-how-to-use)
 5. [TODO](#5-todo)

***
 
## 1. About

This is a program greatly indebted to various cron alarm clocks like [this one](https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/),
 though it has some features that those simple ones don't have.

Quite simply, the script should be called from `cron` at the appropriate times 
that it triggers the case statements in the script.  If you use the -km switch, 
it will kill the music related alarms, if you use the -ka switch it will kill all 
alarms.

This script is more of a framework than a finished project.  Be aware.

The `briefing.sh` script is described on my blog [how to get a daily briefing](https://ideatrash.net/2019/01/get-a-daily-briefing-without-big-brother.html).

The various songs that are mentioned in the script can be found below:

[Antartica](https://archive.org/details/jamendo-001358)
[Gotta Get Up](https://amzn.to/2XFrpcw)
[Goru Bihu Song](https://www.youtube.com/watch?v=UPHRDTWlMh4)

## 2. License

This project is licensed under the MIT license. For the full license, see `LICENSE`.

## 3. Prerequisites

### These may already be installed on your system.

 * `mplayer` command-line tool for playing media. `mplayer` can be found on major Linux distributions.

### You may have to install these

 * `podfox` command-line tool for podcasts, found [here](https://github.com/brtmr/podfox)
 * `gnome-schedule` if you aren't comfy with `crontab -e`, found [here](https://sourceforge.net/projects/gnome-schedule/)
 * `cronic` to reduce cron's email output, found [here](https://habilis.net/cronic/)

## 4. How to use

 * Edit the script so that the case statements match the times (and events) you want.
 * Edit your crontab using either `crontab -e` or a tool like [gnome-schedule](https://sourceforge.net/projects/gnome-schedule/) to call the script at the appropriate times. 
 * NO ARGUMENTS ARE NEEDED FOR THE ALARM FUNCTIONS, ONLY TO STOP THE ALARMS.
 
 For example, my crontab has this section:

``` 

14 0 6 * * 1-5 /usr/bin/cronic /home/steven/bin/alarm                                                                                                         
15 30 6 * * 1-5 /usr/bin/cronic /home/steven/bin/alarm  
16 55 6 * * 1-5 /usr/bin/cronic /home/steven/bin/alarm   
17 0 7 * * 1-5 /usr/bin/cronic /home/steven/bin/alarm   

``` 

 Which calls the alarms in the case statement
 
 #Note: I added 
`export XDG_RUNTIME_DIR="/run/user/1000"`
to solve a problem [raised and solved here about running audio apps from cron](#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/)


## 5. Todo

 * Have weekends be a bit more intuititive
 * GUI (or at least non-programatically editing) interface
