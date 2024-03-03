#!/bin/sh

icon_path="$HOME/.config/hypr/icons/video.png"
notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:screeenrecord -u low -i ${icon_path}"

recordings="$HOME/Videos/Recordings"
tmp_dir="${recordings}/.tmp"
tmp_file="${tmp_dir}/.recording"


if [ ! -z $(pgrep wf-recorder) ];
then
    killall -s SIGINT wf-recorder
    while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
    pkill -RTMIN+8 waybar

    if [ -f "${tmp_file}" ]; then
        tmp_file="$(cat $tmp_file)"
        filename="Record_$(date "+%Y-%m-%d-%H-%M-%S").mp4"
        filepath="${recordings}/${filename}"
        saved_to="$HOME/Videos/Recordings/${filename}"

        mv "${tmp_file}" "${filepath}"

        action=$($notify_cmd_shot "Screen Record" "Saved to ${saved_to}" --action " Dired" --action "Play" --action "To Gif")

        if [[ "${action}" == "0" ]]; then
            ec -n $recordings
        elif [[ "${action}" == "1" ]]; then
            xdg-open $saved_to
        elif [[ "${action}" == "2" ]]; then
            gifoutput=$(dirname $saved_to)/$(basename $saved_to ".mp4").gif
            mp4togif $saved_to $gifoutput
            xdg-open $gifoutput
        fi
    fi
else
    ${notify_cmd_shot} "Screen Record" "Not recording!"
fi
