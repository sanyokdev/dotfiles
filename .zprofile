if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -le 2 ]; then
    exec startx > ~/startx.log 2>&1
fi