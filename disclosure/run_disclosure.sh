#!/bin/env bash

# Nothing scarry here ok?
# you can read this script if you want

abort_unsupported_arch() {
	echo "*********************************************************"
	echo "! Unsupported Architecture: $ARCH"
	echo "! Your CPU architecture is not supported by Disclosure."
	echo "*********************************************************"
	exit 1
}

# Move to home directory
cd

# Determine architecture
ARCH=$(uname -m)
case $ARCH in
"aarch64") ARCH_TMP="arm64-v8a" ;;
armv*) ARCH_TMP="armeabi-v7a" ;;
"x86_64") ARCH_TMP="x86_64" ;;
"i686") ARCH_TMP="x86" ;;
"riscv64") ARCH_TMP="riscv64" ;;
*) abort_unsupported_arch ;;
esac

# Download disclosure
curl -sO "https://dl.rem01gaming.dev/disclosure/$ARCH_TMP/disclosure"
if [ ! -f ~/disclosure ]; then
	echo "ERROR: Unable to download disclosure from GitHub pages, please check your Internet connection and try again."
	exit 1
fi

# Execute disclosure
chmod +x ./disclosure
time ./disclosure

# Remove disclosure back
rm -f ./disclosure

# Move back to previous directory
cd - >/dev/null
