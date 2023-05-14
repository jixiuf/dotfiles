# -*- coding:utf-8 -*-
.PHONY: deploy
PWD := `pwd`
DIR := `pwd`
DATE := `date +%Y-%m-%d_%H-%M-%S`
LINK_CMD := ln -s -f
# SYS_CONFIG_FILES_LINUX := `echo xremap.yaml`
SYS_CONFIG_FILES_LINUX := `echo `
SYSTEMD_SERVICE := `echo  xremap.service`

deploy:
	mkdir -p ~/.config/
	@-for file in config/*; do \
		if [ -h ~/.$$file ]; then \
		unlink ~/.$$file ;\
        fi;\
		$(LINK_CMD) $(PWD)/$$file ~/.$$file ;\
	done
	@-mkdir -p ~/.local/share/gnome-shell/extensions
	@-if [ ! -d ~/.local/share/gnome-shell/extensions/ ]; then\
		git clone https://github.com/CZ-NIC/run-or-raise.git  ~/.local/share/gnome-shell/extensions/;\
	fi
	mv ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge.bak-$(DATE) ;\
	git clone https://github.com/adrienverge/gnome-magic-window  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
	cp gnome-magic-window.patch  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge; \
	cd ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
	git stash ; \
	git apply gnome-magic-window.patch
	gnome-extensions enable gnome-magic-window@adrienverge

sudo:
	for file in $(SYS_CONFIG_FILES_LINUX); do $(LINK_CMD) $(PWD)/$$file /etc/$$file; done;
	@-for file in etc/*; do \
		if [ -h /$$file ]; then \
		unlink /$$file ;\
        fi;\
		$(LINK_CMD) $(PWD)/$$file /$$file ;\
	done

	for file in $(SYSTEMD_SERVICE); do $(LINK_CMD) $(PWD)/$$file /etc/systemd/system/$$file; systemctl restart $$file; done; \