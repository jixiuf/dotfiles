# -*- coding:utf-8 -*-
.PHONY: deploy
PWD := `pwd`
DIR := `pwd`
DATE := `date +%Y-%m-%d_%H-%M-%S`
LINK_CMD := ln -s -f
# SYS_CONFIG_FILES_LINUX := `echo xremap.yaml`
SYS_CONFIG_FILES_LINUX := `echo `
# SYSTEMD_SERVICE := `echo  xremap.service`
default:
	make deploy
	sudo make sudo

deploy:
	@-mkdir -p ~/bin ~/.cargo/ ~/go/
	@-rm -rf ~/.cargo/bin ~/go/bin
	ln -fs ~/bin/ ~/.cargo/bin
	ln -fs ~/bin/ ~/go/bin
	@-for file in bin/*; do \
		if [ -h ~/$$file ]; then \
		unlink ~/$$file ;\
        fi;\
		if	[ -f $$file ]; then \
			$(LINK_CMD) $(PWD)/$$file ~/$$file ;\
		fi;\
	done

	@-mkdir -p ~/.local/share
	@-for file in local/share/*; do \
		if [ -h ~/.$$file ]; then \
		unlink ~/.$$file ;\
        fi;\
		$(LINK_CMD) $(PWD)/$$file ~/.$$file ;\
	done
	@-mkdir -p ~/.config/
	@-for file in config/*; do \
		if [ -h ~/.$$file ]; then \
		unlink ~/.$$file ;\
        fi;\
		$(LINK_CMD) $(PWD)/$$file ~/.$$file ;\
	done
#	@-mkdir -p ~/.local/share/gnome-shell/extensions
#	if [ ! -d ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ]; then \
#		git clone git@github.com:jixiuf/gnome-magic-window.git  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ;\
#	fi
#	gnome-extensions enable gnome-magic-window@adrienverge

sudo:
	for file in $(SYS_CONFIG_FILES_LINUX); do $(LINK_CMD) $(PWD)/$$file /etc/$$file; done;
# ln -sf udevmon_$$HOSTNAME.yaml etc/interception/udevmon.yaml
	@-for file in etc/*; do \
		if [ -h /$$file ]; then \
		unlink /$$file ;\
        fi;\
		$(LINK_CMD) $(PWD)/$$file /$$file ;\
	done

	@-for file in bin/*; do \
		$(LINK_CMD) $(PWD)/$$file /usr/local/$$file ;\
	done

	# for file in $(SYSTEMD_SERVICE); do $(LINK_CMD) $(PWD)/$$file /etc/systemd/system/$$file; systemctl restart $$file; done; \
