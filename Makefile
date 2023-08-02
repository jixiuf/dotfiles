.PHONY: all emacs-compile elisp-compile deploy

PWD := `pwd`
LINK_CMD := ln -s -f
LINK_CMD_HARD := ln -f
NORMAL_FILES_COMMON := `echo gnupg mitmproxy authinfo.gpg gitconfig gitattributes gitignore  vimrc  zshenv zshrc  tmux.conf  bashrc  fzf.zsh yank.sh mbsyncrc mailrc msmtprc`
default:
	sudo make sudo
	make deploy

deploy:
	@for file in $(NORMAL_FILES_COMMON); do unlink ~/.$$file ; $(LINK_CMD) $(PWD)/$$file ~/.$$file; done

# @if [ ! -d ~/bin ]; then\
#	mkdir ~/bin;\
# fi
# -$(LINK_CMD) $(PWD)/proxy/httpgo ~/bin/httpgo;
# @-for file in bin/*; do \
#	if [ -h /$$file ]; then \
#	unlink /$$file ;\
#     fi;\
#	if	[ -f $$file ]; then \
#		$(LINK_CMD) $(PWD)/$$file ~/$$file ;\
#     fi;\
# done

	@if [ ! -d ~/.cache/.vimbackup ]; then\
		mkdir -p ~/.cache/.vimbackup;\
	fi
	@if [ `uname -s` = "Linux" ] ; then \
		mkdir -p ~/.local/share/fcitx5; \
		$(LINK_CMD)   $(PWD)/mac/rime_input_method ~/.local/share/fcitx5/rime ;\
		cd linux && $(MAKE) ; \
	fi

	@if [ `uname -s` = "Darwin" ] ; then \
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
	for file in bin/*; do \
		if [ -h /usr/local/$$file ]; then \
		unlink /usr/local/$$file ;\
		fi;\
		if	[ -f $$file ]; then \
			$(LINK_CMD) $(PWD)/$$file /usr/local/$$file ;\
		fi;\
	done;
