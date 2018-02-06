#!/bin/bash

#This checks if lastpass plugin is installed for Chrome,Firefox, and on Computer.

if [ ! -f "/Applications/LastPass.app" ]; then
echo "Lastpass on Mac found."
else
echo "Lastpass on Mac not found Please download from Managed Software Center.."
fi
if [ ! -f "/Users/$USER/Library/Application\ Support/Google/Chrome/Default/Extensions/hdokiejnpimakedhajhdlcegeplioahd" ]; then
echo "Lastpass on Chrome found."
else
echo "Lastpass on Chrome not found.. Please install from https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd?hl=en"
fi
if [ ! -f "/Users/$USER/Library/Application\ Support/Firefox/Profiles/hcbg6rr3.default-1472125718024/extensions/support@lastpass.com.xpi" ]; then
echo "Lastpass on Firefox found."
else
echo "Lastpass on Firefox not found..Please install from https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager/"
fi
# Installs homebrew and lastpass CLI tools
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
install_brew_osx
