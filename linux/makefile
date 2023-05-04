# -*- coding:utf-8 -*-
.PHONY: deploy
PWD := `pwd`
DIR := `pwd`
DATE := `date +%Y-%m-%d_%H-%M-%S`
LINK_CMD := ln -s -f
DOT_CONFIG_FILES_LINUX := `echo  dual-function-keys.yaml xremap.yaml`
SYSTEMD_SERVICE := `echo  udevmon.service xremap.service`

deploy:
	mkdir -p ~/.share
	for file in $(DOT_CONFIG_FILES_LINUX); do $(LINK_CMD) $(PWD)/$$file ~/.config/$$file; done;
	mkdir -p ~/.local/share/gnome-shell/extensions
	mv ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge.bak-$(DATE) ;\
	git clone https://github.com/adrienverge/gnome-magic-window  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
	cp gnome-magic-window.patch  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge; \
	cd ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
	git stash ; \
	git apply gnome-magic-window.patch

sudo:
	$(LINK_CMD) $(PWD)/udevmon.yaml /etc/udevmon.yaml; \
	for file in $(SYSTEMD_SERVICE); do $(LINK_CMD) $(PWD)/$$file /etc/systemd/system/$$file; done; \