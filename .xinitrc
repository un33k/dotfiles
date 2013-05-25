gnome-settings-daemon &
eval `ssh-agent`
eval `gnome-keyring-daemon`
xscreensaver -nosplash &
nm-applet &
mpd ~/.mpdconf &
xmodmap ~/.Xmodmap &
fetchmail &
ck-launch-session awesome
