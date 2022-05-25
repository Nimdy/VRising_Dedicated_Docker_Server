
#!/bin/bash
# Sanity Check
#    #######################################################
echo "$(tput setaf 4)-------------------------------------------------------"
echo "$(tput setaf 0)$(tput setab 7)Since we need to run the menu with elevated privileges$(tput sgr 0)"
echo "$(tput setaf 0)$(tput setab 7)Please enter your password now.$(tput sgr 0)"
echo "$(tput setaf 4)-------------------------------------------------------"
#    ###################################################### 
[[ "$EUID" -eq 0 ]] || exec sudo "$0" "$@"


# Set Menu Version for menu display
mversion="1.0"

userpassword="NjordMenu"


########################################################################
#############################Set COLOR VARS#############################
########################################################################

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
CLEAR='\e[0m'

##
# Color Functions
##
ColorRed(){ 
        echo -ne $RED$1$CLEAR 
}
ColorGreen(){
         echo -ne $GREEN$1$CLEAR
}
ColorOrange(){
	echo -ne $ORANGE$1$CLEAR
}
ColorBlue(){
	echo -ne $BLUE$1$CLEAR
}
ColorPurple(){
	echo -ne $PURPLE$1$CLEAR
}
ColorCyan(){
	echo -ne $CYAN$1$CLEAR
}
ColorLightRed(){
	echo -ne $LIGHTRED$1$CLEAR
}
ColorLightGreen(){
	echo -ne $LIGHTGREEN$1$CLEAR
}
ColorYellow(){
	echo -ne $LIGHTYELLOW$1$CLEAR
}
ColorWhite(){
	echo -ne $WHITE$1$CLEAR
}

########################################################################
#####################Check for Menu Updates#############################
########################################################################
MENUSCRIPT="$(readlink -f "$0")"
SCRIPTFILE="$(basename "$MENUSCRIPT")"            
SCRIPTPATH="$(dirname "$SCRIPT")"
SCRIPTNAME="$0"
ARGS=( "$@" )  
BRANCH=$(git rev-parse --abbrev-ref HEAD)
UPSTREAM=$(git rev-parse --abbrev-ref --symbolic-full-name @{upstream})

function script_check_update() {
#Look I know this is not pretty like Loki's face but it works!
    git fetch
      [ -n "$(git diff --name-only "$UPSTREAM" "$SCRIPTFILE")" ] && {
      echo "Update found, updating..."
      sleep 1
        git pull --force
	git stash
        git checkout "$BRANCH"
        git pull --force
	echo " Updating"
      	sleep 1
	chmod +x menu.sh
        exec "$SCRIPTNAME" "${ARGS[@]}"

        # Now exit this old instance
        exit 1
    }
        echo "error... back to choring! "
}

########################################################################
#########PREP ENV with steam user, Docker and other REQ#################
########################################################################
function fresh_server_setup_for_vrising() {

apt update && upgrade -y
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    unzip \
    git -y

sudo apt update
sudo apt install docker.io -y
sudo snap install docker

useradd --create-home --shell /bin/bash --password $userpassword steam
cp /etc/skel/.bashrc /home/steam/.bashrc
cp /etc/skel/.profile /home/steam/.profile
cd ~steam
git clone https://github.com/Nimdy/VRising_Dedicated_Docker_Server.git
cd VRising_Dedicated_Docker_Server
chmod +x ./* -R
sudo docker build . -t njordmenu/vrising:latest
mkdir -p ~steam/data/games/vrising
cp configs/ServerHostSettings.json /data/games/vrising/VRisingServer_Data/StreamingAssets/Settings/
cp configs/ServerGameSettings.json /data/games/vrising/VRisingServer_Data/StreamingAssets/Settings/
cp configs/ServerVoipSettings.json /data/games/vrising/VRisingServer_Data/StreamingAssets/Settings/
cp configs/adminlist.txt /data/games/vrising/VRisingServer_Data/StreamingAssets/Settings/
cp configs/banlist.txt /data/games/vrising/VRisingServer_Data/StreamingAssets/Settings/

}



########################################################################
####################END CHANGE VRising START CONFIG#####################
########################################################################

########################################################################
##########################MENUS STATUS VARIBLES#########################
########################################################################
# Check Current VRising REPO Build for menu display

#function check_official_Vrising_release_build() {
#    if [[ -e "/home/steam/steamcmd" ]] ; then
#    currentOfficialRepo=$(/home/steam/steamcmd +login anonymous +app_info_update 1 +app_info_print 1829350 +quit | grep -A10 branches | grep -A2 public | grep buildid | cut -d'"' -f4) 
#        echo $currentOfficialRepo
#    else 
#        echo "No Data";
#  fi
#}

# Check Local VRising Build for menu display
#function check_local_Vrising_build() {
#localVrisingAppmanifest=${VrisingInstallPath}/steamapps/appmanifest_1829350.acf
#   if [[ -e $localVrisingAppmanifest ]] ; then
#    localVrisingBuild=$(grep buildid ${localVrisingAppmanifest} | cut -d'"' -f4)
#        echo $localVrisingBuild
#    else 
#        echo "No Data";
#  fi
#}

function check_menu_script_repo() {

latestScript=$(curl --connect-timeout 10 -s https://api.github.com/repos/Nimdy/VRising_Dedicated_Docker_Server/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
echo $latestScript
}

function display_public_status_on_or_off() {
echo "Show public status"
}


function display_public_IP() {
externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\E[32m'"External IP : $whateverzerowantstocalthis "$externalip ; tput setaf 9;
}

function display_local_IP() {
internalip=$(hostname -I)
echo -e '\E[32m'"Internal IP :" $mymommyboughtmeaputerforchristmas $internalip ; tput setaf 9;

}

function are_you_connected() {
ping -c 1 google.com &> /dev/null && echo -e '\E[32m'"Internet: $tecreset Connected" || echo -e '\E[32m'"Internet: $tecreset Disconnected"

}

function menu_header() {
get_current_config
display_public_status_on_or_off
echo -ne "
$(ColorOrange '╔═══════════════════════════════════════════════╗')
$(ColorOrange '║~~~~~~~~~-Njord Menu for VRising-~~~~~~~~~~~~~~║')
$(ColorOrange '╠═══════════════════════════════════════════════╝')
$(ColorOrange '║ BETA SORRY')
$(ColorOrange '║ Visit our discord: https://discord.gg/ejgQUfc')
$(ColorOrange '║ Docker build works... Working Menu stuff')
$(ColorOrange '║') 
$(ColorOrange '║') VRising Official Build:" $(check_official_vrising_release_build)
echo -ne "
$(ColorOrange '║') VRising Server Build:" $(check_local_Vrising_build)
echo -ne "
$(ColorOrange '║') Server Name: ${currentDisplayName}
$(ColorOrange '║') $(are_you_connected)
$(ColorOrange '║')" $(display_public_IP)
echo -ne "
$(ColorOrange '║')" $(display_local_IP)
echo -ne "
$(ColorOrange '║') Your Server Port:" ${currentPort}
echo -ne "
$(ColorOrange '║') Public Listing:" $(display_public_status_on_or_off)
echo -ne "
$(ColorOrange '║') Current Menu Release: $(check_menu_script_repo)
$(ColorOrange '║') Local Installed Menu: ${mversion}
$(ColorOrange '║') Happy Gaming - ZeroBandwidth
$(ColorOrange '╚═══════════════════════════════════════════════')"
}

########################################################################
#######################Display Main Menu System#########################
########################################################################
menu(){
#get_current_config
clear
menu_header
echo -ne "
$(ColorOrange '-------------Check for Script Updates-----------')
$(ColorOrange '-')$(ColorGreen ' 1)') Update Menu Script from GitHub
$(ColorOrange '--------------VRising Server Commands-----------')
$(ColorOrange '-')$(ColorGreen ' 2)') Install VRising Server on Fresh Server
$(ColorOrange '---------Official VRising Server Update---------')
$(ColorOrange '------------------------------------------------')
$(ColorGreen ' 0)') Exit
$(ColorOrange '------------------------------------------------')
$(ColorPurple 'Choose an option:') "
        read a
        case $a in
	        1) script_check_update ; menu ;;
		2) fresh_server_setup_for_vrising ; menu ;;
		    0) exit 0 ;;
		    *)  echo -ne " $(ColorRed 'Wrong option.')" ; menu ;;
        esac
}
# Call the menu function or the shortcut called in arg
if [ $# = 0 ]; then
    menu
    esac
fi 
