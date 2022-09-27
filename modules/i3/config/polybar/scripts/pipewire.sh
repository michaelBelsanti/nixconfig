#!/usr/bin/env bash

function main() {
    DEFAULT_SOURCE=$(pw-record --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: description="\(.*\)" prio=[[:digit:]]\+$/\1/p')
    DEFAULT_SINK_ID=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*\([[:digit:]]\+\):.*$/\1/p')
    DEFAULT_SINK=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: description="\(.*\)" prio=[[:digit:]]\+$/\1/p')
    VOLUME=$(pamixer --get-volume-human)

    action=$1
    if [ "${action}" == "up" ]; then
        pamixer --increase 10
    elif [ "${action}" == "down" ]; then
        pamixer --decrease 10
    elif [ "${action}" == "mute" ]; then
        pamixer --toggle-mute
    else
        echo " ${DEFAULT_SOURCE} |  ${VOLUME} ${DEFAULT_SINK}"
    fi
}

main "$@"
