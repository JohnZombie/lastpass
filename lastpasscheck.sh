#!/bin/bash
BREW_CHECK=$(which brew)

#Installs homebrew and lastpass CLI tools

function lp_art()
{
  echo "
 .____                     __ __________                       
|    |   _____    _______/  |\______   \_____    ______ ______
|    |   \__  \  /  ___/\   __\     ___/\__  \  /  ___//  ___/
|    |___ / __ \_\___ \  |  | |    |     / __ \_\___ \ \___ \ 
|_______ (____  /____  > |__| |____|    (____  /____  >____  >
        \/    \/     \/                      \/     \/     \/ 
  _________            .__        __   
 /   _____/ ___________|__|______/  |_ 
 \_____  \_/ ___\_  __ \  \____ \   __
 /        \  \___|  | \/  |  |_> >  |  
/_______  /\___  >__|  |__|   __/|__|  
        \/     \/         |__|         "

echo
echo
}

function install_brew_osx()
{
echo "Now installing brew for OSX"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
}

function install_lastpass_cli()
{
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

function lp_check()
{
echo "[*] Lets now check if Lastpass is installed on your machine..Press enter to continue."
read
if [ -d  "/Users/$USER/Library/Containers/com.lastpass.LastPass" ]; then
echo "[!] Lastpass on Mac found!"
echo
echo
read -p "[*] Would you like to install the lastpass Cli tool (y/n)?" choice
case "$choice" in
  y|Y ) install_lastpass_cli;;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac
else
echo "[!] Lastpass on Mac not found.. Now downloading the LastPass app."
brew cask install lastpass
fi
}

clear
lp_art
echo "[*] Lets check if brew is installed first..Press enter to continue."
read
echo
echo
if [[ ! -z $BREW_CHECK ]]; then
echo "You already have brew it seems..."
echo
echo
lp_check
else
install_brew_osx
lp_check
fi
