.PHONY: all emacs-compile elisp-compile deploy

PWD := `pwd`
LINK_CMD := ln -s -f
LINK_CMD_HARD := ln -f
NORMAL_FILES_COMMON := `echo gitconfig gitattributes gitignore  vimrc  zshenv zshrc  tmux.conf  bashrc ctags fzf.zsh yank.sh mbsyncrc mailrc msmtprc`
echo:
	@echo "run:"
	@echo "    make deploy"
	@echo "    sudo make sudo"

deploy:
	@for file in $(NORMAL_FILES_COMMON); do $(LINK_CMD) $(PWD)/$$file ~/.$$file; done

	# -$(LINK_CMD_HARD) $(PWD)/ssh_config ~/.ssh/config
	@if [ ! -d ~/bin ]; then\
		mkdir ~/bin;\
	fi
	-$(LINK_CMD) $(PWD)/proxy/httpgo ~/bin/httpgo;
	-$(LINK_CMD)   $(PWD)/get ~/bin/get
	-$(LINK_CMD)   $(PWD)/date2ts ~/bin/
	-$(LINK_CMD)   $(PWD)/ts2date ~/bin/
	-$(LINK_CMD)   $(PWD)/color256 ~/bin/

	@if [ ! -d ~/.vimbackup ]; then\
		mkdir ~/.vimbackup;\
	fi
	-$(LINK_CMD) $(PWD)/git-remote-hg ~/bin

	@if [ `uname -s` = "Linux" ] ; then \
		mkdir -p ~/.config/ibus; \
		mkdir -p ~/.local/share/fcitx5; \
		$(LINK_CMD)   $(PWD)/mac/rime_input_method ~/.config/ibus/rime ;\
		$(LINK_CMD)   $(PWD)/mac/rime_input_method ~/.local/share//fcitx5/rime ;\
		cd linux && $(MAKE) ; \
	fi

	@if [ `uname -s` = "Darwin" ] ; then \
		rm -fr ~/.ssh; \
		ln -sf ~/Library/Mobile\ Documents/com~apple~CloudDocs/ssh ~/.ssh ; \
	  cd mac && $(MAKE) ; \
	fi
sudo:
	@-mv /etc/hosts /tmp/hosts
	-$(LINK_CMD_HARD) $(PWD)/hosts /etc/hosts

	@if [ `uname -s` = "Linux" ] ; then \
	  cd linux && $(MAKE)  sudo; \
	fi
	@if [ `uname -s` = "Darwin" ] ; then \
	  cd mac && $(MAKE)  sudo; \
	fi
