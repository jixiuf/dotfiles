#!/bin/zsh
# appendPath(newPath)
# 如果newPath 已经在PATH下了， 则不添加
export APM_OUTPUT_PATH=/tmp/trace/
export LC_ALL=zh_CN.UTF-8
export GO111MODULE=on
appendPath(){
    addPath="$1"
    if [ -d $addPath ]; then
        PATH="${PATH/:$addPath}"     # remove if already there (包括分隔符，)
        PATH="${PATH/$addPath}"      # remove if already there (不包括分隔符,主要在行首时)
        export PATH=$PATH:$addPath
    fi
}
prependPath(){
    addPath="$1"
    if [ -d $addPath ]; then
        PATH="${PATH/:$addPath}"     # remove if already there (包括分隔符，)
        PATH="${PATH/$addPath}"      # remove if already there (不包括分隔符,主要在行首时)
        export PATH=$addPath:$PATH
    fi
}

prependPath "$HOME/bin"
appendPath "$HOME/.emacs.d/bin"
appendPath "/usr/local/mysql/bin"
appendPath "/usr/local/sbin"
prependPath "/usr/local/bin"
prependPath "/usr/local/emacs/bin"
appendPath "/Library/TeX/texbin"
appendPath "/usr/local/share/dotnet"
appendPath "/Library/Input Methods/Squirrel.app/Contents/MacOS"

if [ -d $HOME/python/bin/ ]; then
    source $HOME/python/bin/activate
fi
# ;; brew install pyenv-virtualenv
# ;; pyenv install 2.7.13

if [ -d ~/.pyenv/versions/3.9.7/bin/ ]; then
    export PATH="$HOME/.pyenv/versions/3.9.7/bin:$PATH"
fi

# appendPath "$HOME/go_appengine"
if [ "$HOME/Library/Android/sdk" ]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    appendPath "$HOME/Library/Android/sdk/platform-tools"
    appendPath "$HOME/Library/Android/sdk/tools"
fi
if [ -d /usr/local/opt/android-sdk ]; then
    export ANDROID_HOME=/usr/local/opt/android-sdk
    export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
    prependPath "$ANDROID_HOME/bin"
    prependPath "$ANDROID_HOME/tools"
    prependPath "$ANDROID_HOME/platform-tools"
fi
if [ -d /usr/local/share/android-sdk ]; then
    export ANDROID_HOME=/usr/local/share/android-sdk
    export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
    prependPath "$ANDROID_HOME/bin"
    prependPath "$ANDROID_HOME/tools"
    prependPath "$ANDROID_HOME/platform-tools"
fi

if [ "$HOME/Library/Android/ndk" ]; then
    export NDK_ROOT=$HOME/Library/Android/ndk
    export ANDROID_NDK_ROOT=$HOME/Library/Android/ndk
    prependPath "$NDK_ROOT/bin"
fi

if [ -d /usr/local/opt/android-ndk ]; then
    export NDK_ROOT=/usr/local/opt/android-ndk
    export ANDROID_NDK_ROOT=/usr/local/opt/android-ndk
    prependPath "$NDK_ROOT/bin"
fi
if [ -d /usr/local/share/android-ndk ]; then
    export NDK_ROOT=/usr/local/share/android-ndk
    export ANDROID_NDK_ROOT=/usr/local/share/android-ndk
    prependPath "$NDK_ROOT/bin"
fi


if [ -d /Applications/adt-bundle-mac-x86_64-20140321 ]; then
    appendPath "/Applications/adt-bundle-mac-x86_64-20140321/sdk/platform-tools"
    appendPath "/Applications/adt-bundle-mac-x86_64-20140321/sdk/tools"
fi

# if [ -d /Library/Frameworks/Python.framework/Versions/3.4/lib/pkgconfig ]; then
#     export PKG_CONFIG_PATH=/Library/Frameworks/Python.framework/Versions/3.4/lib/pkgconfig
# fi

if [ -d /usr/local/java ]; then
    export JAVA_HOME=/usr/local/java
    appendPath "/usr/local/java/bin"
fi
if [ -d /usr/share/jdk ]; then
    export JAVA_HOME=/usr/share/jdk
    appendPath "/usr/share/jdk/bin"
fi


if [ -d /Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home ]; then
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home
fi

if [ $(uname -s ) = "Darwin" ] ; then
    export JAVA_HOME=`/usr/libexec/java_home`
    #launchctl setenv PATH $PATH
fi

if [ -x ~/.emacs.d/bin/em ]; then
    export EDITOR=~/.emacs.d/bin/em
fi
if [ -x ~/.emacs.d/bin/ec ]; then
    export EDITOR=~/.emacs.d/bin/ec
fi

export GOTRACEBACK=crash prog

export NODE_PATH=/usr/local/lib/node_modules

# # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
# export COCOS_CONSOLE_ROOT=~/repos/cocos2d-x-3/tools/cocos2d-console/bin
# export PATH=$COCOS_CONSOLE_ROOT:$PATH

# # Add environment variable COCOS_X_ROOT for cocos2d-x
# export COCOS_X_ROOT=~/repos
# export PATH=$COCOS_X_ROOT:$PATH

# # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
# export COCOS_TEMPLATES_ROOT=~/repos/cocos2d-x-3/templates
# export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# # Add environment variable ANT_ROOT for cocos2d-x
# export ANT_ROOT=/usr/local/Cellar/ant/1.9.7/bin
# export PATH=$ANT_ROOT:$PATH


if [ -d /usr/local/go ]; then
    export GOROOT=/usr/local/go
fi
if [ -d /usr/local/opt/go/libexec ]; then
    export GOROOT=/usr/local/opt/go/libexec
fi
if [ -d ~/repos/go ]; then
    export GOROOT=~/repos/go
fi
prependPath "$GOROOT/bin"
if [ -d $HOME/go ]; then
	export GOPATH=$HOME/go
fi
appendPath "$GOPATH/src/github.com/uber/go-torch/FlameGraph"
appendPath "$GOPATH/bin"
appendPath "/usr/local/texlive/2016/bin/x86_64-darwin"

if [ -d /usr/local/include/ ]; then
    export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/include/
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/include/
    export OBJC_INCLUDE_PATH=$OBJC_INCLUDE_PATH:/usr/local/include/
fi
if [ -d /usr/local/lib/ ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
fi
# if [ -d /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include ]; then
#     export C_INCLUDE_PATH=$C_INCLUDE_PATH:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include
#     export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include
#     export OBJC_INCLUDE_PATH=$OBJC_INCLUDE_PATH:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include
# fi
if [ -d /usr/local/opt/opencv3 ]; then
    export OpenCV_DIR=/usr/local/opt/opencv3
    export C_INCLUDE_PATH=$C_INCLUDE_PATH:$OpenCV_DIR/include
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$OpenCV_DIR/include
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OpenCV_DIR/lib
fi

# cocos android  begin

#Add Android SDK & NDK
if [ -d ~/Documents/tools/adt-bundle-mac-x86_64-20140702/sdk ]; then
    export ANDROID_SDK_ROOT=~/Documents/tools/adt-bundle-mac-x86_64-20140702/sdk
else
    export ANDROID_SDK_ROOT=~/Documents/android/ADT/sdk
fi
export ANDROID_NDK_ROOT=~/Documents/android/NDK
export ANDROID_HOME=~/Documents/android/ADT/sdk
export NDK_ROOT=~/Documents/android/NDK

#Add Cocos2dx
export COCOS2DX_ROOT=~/repos/svn/game2dev/client/cocos2d-x-2.2.6
export PNGQUANT_ROOT=~/Documents/android/buildTools

#PATH

appendPath "$ANDROID_NDK_ROOT"
appendPath "$PNGQUANT_ROOT"
appendPath "$ANDROID_SDK_ROOT/build-tools/android-4.4.2"
appendPath "$ANDROID_SDK_ROOT/tools"
appendPath "$ANDROID_SDK_ROOT/platform-tools"
if [ $(uname -s ) = "Darwin" ] ; then
    if [[ "$TERM" != "dumb" ]]; then
        # cocos android end
        if [ ! -f /tmp/.zsh-evn-launchctl  ] ; then
            touch /tmp/.zsh-evn-launchctl
            for var in `env`; do
                env_name=`echo  $var | cut -d "=" -f 1`
                env_value=`echo  $var | cut -d "=" -f 2`
                if [ ! -z $env_value ] && [ $env_name != "PS1" ] && [ $env_name != "_" ] ;then
                    launchctl setenv $env_name $env_value
                fi
            done
        fi
        if [ -f ~/jenkins.war ]; then
            if [ ! -f /tmp/jenins-reload-zsh ]; then
                touch /tmp/jenins-reload-zsh
                launchctl unload ~/Library/LaunchAgents/jenkins.plist
                launchctl load ~/Library/LaunchAgents/jenkins.plist
            fi
        fi
    fi
fi
# 不知道为什么GIT_CONFIG_PARAMETERS有值时git 命令使用不了
unset GIT_CONFIG_PARAMETERS
