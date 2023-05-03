.PHONY: all emacs-compile elisp-compile deploy

PWD := `pwd`
LINK_CMD := ln -s -f
LINK_CMD_HARD := ln -f
NORMAL_FILES_COMMON := `echo gitconfig gitattributes gitignore  vimrc  shadowsocks.json zshenv zshrc  tmux.conf  axelrc bashrc ctags fzf.zsh bash-preexec.sh yank.sh mbsyncrc mailrc msmtprc`
NORMAL_FILES_LINUX := `echo  dual-function-keys.yaml`
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
# @$(LINK_CMD) $(PWD)/ipy_user_conf.py ~/.ipython/ipy_user_conf.py

	@if [ `uname -s` = "Linux" ] ; then \
		mkdir -p ~/.config/ibus; \
		for file in $(NORMAL_FILES_LINUX); do $(LINK_CMD) $(PWD)/$$file ~/.$$file; done; \
		$(LINK_CMD)   $(PWD)/mac/rime_input_method ~/.config/ibus/rime ;\
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
	  $(LINK_CMD) $(PWD)/crontab /etc/crontab; \
	  $(LINK_CMD) $(PWD)/udevmon.yaml /etc/udevmon.yaml; \
	  $(LINK_CMD) $(PWD)/udevmon.service /etc/systemd/system/udevmon.service; \
	fi
	@if [ `uname -s` = "Darwin" ] ; then \
	  cd mac && $(MAKE)  sudo; \
	fi
