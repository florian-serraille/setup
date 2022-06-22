#!/bin/bash

notify(){
	notify-send "${1}" "${2}" -i "dialog-information-symbolic"
}

update_system(){
	notify "Update" "Updating system"
	sudo apt update
	sudo apt upgrade -y
	sudo apt autoremove -y
	sudo apt dist-upgrade -y
}

install_basics(){
	notify "Installation" "installing basic dependencies"
	sudo apt install software-properties-common apt-transport-https wget ca-certificates gnupg2 ubuntu-keyring git-all curl jq -y
}

install_chrome_browser(){
	count=$(dpkg -l | grep -w ' google-chrome-stable ' | wc -l)
	if [[ $count -eq 0 ]]; then
		notify "Installation" "installing google chrome"
		# Import Google Chrome GPG Key
		wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg
		# Import Google Chrome repository
		echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list
		sudo apt update
		sudo apt install google-chrome-stable -y
	fi
}

install_visual_code(){
	count=$(dpkg -l | grep -w ' code ' | wc -l)
	if [[ $count -eq 0 ]]; then
		notify "Installation" "installing visual code"
		wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
		sudo sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
		sudo apt update
		sudo apt install code -y
	fi
}

main(){
	update_system
	install_basics
	install_chrome_browser
	install_visual_code
}

main