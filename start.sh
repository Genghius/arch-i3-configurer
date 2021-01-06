# Variable for commands below
yikes="is not installed, proceeding to install..."

# Check required packages and install them if necessary
echo "Checking that all required packages are installed..."
rofi -v 2> /dev/null 1> /dev/null || (echo "rofi $yikes" && pacman -S --noconfirm rofi 1> /dev/null 2> /dev/null)
awk -V 2> /dev/null 1> /dev/null || (echo "awk $yikes" && pacman -S --noconfirm mawk 1> /dev/null 2> /dev/null)
feh -v 2> /dev/null 1> /dev/null || (echo "feh $yikes" && pacman -S --noconfirm feh 1> /dev/null 2> /dev/null)
sensors -v 2> /dev/null 1> /dev/null || (echo "sensors $yikes" && pacman -S --noconfirm lm_sensors 1> /dev/null 2> /dev/null)
mpstat -V 2> /dev/null 1> /dev/null || (echo "mpstat $yikes" && pacman -S --noconfirm sysstat 1> /dev/null 2> /dev/null)
scrot -v 2> /dev/null 1> /dev/null || (echo "scrot $yikes" && pacman -S --noconfirm scrot 1> /dev/null 2> /dev/null)
dmenu -v 2> /dev/null 1> /dev/null || (echo "dmenu $yikes" && pacman -S --noconfirm dmenu 1> /dev/null 2> /dev/null)
i3blocks -V 2> /dev/null 1> /dev/null || (echo "i3blocks $yikes" && pacman -S --noconfirm i3blocks 1> /dev/null 2> /dev/null)
pulseaudio --version 2> /dev/null 1> /dev/null || (echo "pulseaudio $yikes" && pacman -S --noconfirm pulseaudio 1> /dev/null 2> /dev/null)
dunst -v 2> /dev/null 1> /dev/null || (echo "dunst $yikes" && pacman -S --noconfirm dunst 1> /dev/null 2> /dev/null)

# More checking
echo "Checking if Xorg is installed and installs if necessary"
ps -e | grep X 2> /dev/null 1> /dev/null || X -v 2> /dev/null 1> /dev/null || (echo "Xorg $yikes" && pacman -S --noconfirm xorg xorg-xinit xorg-twm xorg-xclock xterm 1> /dev/null 2> /dev/null && echo "exec i3" >> /home/$user/.xinitrc)

# More
echo "Checking if i3 or i3-gaps is installed. i3-gaps is installed if there is none of them"
i3 -v 2> /dev/null 1> /dev/null || (echo "i3-gaps $yikes" && pacman -S --noconfirm --needed i3-gaps ttf-dejavu 1> /dev/null 2> /dev/null) 

# Finds the user and store in a variable
# Can alternatively use $(who -m | awk 'RN==1 {print $1})'
user=$(logname)

# Copy dotfiles
# Create directories
echo "Creating directories to copy and overwrite dotfiles if do not exist"
ls /home/$user/.config/i3blocks 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/i3blocks
ls /home/$user/.config/i3 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/i3
ls /home/$user/.config/rofi 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/rofi
ls /home/$user/.config/dunst 2> /dev/null 1> /dev/null || mkdir -p /home/$user/.config/dunst

# Really writing to dotfiles
echo "Copying dotfiles to respective locations"
cp -r $PWD/dotfiles/blocks/* /home/$user/.config/i3blocks && chmod 777 /home/$user/.config/i3blocks/memory
cp -r $PWD/dotfiles/i3blocks.conf /home/$user/.config/i3blocks/config
cp -r $PWD/dotfiles/config /home/$user/.config/i3
cp -r $PWD/misc/HK.jpg /home/$user/.config/i3
cp -r $PWD/dotfiles/config.rasi /home/$user/.config/rofi
cp -r $PWD/dotfiles/dunstrc /home/$user/.config/dunst

# Print instructions
echo "To edit configs, start editing with your favorite editor ~/.config/i3/config and /home/$user/.config/i3blocks files. Check containing folders also to know the structure and do more things... Happy Ricing"

# Deleting this cloned repo
echo "done, proceeding to delete script and related garbage."
rm -rf $PWD
