#image is based on ubuntu:18.04
FROM ubuntu:18.04
#set root password
RUN echo "root:ubuntu" | chpasswd
# install packages
RUN apt-get update \
    && apt-get install --yes --force-yes --no-install-recommends \
	sudo \
        software-properties-common \
        xorg \
        xserver-xorg \
        xfce4 \
        gnome-themes-standard \
        gtk2-engines-pixbuf \
        file-roller \
        evince \
        gpicview \
        leafpad \
        xfce4-whiskermenu-plugin \
        ttf-ubuntu-font-family \
        dbus-x11 \
        vnc4server \
	vim \
	xfce4-terminal \
	xrdp \
	xorgxrdp
# add the user and designate sudo authority
RUN adduser ubuntu
RUN echo "ubuntu:ubuntu" | chpasswd
RUN echo "ubuntu ALL=(ALL:ALL) ALL" >> /etc/sudoers
#set the port number of xrdp
RUN sed -i 's/3389/port_number/' /etc/xrdp/xrdp.ini
#install xubuntu-desktop
RUN apt-get install --yes --force-yes --no-install-recommends \
	xubuntu-desktop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# insert entrypoint.sh and set ENTRYPOINT
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh

