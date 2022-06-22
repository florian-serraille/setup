#!/bin/bash

# do not run as root
# https://www.youtube.com/watch?v=lXIb-1_H-mA

notify(){
	    notify-send "${1}" "${2}" -i "dialog-information-symbolic"
}

install_ui_dependencies(){
		notify "Installation" "installing basic dependencies"
        sudo apt install gnome-shell-extensions gnome-tweaks chrome-gnome-shell -y
}

install_theme(){
	notify "Installation" "installing WhiteSur-gtk-theme"
	[[ -d /tmp/theme ]] && rm -rf /tmp/theme	
	mkdir /tmp/theme
	cd /tmp/theme
	git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
	cd WhiteSur-gtk-theme
	./install.sh -t red
}

install_icone(){
	notify "Installation" "installing Reversal-icon-theme"
	[[ -d /tmp/icone ]] && rm -rf /tmp/icone	
	mkdir /tmp/icone
	cd /tmp/icone
	git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git
	cd Reversal-icon-theme
	./install.sh -red
}

install_fonts(){
	notify "Installation" "installing fonts"
	unzip resources/fonts.zip -d ~/.local/share
}

install_cursors(){
	notify "Installation" "installing cursors"
	[[ -d /tmp/cursors ]] && rm -rf /tmp/cursors	
	mkdir /tmp/cursors
	cd /tmp/cursors
	git clone https://github.com/vinceliuice/Vimix-cursors.git
	cd Vimix-cursors
	./install.sh
	mkdir ~/.icons
	cp -r ~/.local/share/icons/Vimix* ~/.icons
}

install_extensions(){
	notify "Installation" "installing extensions"
	unzip resources/extensions.zip -d ~/.local/share/gnome-shell
	echo '****************************************'
	echo '* Configure extensions and press any key to reboot *'
	echo '****************************************'
	read ok
	reboot
}

main(){
	install_ui_dependencies
	enable_gnome_extensions
	install_theme
	install_icone
	install_fonts
	install_cursors
	install_extensions
}

main