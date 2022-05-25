FROM maloneweb/docker-wine-base:latest

ARG DEBIAN_FRONTEND="noninteractive"
ARG WINE_MONO_VERSION="4.7.3"

# XVFB
ARG DISPLAY=:0

# Wine
ARG WINEPREFIX=/root/.wine
ARG WINEARCH=win64

# Custom Helper Scripts
COPY scripts/waitforprocess.sh /usr/local/bin/waitforprocess.sh
COPY scripts/x11-start.sh /usr/local/bin/x11-start.sh

# Build Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Required for winetricks
    cabextract \
    p7zip \
    unzip \
    wget \
    xvfb \
    zenity \
    # Winetricks and Permissions
    && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/local/bin/winetricks \
    && chmod +x /usr/local/bin/winetricks \
    && chmod +x /usr/local/bin/*.sh \
    # Mono For Wine
    && mkdir /tmp/wine-mono \
    && wget https://dl.winehq.org/wine/wine-mono/${WINE_MONO_VERSION}/wine-mono-${WINE_MONO_VERSION}.msi -O /tmp/wine-mono/wine-mono-${WINE_MONO_VERSION} \ 
    # Install .NET Framework 2.0 and 4.6.2
    && wine wineboot --init \
    && waitforprocess.sh wineserver \
    && x11-start.sh \
    && winetricks --unattended --force vcrun2019 dotnet20 dotnet40 dotnet45 msxml6 dotnet_verifier

# Copy Over Wine Prefix
FROM maloneweb/docker-wine-base:latest

ENV WINEPREFIX /root/.wine
ENV WINEARCH win64

RUN mkdir -p /usr/share/wine/mono

COPY --from=0 /root/.wine /root/.wine
COPY --from=0 /tmp/wine-mono /usr/share/wine/mono

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Required for winetricks
    cabextract \
    p7zip \
    unzip \
    wget \
    xvfb
