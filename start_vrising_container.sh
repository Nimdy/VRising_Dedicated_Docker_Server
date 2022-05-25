docker run -d --rm \
--name='vrisingserver' \
-e TZ="Europe/London" \
-e "SAVENAME=server" \
-v /home/steam/VRising_Dedicated_Docker_Server/data:/app/vrising \
-p 9876:9876/udp \
-p 9877:9877/udp \
njordmenu/vrising:latest
