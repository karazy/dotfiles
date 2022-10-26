#!/usr/bin/env bash

OS_NAME=$( uname -s | tr '[:upper:]' '[:lower:]')
OS_ARCH=$( uname -m )

function installHomebrew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
}

if ! command -v "git" &> /dev/null; then
	case "$OS_NAME" in
	darwin*)
		xcode-select --install || true
		;; 
	linux*)
		sudo apt install -y curl make git
		;;
	*)
		echo "Unsupported OS: $(uname)"
		exit 1
		;;
	esac
else
	echo "Skipping basics installation as they are already installed."
fi

if ! command -v "brew" &> /dev/null; then
	case "$OS_ARCH" in
		aarch64)
			echo "Skipping homebrew installation as it is unsupported on $OS_ARCH"
			echo "https://docs.brew.sh/Homebrew-on-Linux#arm-unsupported"
			;;
		*)
			installHomebrew
			;;
	esac
else
	echo "Skipping homebrew installation as it is already installed."
fi


curl -fsSL https://raw.githubusercontent.com/karazy/dotfiles/main/Makefile | make -f -
