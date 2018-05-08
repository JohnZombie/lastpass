#!/bin/bash

#Installs homebrew and lastpass CLI tools

function install_brew_osx()
{
echo "Now installing brew for OSX"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
echo "[*] Now installing Lastpass Cli.."
brew install lastpass-cli --with-pinentry
read -p "Please enter your lastpass email to login into lastpass: " USERNAME
lpass login $USERNAME
read -p "Would you like to see the contents in your vault (y/n)?" choice
case "$choice" in
  y|Y ) lpass ls;;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac
echo "[*]Hit enter to see a list of commands for lastpass. To navigate you must use the commands listed. Enjoy! :)"
read
lpass man
}

# Checks if Lastpass is installed on machine

if [ -d  "/Users/$USER/Library/Containers/com.lastpass.LastPass" ]; then
echo "Lastpass on Mac found."
install_brew_osx
else
echo "Lastpass on Mac not found Please download from Managed Software Center.."
fi
