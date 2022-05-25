docker run -d --rm \
--name='vrisingserver' \
-e TZ="Europe/London" \
-e "SERVERNAME=My V Server" \
-e "SAVENAME=server" \
-v /data/games/vrising:/app/vrising \
-p 9876:9876/udp \
-p 9877:9877/udp \
njordmenu/vrising:latest
