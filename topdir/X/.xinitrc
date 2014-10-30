# -*- shell-script -*-
# vim: ft=sh :

feh --bg-tile ~/images/wallpapers/wall.png
xsetroot -cursor_name left_ptr

xrandr --output LVDS1 --primary

xrdb ~/.Xresources

eval `ssh-agent`

if [ -z "$SESSION" ]; then
    SESSION=i3
    ~/.startup &
fi

case $SESSION in
    awesome)
        wmname LG3D; exec awesome ;;
    i3)
        exec i3 ;;
    kde)
        exec startkde ;;
    xmonad)
        exec zsh -c 'exec xmonad'
        ;;
    clfswm)
        cd /home/vifon/src/clfswm/ ; exec ./clfswm ;;
    *)
        exec $SESSION ;;
esac