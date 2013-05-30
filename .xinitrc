gnome-settings-daemon &
eval `ssh-agent`
eval `gnome-keyring-daemon`
xmodmap ~/.Xmodmap &
nm-applet &
xscreensaver -nosplash &
mpd ~/.mpdconf &
fetchmail &
ck-launch-session awesome
