
# VRising Dedicated Server Linux Docker
Run a VRising Dedicated Server on Linux via Docker

# Menu system coming soon for Linux Users only


## Server Hosting Provided By DigitalOcean
* https://m.do.co/c/9d2217a2725c
* Use my link and get 100 USD Server Credits from me,  over the next 60 Days!
* Free Credits without hacks... 

1.  
```
git clone https://github.com/Nimdy/VRising_Dedicated_Server.git
```
2.  
```
cd VRising_Dedicated_Server/
```
3.
```
chmod +x ./* -R
```
4. 
```
./runServer.sh
```

Now this will probably take a few minutes as it will;

  * Build the base docker image (10-20 mins)
  * Download the VRising Dedicated Server from Steam (~1.6GB)
  * Run the Dedicated Server for the first time (usually 5-10 minutes)

## Shutdown the docker service and continue with port configurations.

```
sudo docker stop vRisingServer
```

Edit this file for Server Settings:
```
./VRising-Dedicated-Server-Linux-Docker/data/save-data/ServerHostSettings.json
```
Change the Name, Port and QueryPort to match our Docker Ports (So outside can connect) and do not forget to port forward

    "Name": "YOURNAME V Rising Server [Linux Dedicated]",
    "Port": 27015,
    "QueryPort": 27016,



 Edit actual Game Settings:
 ```
 ./VRising-Dedicated-Server-Linux-Docker/data/save-data/ServerGameSettings.json
 ```

 Start the Docker VRising Server:
 
 ```
 ./VRising-Dedicated-Server-Linux-Docker/runServer.sh
 ```
 
 And get to Vampirising! (The script will always make sure the server is up to date before running it!)
 
 ---
 
 Credits;
 
 This Server uses the following Images;
 
 maloneweb/docker-wine-base:latest
 
 honestventures/steamcmd-linux-wine:latest
 
OG Script: https://github.com/smb1982/VRising-Dedicated-Server-Linux-Docker
