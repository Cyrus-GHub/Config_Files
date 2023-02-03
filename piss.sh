#!/bin/bash

# Update and upgrade, -y flag for accepting prompt by default
sudo apt update && sudo apt upgrade -y

# App switcher only switches through apps in the current workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Install Nala, a front-end for apt
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install nala 
sudo nala fetch

# Use nala instead of apt and apt-get
echo 'apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi
apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi' >> ~/.bashrc

echo 'apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi
apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi' >> /root/.bashrc

# Install non-free codecs, gnome-tweaks application, VLC media player and Shotwell Image Viewer
sudo apt install gnome-tweaks vlc shotwell

# Install packages required for the rest of the script
sudo apt install software-properties-common apt-transport-https wget

# Trackpad Gestures
sudo gpasswd -a $USER input
sudo apt install wmctrl xdotool
sudo apt install libinput-tools
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo make install
wget https://github.com/Cyrus-GHub/Config_Files/blob/main/libinput-gestures.conf
mv libinput-gestures.conf ~/.config/

# Keyboard Config
wget https://github.com/Cyrus-GHub/Config_Files/blob/main/keybindings.dconf
wget https://github.com/Cyrus-GHub/Config_Files/blob/main/custom-keybindings.dconf
dconf load '/org/gnome/desktop/wm/keybindings/' < keybindings.dconf
dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' < custom-keybindings.dconf

# Espanso
wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
sudo apt install ./espanso-debian-x11-amd64.deb
espanso service register
espanso start
wget https://github.com/Cyrus-GHub/Config_Files/blob/main/base.yml
rm -r /home/cyrus/.config/espanso/match/base.yml
mv base.yml /home/cyrus/.config/espanso/match/

# VSCode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

# Zoom
wget https://zoom.us/client/5.13.5.431/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb

# Figma
wget https://github.com/Figma-Linux/figma-linux/releases/download/v0.10.0/figma-linux_0.10.0_linux_amd64.deb
sudo apt install ./figma-linux_0.10.0_linux_amd64.deb

# Fonts
wget -O Fonts.zip https://github.com/Cyrus-GHub/Config_Files/blob/main/Fonts%20\(aio\).zip?raw=true
sudo apt install unzip
unzip Fonts.zip
sudo cp /home/cyrus/'Fonts (aio)'/*.otf /usr/share/fonts/opentype
sudo cp /home/cyrus/'Fonts (aio)'/*.ttf /usr/share/fonts/truetype

# Cloudfare Warp
wget https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2023_1_133_1_amd64_dc941b82de.deb
sudo apt install ./cloudflare_warp_2023_1_133_1_amd64_dc941b82de.deb
warp-cli register


<<com
What's left?

1. Startup Applications:
system76-power profile performance
rfkill block bluetooth

2. Remove the default 4-finger gestures to avoid clashes:
sudo gedit /usr/share/touchegg/touchegg.conf

3. Add Git SSH key:
Generate new key
ssh-keygen -t ed25519 -C "20051203@kiit.ac.in"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
git config --global user.name "Cyrus Bhandari"
git config --global user.email "65149993+Cyrus-GHub@users.noreply.github.com"

Add new key at:
https://github.com/settings/keys

4. Github Desktop:
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
sudo apt install gdebi
sudo gdebi GitHubDesktop-linux-3.1.1-linux1.deb

5. Anaconda:
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
shasum -a 256 Anaconda3-2022.10-Linux-x86_64.sh
bash Anaconda3-2022.10-Linux-x86_64.sh

reboot

6. GNOME Extensions

7. WPS Office

8. Configure (CTT) QEMU, performance, security

9. Copy path nautilus extension

10. Just in case. Windows ISO Flasher for Linux- WoeUSB-ng:
sudo apt install git p7zip-full python3-pip python3-wxgtk4.0 grub2-common grub-pc-bin
sudo pip3 install ng-WoeUSB
com
