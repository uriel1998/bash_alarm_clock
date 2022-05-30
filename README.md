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

The `briefing.sh` script is described on my blog [how to get a daily briefing](https://ideatrash.net/2019/01/get-a-daily-briefing-without-big-brother.html).


## 2. License

This project is licensed under the MIT license. For the full license, see `LICENSE`.

## 3. Prerequisites

### These may already be installed on your system.

* `kill` can be found on major Linux distributions.
* `pkill` can be found on major Linux distributions.
* `date` can be found on major Linux distributions.
* `sed` can be found on major Linux distributions.
* `ls` can be found on major Linux distributions.
* `cronic` to reduce cron's email output, found [here](https://habilis.net/cronic/)

### Useful tools to use with this alarm clock.

 * `mplayer` command-line tool for playing media. `mplayer` can be found on major Linux distributions.
 * `podfox` command-line tool for podcasts, found [here](https://github.com/brtmr/podfox)
 * `gnome-schedule` if you aren't comfy with `crontab -e`, found [here](https://sourceforge.net/projects/gnome-schedule/)
 
## 4. Configuration

### Configuration file

Edit the RC file and put it in $HOME/.config/bash_alarm to put your alarms there in the format:

`24 HOUR TIME;DAY OF WEEK[UMTWRFS];ALARM GROUP;[COMMAND]`

e.g.

`0530;MTWRF;music;/usr/bin/mplayer -noconsolecontrols -ao pulse -volume 100 -really-quiet -loop 5 "~/alarm.mp3" &`

Would use mplayer to play an alarm at 5:30 AM every weekday, and

`1400;US;music;/usr/bin/mplayer -noconsolecontrols -ao pulse -volume 100 -really-quiet -loop 5 "~/wave_sounds.mp3" &`

would use mplayer to play a different wave-crashing sound at 2:00 PM on Sunday and Saturday.

The semicolon is the dividing mark; your command should **NOT** have a semicolon in it. Right now, that means calling something like `briefing.sh` a minute or two before the playing command.

### Crontab change

Edit your crontab using either `crontab -e` or a tool like [gnome-schedule](https://sourceforge.net/projects/gnome-schedule/) to call the script once a minute with the `-c` command line variable, e.g.

`* * * * * * /usr/bin/cronic /PATH/TO/bash_alarm.sh -c` 

### Notes about setting up alarms

I added `export XDG_RUNTIME_DIR="/run/user/1000"` to the alarm script to solve a problem [raised and solved here about running audio apps from cron](#https://web.archive.org/web/20080617195246/http://grimthing.com/archives/2004/01/23/cron-mp3-alarm-clock/).

If you have problems with `mplayer` not playing, try using `-noconsolecontrols` as an argument.


## 5. Usage

* Running a check

Run `bash_alarm.sh -c`, either from `cron` or the commandline. 

Both of these commands are intentionally slightly cumbersome, because this is 
being used as an *alarm* clock...

* Stopping alarms

Run `bash_alarm.sh -k [all|group name]`. If you specify *all*, you do not need to
specify any other group name. Otherwise, it will *only* kill alarms that are part 
of the named group.

* Snoozing alarms

Run `bash_alarm.sh -s [all|group name] [snooze time in minutes]`. If you specify 
*all*, you do not need to specify any other group name. Otherwise, it will *only* 
snooze alarms that are part of the named group. The snooze time should *only* be 
a whole number. If no number is specified, the snooze time is set to 5.

## 6. Todo

 * Way to non-manually add single-time alarms
 * How to skip alarm for next day
 * GUI (or at least non-programatically editing) interface
