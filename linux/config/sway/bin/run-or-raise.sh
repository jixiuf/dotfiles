class=$1
# 获取除第1个参数外的所有参数
shift 1
cmd="$@"
appinfo=`swaymsg -t get_tree | jq -r "recurse(.nodes[], .floating_nodes[]) | select(.window_properties.class==\"${class}\")"`
if [ ! "$appinfo" ]; then
    $cmd;
else
    isfocused=`echo $appinfo|jq -r '.focused'`
    if [  $isfocused == "false" ]; then
        swaymsg "[class=\"${class}\"] focus"
    fi
fi