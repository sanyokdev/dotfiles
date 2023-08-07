if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -le 2 ]; then
    exec startx
fi
