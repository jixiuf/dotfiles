app_id=$1
# 获取除第 1 个参数外的所有参数
# for wayland app
shift 1
cmd="$@"
appinfo=`swaymsg -t get_tree | jq -r "recurse(.nodes[], .floating_nodes[]) | select(.app_id==\"${app_id}\")"`
if [ ! "$appinfo" ]; then
    $cmd;
else
    isfocused=`echo $appinfo|jq -r '.focused'`
    if [  $isfocused == "false" ]; then
        swaymsg "[app_id=\"${app_id}\"] focus"
    fi
fi