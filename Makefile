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

	@if [ ! -d ~/bin ]; then\
		mkdir ~/bin;\
	fi
	-$(LINK_CMD) $(PWD)/proxy/httpgo ~/bin/httpgo;
	@-for file in bin/*; do \
		if [ -h /$$file ]; then \
		unlink /$$file ;\
        fi;\
		if	[ -f $$file ]; then \
			$(LINK_CMD) $(PWD)/$$file ~/$$file ;\
        fi;\
	done

	@if [ ! -d ~/.cache/.vimbackup ]; then\
		mkdir -p ~/.cache/.vimbackup;\
	fi
	@if [ `uname -s` = "Linux" ] ; then \
		mkdir -p ~/.config/ibus; \
		mkdir -p ~/.local/share/fcitx5; \
		$(LINK_CMD)   $(PWD)/mac/rime_input_method ~/.config/ibus/rime ;\
		$(LINK_CMD)   $(PWD)/mac/rime_input_method ~/.local/share/fcitx5/rime ;\
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
