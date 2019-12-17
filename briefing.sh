#!/bin/bash

#Changing this process to idle io priority
#https://friedcpu.wordpress.com/2007/07/17/why-arent-you-using-ionice-yet/
ionice -c3 -p$$

#Uncomment to remove all old briefings
rm -rf ~/briefing/*

/usr/local/bin/podfox -c ~/.podfox.json update
/usr/local/bin/podfox -c ~/.podfox.json download
today=`date +%Y%m%d`
mkdir -p ~/briefing/$today




find ~/podcasts -name '*.mp3' -exec mv {} ~/briefing/$today \;


#https://askubuntu.com/questions/259726/how-can-i-generate-an-m3u-playlist-from-the-terminal

# This does not seem to work with ~/ for $HOME, so I've put the full user
# path here.
playlist='/home/steven/briefing/play.m3u' ; if [ -f $playlist ]; then rm $playlist ; fi ; for f in /home/steven/briefing/$today/*.mp3; do echo "$f" >> "$playlist"; done


