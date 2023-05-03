# -*- coding:utf-8 -*-
.PHONY: deploy
PWD := `pwd`
DIR := `pwd`
DATE := `date +%Y-%m-%d_%H-%M-%S`
LINK_CMD := ln -s -f

deploy:
	echo $(DIR)
	@-$(LINK_CMD) $(PWD)/globalrc ~/.globalrc
	mkdir -p ~/.local/share/gnome-shell/extensions
	echo $(DIR)
	mv ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge.bak-$(DATE) ;\
	git clone https://github.com/adrienverge/gnome-magic-window  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
	cp gnome-magic-window.patch  ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge; \
	cd ~/.local/share/gnome-shell/extensions/gnome-magic-window@adrienverge ; \
	git stash ; \
	git apply gnome-magic-window.patch

sudo:
	echo ""