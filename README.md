# bash_alarm_clock
A fully featured bash alarm clock leveraging cron

## Contents
 1. [About](#1-about)
 2. [License](#2-license)
 3. [Prerequisites](#3-prerequisites)
 4. [Configuration](#4-configuration)
 5. [Usage](#5-usage)
 6. [TODO](#6-todo)

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

* `kill`
* `pkill`
* `date`
* `sed`
* `ls`

 * `mplayer` command-line tool for playing media. `mplayer` can be found on major Linux distributions.

### You may have to install these

 * `podfox` command-line tool for podcasts, found [here](https://github.com/brtmr/podfox)
 * `gnome-schedule` if you aren't comfy with `crontab -e`, found [here](https://sourceforge.net/projects/gnome-schedule/)
 * `cronic` to reduce cron's email output, found [here](https://habilis.net/cronic/)

## 4. Configuration

* Edit the RC file and put it in $HOME/.config/bash_alarm to put your alarms there in the format:

`TIME;DOW[UMTWRFS];ALARM_GROUP;[COMMAND]`

e.g.

`0530;MTWRF;music;/usr/bin/mplayer -noconsolecontrols -ao pulse -volume 100 -really-quiet -loop 5 "~/alarm.mp3" &`

The semicolon is the dividing mark; your command should **NOT** have a semicolon in it. 

 * Edit your crontab using either `crontab -e` or a tool like [gnome-schedule](https://sourceforge.net/projects/gnome-schedule/) to call the script once a minute with the `-c` command line variable, e.g.

`* * * * * * /usr/bin/cronic /PATH/TO/bash_alarm.sh -c` 
   
 #Note: I added 
`export XDG_RUNTIME_DIR="/run/user/1000"`
to solve a problem [raised and solved here about running audio apps from cron](#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/)

*Use -noconsolecontrols with mplayer!*

## 5. Usage

* Running a check



* Stopping alarms
* Snoozing alarms

## 6. Todo

 * Way to non-manually add single-time alarms
 * How to skip alarm for next day
 * GUI (or at least non-programatically editing) interface
