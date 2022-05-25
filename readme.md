
# VRising Dedicated Server Linux Docker
Run a VRising Dedicated Server on Linux via Docker (TESTED on Ubuntu 20.04.4 LTS Focal Fossa 4CPU 8GB RAM)

Visit https://github.com/StunlockStudios/vrising-dedicated-server-instructions for additionall json configuration settings.

# Menu system coming soon for Linux Users only NOT done yet... just follow the steps below without using the menu system and you will be fine


## Server Hosting Provided By DigitalOcean
* https://m.do.co/c/9d2217a2725c
* Use my link and get 100 USD Server Credits from me,  over the next 60 Days!
* Free Credits without hacks... 

```
1. 
sudo apt update
2.
sudo apt install docker.io -y
3.
sudo snap install docker
4.
useradd --create-home --shell /bin/bash --password $userpassword steam
5.
cp /etc/skel/.bashrc /home/steam/.bashrc
6.
cp /etc/skel/.profile /home/steam/.profile
7.
cd ~steam
8.
git clone https://github.com/Nimdy/VRising_Dedicated_Docker_Server.git
9.
cd VRising_Dedicated_Docker_Server
10.
chmod +x ./* -R
11.
sudo docker build . -t njordmenu/vrising:latest
12.
mkdir -p /home/steam/VRising_Dedicated_Docker_Server/data
13.
cp configs/ServerHostSettings.json data/VRisingServer_Data/StreamingAssets/Settings/
14.
cp configs/ServerGameSettings.json data/VRisingServer_Data/StreamingAssets/Settings/
15.
cp configs/ServerVoipSettings.json data/VRisingServer_Data/StreamingAssets/Settings/
16.
cp configs/adminlist.txt data/VRisingServer_Data/StreamingAssets/Settings/
17.
cp configs/banlist.txt data/VRisingServer_Data/StreamingAssets/Settings/
18.
./start_vrising_container.sh
19.
Connect and have fun
```
# TO-DOs
```
Secure with steam user and not root
Update menu system
find free time
```
 ---
 
 Credits;
 
 This Server uses the following Images;
 
 maloneweb/docker-wine-base:latest
 
 honestventures/steamcmd-linux-wine:latest
 
 OG Script: https://github.com/toninog/docker-vrising <--- awesome guy!
