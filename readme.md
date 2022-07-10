
# VRising Dedicated Server Linux Docker
Run a VRising Dedicated Server on Linux via Docker (TESTED on Ubuntu 20.04.4 LTS Focal Fossa 4CPU 8GB RAM)

Visit https://github.com/StunlockStudios/vrising-dedicated-server-instructions for additionall json configuration settings.

# Menu system coming soon ... work in progress. Until then just follow the steps below and you can have your own V Rising Server running in Docker.


## Server Hosting Provided By DigitalOcean
* https://m.do.co/c/9d2217a2725c
* Use my link and get 100 USD Server Credits from me,  over the next 60 Days!
* Free Credits without hacks... 

# Setup and Install

1. Update Ubuntu Server
```
sudo apt update
```
2. Install Docker
```
sudo apt install docker.io -y
```
3. Install other supporting items for Docker
```
sudo snap install docker
```
4. Create a non-root user
```
useradd --create-home --shell /bin/bash --password ChangeMePassword steam
```
5. Copy over the env for the new user
```
cp /etc/skel/.bashrc /home/steam/.bashrc
```
6. Copy over profile env for the user
```
cp /etc/skel/.profile /home/steam/.profile
```
7. Change into the steam user home dir
```
cd ~steam
```
8. clone the repo from here
```
git clone https://github.com/Nimdy/VRising_Dedicated_Docker_Server.git
```
9. Change into the repo directory
```
cd VRising_Dedicated_Docker_Server
```
10. Allow execution permissions
```
chmod +x ./* -R
```
11. Build the Docker Image for local use
```
sudo docker build . -t njordmenu/vrising:latest
```
12. Make directory for persistence data (saves, configs ..etc)
```
mkdir -p /home/steam/VRising_Dedicated_Docker_Server/data/VRisingServer_Data/StreamingAssets/Settings/
```
13. Copy over the Host Configurations. Change these as you wish.
```
cp configs/ServerHostSettings.json data/VRisingServer_Data/StreamingAssets/Settings/
```
14. Copy over the Game Configurations. Change these as you wish.
```
cp configs/ServerGameSettings.json data/VRisingServer_Data/StreamingAssets/Settings/
```
15. Copy over the VoIP settings. Change as you wish.
```
cp configs/ServerVoipSettings.json data/VRisingServer_Data/StreamingAssets/Settings/
```
16. Copy over the ADMIN list. Change as you wish.
```
cp configs/adminlist.txt data/VRisingServer_Data/StreamingAssets/Settings/
```
17. Copy over the BAN list. Change as you wish
```
cp configs/banlist.txt data/VRisingServer_Data/StreamingAssets/Settings/
```
18. Start the Docker Container
```
./start_vrising_container.sh
```
19.
```
Connect and have fun
```

## Make sure you port forward ports UDP 9876 and 9877 or allow them in your firewall.



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
