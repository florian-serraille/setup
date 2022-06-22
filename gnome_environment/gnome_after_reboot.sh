#!/bin/bash

# do not run as root
# https://www.youtube.com/watch?v=lXIb-1_H-mA

notify(){
	    notify-send "${1}" "${2}" -i "dialog-information-symbolic"
}


activate_extensions(){
	notify "Activation" "activating extensions"
	gnome-extensions-app
	echo '****************************************'
	echo '* Activate all extensions and press any key *'
	echo '****************************************'
	read ok
}

configure_extensions(){
	notify "Configuration" "configuring extensions"
	[[ -d /tmp/extensions ]] && rm -rf /tmp/extensions	
	unzip resources/extensions.zip -d /tmp
	dconf load /org/gnome/shell/extensions/ < /tmp/extensions/all_extensions_config/all_extension_settings.conf
}

apply_theme(){
	gnome-tweaks
	echo '****************************************'
	echo '* Configure tweaks and press any key *'
	echo '****************************************'
	read ok
}

install_conky(){
	notify "Installation" "installing conky"
	sudo apt install conky-all moc -y
	[[ -d /tmp/conky-config ]] && rm -rf /tmp/conky-config
	unzip resources/conky-config.zip -d /tmp
	cp -r /tmp/conky_config/Graffias ~/.config/conky
	cp /tmp/conky_config/start_conky.desktop ~/.config/autostart

}

main(){
	activate_extensions
	configure_extensions
	apply_theme
	install_conky
}

main