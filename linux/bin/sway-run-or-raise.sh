# arg1: app_id or class
# arg2: command
# demo:
#
# $target= app_id for wayland or class for x11
target=$1
# 转成小写
target=`echo $target|tr '[:upper:]' '[:lower:]'`
# 获取除第 1 个参数外的所有参数
shift 1
cmd="$@"
#
appinfo=`swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select( ((.app_id // "")|ascii_downcase == "'"$target"'") or ((.window_properties.class  // "")|ascii_downcase == "'"$target"'"))'`
if [ ! "$appinfo" ]; then
    # if app not found ,run the cmd
    $cmd &
    sleep 1                   # wait starting
    # after starting , focus the new started window
    appinfo=`swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) | select( ((.app_id // "")|ascii_downcase == "'"$target"'") or ((.window_properties.class  // "")|ascii_downcase == "'"$target"'"))'`
    app_id=`echo $appinfo|jq -r '(.app_id // "")'|head -n 1`
    class=`echo $appinfo|jq -r '(.window_properties.class // "")'|head -n 1`
    if [ -z "$app_id" ]; then # no app_id,x11 window
        swaymsg "[class=\"${class}\"] focus"
    else                    # wayland window
        swaymsg "[app_id=\"${app_id}\"] focus"
    fi
else
    # frontappinfo=`swaymsg -t get_tree | jq -r 'recurse(.nodes[], .floating_nodes[]) |select(.focused)'`
    isfocused=`echo $appinfo|jq -r '.focused'|head -n 1`
    # jq 的(.app_id // "") 表示取 app_id 若无此字段则为空串
    app_id=`echo $appinfo|jq -r '(.app_id // "")'|head -n 1`
    class=`echo $appinfo|jq -r '(.window_properties.class // "")'|head -n 1`
    id=`echo $appinfo|jq -r '(.id // 0)'|head -n 1`
    type=`echo $appinfo|jq -r '.type'|head -n 1` # con or floating_con
    # fullscreen_mode=`echo $appinfo|jq -r '.fullscreen_mode'|head -n 1`
    # is_mark_floating=`echo $appinfo|jq ".marks[] | select(. == \"sway-run-or-raise:floating_con:$id\") |true"`
    # is_mark_fullscreen=`echo $appinfo|jq ".marks[] | select(. == \"sway-run-or-raise:fullscreen:$id\") |true"`
    # scratchpad=$(echo "$tree" | jq '.nodes[].nodes[] | select(.name=="__i3_scratch")')
    # scratchpadids=$(echo "$scratchpad" | jq -r '.floating_nodes[].id')
    # # 如果此 window 是在 scratchpad 中的一个，则将其移到当前窗口
    # if echo "$ids" | grep -q "$1"; then
    #     swaymsg  "[con_id=$id] move window to workspace current"
    # fi
    #
    if [  $isfocused == "false" ]; then
        if [ -z "$app_id" ]; then # no app_id,x11 window
            swaymsg "[class=\"${class}\"] focus"
        else                    # wayland window
            swaymsg "[app_id=\"${app_id}\"] focus"
        fi
        # if [ "$is_mark_floating" != "true" ]; then # 如果原来不是 floating，则将期恢复原状
        #     swaymsg floating disable
        #     swaymsg unmark "sway-run-or-raise:floating_con:$id"
        # fi
        # if [ "$is_mark_fullscreen" == "true" ]; then # 如果原来是 fullscreen
        #     swaymsg fullscreen enable
        #     swaymsg unmark "sway-run-or-raise:fullscreen:$id"
        # fi
    else

        # type =con or floating_con 来区分窗口是不是浮动窗口，以便
        if [ "$type" == "floating_con" ]; then
            ## （放进 scrtchpad 后都变成活动窗口了，故 mark 其原始 type）
            # swaymsg mark "sway-run-or-raise:floating_con:$id"
            swaymsg  "[con_id=$id] move window to scratchpad"
        else
            # 需要与 bin/sway-track-prev-focus  的配合使用
            # 如果目标窗口已经是当前窗口,且不是 floating，则将焦点转到上一次聚焦的窗口，
            swaymsg '[con_mark=_prev_con] focus'
        fi
        # if [ "$fullscreen_mode" == "1" ]; then
        #     swaymsg mark "sway-run-or-raise:fullscreen:$id"
        # fi
        # # swaymsg '[con_name="Term"] mark my-terminal'
    fi
fi