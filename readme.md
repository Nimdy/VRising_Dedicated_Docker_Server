
# VRising Dedicated Server Linux Docker
Run a VRising Dedicated Server on Linux via Docker

Visit https://github.com/StunlockStudios/vrising-dedicated-server-instructions for additionall json configuration settings.

# Menu system coming soon for Linux Users only


## Server Hosting Provided By DigitalOcean
* https://m.do.co/c/9d2217a2725c
* Use my link and get 100 USD Server Credits from me,  over the next 60 Days!
* Free Credits without hacks... 

```
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
```
 ---
 
 Credits;
 
 This Server uses the following Images;
 
 maloneweb/docker-wine-base:latest
 
 honestventures/steamcmd-linux-wine:latest
