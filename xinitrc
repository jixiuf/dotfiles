#pcmanfm --desktop -d  &
#exec ck-launch-session dbus-launch openbox-session 
#exec  openbox-session 

#mplayer /resource/system/audio/start_music.mp3 &
#mplayer /video/m.flv -rootwin -vf scale=1280:800 -loop 0 -ao /dev/null  -noconsolecontrols   &

#exec startlxde
#fictx &
xrdb ~/.Xdefaults
#xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &
if [ `pgrep -u ${USER} urxvtd |wc -l` = 0  ] ; then      urxvtd -q -f -o & fi
if [ `pgrep -u root urxvtd |wc -l` = 0  ] ;    then sudo urxvtd  -q -f -o & fi
#/usr/bin/emacs &
#echo "hide_emacs()" |awesome-client
xmodmap ~/.Xmodmaprc &
ck-launch-session awesome 
#exec awesome
