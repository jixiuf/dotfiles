# -*- coding:utf-8 -*-
.PHONY: deploy
PWD := `pwd`
DIR := `pwd`
DATE := `date +%Y-%m-%d_%H-%M-%S`
LINK_CMD := ln -s -f
SYS_CONFIG_FILES_LINUX := `echo xremap.yaml`
SYSTEMD_SERVICE := `echo  xremap.service`

deploy:
	mkdir -p ~/.config/
	@-for file in config/*; do \
		unlink ~/.$$file ;\
		$(LINK_CMD) $(PWD)/$$file ~/.$$file ;\
	done

# mkdir -p ~/.local/share/gnome-shell/extensions
# mv ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge.bak-$(DATE) ;\
# git clone https://github.com/adrienverge/gnome-magic-window  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
# cp gnome-magic-window.patch  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge; \
# cd ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
# git stash ; \
# git apply gnome-magic-window.patch

sudo:
	mkdir /etc/interception
	$(LINK_CMD) $(PWD)/udevmon.yaml /etc/interception/udevmon.yaml; \
	$(LINK_CMD) $(PWD)/dual-function-keys.yaml /etc/interception/dual-function-keys.yaml; \
	for file in $(SYS_CONFIG_FILES_LINUX); do $(LINK_CMD) $(PWD)/$$file /etc/$$file; done;

	for file in $(SYSTEMD_SERVICE); do $(LINK_CMD) $(PWD)/$$file file$$/etc/systemd/system/; systemctl restart $$file; done; \