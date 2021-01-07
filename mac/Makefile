# -*- coding:utf-8 -*-
.PHONY: deploy
PWD := `pwd`
LINK_CMD := ln -s -f

global_version_in_config := `head -n 1 globalrc|sed "s/\#//g"`
global_version := `ls /usr/local/Cellar/global|sort -r|head -n 1`

deploy:
	echo "$(global_version)"
	echo "$(global_version_in_config)"
# @-$(LINK_CMD) $(PWD)/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
	@-mkdir -p  ~/Library/LaunchAgents/
	@-mkdir -p /usr/local/etc/
	if [ -d /usr/local/Cellar/global ];then  \
		sed -i "" "s/$(global_version_in_config)/$(global_version)/g" globalrc; \
	fi

	@-$(LINK_CMD) $(PWD)/globalrc ~/.globalrc
# @-$(LINK_CMD) $(PWD)/../pentadactylrc_mac ~/.pentadactylrc
	@-$(LINK_CMD) $(PWD)/../proxychains.conf /usr/local/etc/
	@-$(LINK_CMD) $(PWD)/../tsocks.conf /usr/local/etc/
	@-$(LINK_CMD) $(PWD)/LaunchAgents/git_pull_master.sh ~/Library/LaunchAgents/git_pull_master.sh
	@-$(LINK_CMD) $(PWD)/LaunchAgents/git_pull_master.plist ~/Library/LaunchAgents/
	@-$(LINK_CMD) $(PWD)/LaunchAgents/midnight.sh ~/Library/LaunchAgents/midnight.sh
	@-$(LINK_CMD) $(PWD)/LaunchAgents/midnight.plist ~/Library/LaunchAgents/
	@-$(LINK_CMD) $(PWD)/LaunchAgents/autosshD_ssh_port.plist ~/Library/LaunchAgents/autosshD_ssh_port.plist
# @-$(LINK_CMD) $(PWD)/LaunchAgents/emacs-daemon.plist ~/Library/LaunchAgents/emacs-daemon.plist
# @-$(LINK_CMD) $(PWD)/LaunchAgents/autosshD.plist ~/Library/LaunchAgents/autosshD.plist
# @-$(LINK_CMD) $(PWD)/LaunchAgents/brew-update.plist ~/Library/LaunchAgents/brew-update.plist
# @-$(LINK_CMD) $(PWD)/LaunchAgents/cow.plist ~/Library/LaunchAgents/cow.plist
#	@-$(LINK_CMD) $(PWD)/LaunchAgents/memcached.plist ~/Library/LaunchAgents/
#	@-mkdir -p  $$HOME/Library/Application\ Support/Karabiner/
#@-$(LINK_CMD) $(PWD)/Karabiner/private.xml $$HOME/Library/Application\ Support/Karabiner/private.xml
# @-$(LINK_CMD) $(PWD)/LaunchAgents/autoproxy.plist ~/Library/LaunchAgents/
# if [ -f ~/jenkins.war ]; then \
# 	$(LINK_CMD) $(PWD)/LaunchAgents/jenkins.plist ~/Library/LaunchAgents/;\
# fi
	defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
	defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)


# @-$(LINK_CMD) $(PWD)/karabiner.d ~/.karabiner.d
	@-mkdir -p ~/.config/
	@-rm  -rf ~/.config/karabiner
	@-$(LINK_CMD) $(PWD)/karabiner ~/.config/karabiner
	@-$(LINK_CMD) $(PWD)/fish ~/.config/fish
# @-cp -f com.apple.HIToolbox.plist ~/Library/Preferences/

	@-rm -rf $$HOME/.hammerspoon
	@-$(LINK_CMD) $(PWD)/hammerspoon $$HOME/.hammerspoon

	@-mkdir -p ~/.cow
	@-$(LINK_CMD) $(PWD)/cowrc ~/.cow/rc
#emacs 中使用term
# 如果你使用的是mac系统，发现multi-term每行出出了4m，在shell里运
# 行下：tic -o ~/.terminfo
# /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti
	@-rm -rf ~/.terminfo
	@-$(LINK_CMD) $(PWD)/terminfo ~/.terminfo

	@make -C rime_input_method/
	@mkdir -p ~/bin
# @-$(LINK_CMD) $(PWD)/squirrel_toggle_option $$HOME/bin

# Enable apps at startup
#
# osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
# osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:true}' > /dev/null

#调整keyrepeat
# defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
# defaults write -g KeyRepeat -int 1.5 # normal minimum is 2 (30 ms)

sudo:
#-$(LINK_CMD) $(PWD)/environment.conf /etc/environment
#	-$(LINK_CMD) $(PWD)/mac-yosemate-set-env.plist /Library/LaunchAgents/mac-yosemate-set-env.plist
	-$(LINK_CMD) $(PWD)/LaunchAgents/limit.plist /Library/LaunchDaemons/limit.plist
	-$(LINK_CMD) $(PWD)/LaunchAgents/limit_proc.plist /Library/LaunchDaemons/limit_proc.plist
	chown root:wheel /Library/LaunchDaemons/limit.plist
	chown root:wheel /Library/LaunchDaemons/limit_proc.plist
	@rm -rf $(PWD)/applescript/EmacsClient.app
	@tar -xf $(PWD)/applescript/EmacsClient.app.tar.gz -C $(PWD)/applescript/
	@-$(LINK_CMD) $(PWD)/applescript/EmacsClient.app /Applications/
	@rm -rf $(PWD)/applescript/EmcacClientOpenWith-InIterm2.app
	@tar -xf $(PWD)/applescript/EmcacClientOpenWith-InIterm2.app.tar.gz -C $(PWD)/applescript/
	@-$(LINK_CMD) $(PWD)/applescript/EmcacClientOpenWith-InIterm2.app /Applications/
# @-mkdir -p /Library/Application\ Support/org.pqrs/config
# @-$(LINK_CMD) $(PWD)/karabiner/karabiner.json /Library/Application\ Support/org.pqrs/config/karabiner.json
	launchctl limit maxfiles 100000 100000
	launchctl limit maxproc 20000 20000
	sudo rm -f  /etc/zprofile
