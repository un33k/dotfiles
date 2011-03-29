#!/bin/sh
DISPLAY=:0.0 dmenu_path | dmenu_run -b -p '$' -nb '#000' -nf '#fff' -sb green -sf black
