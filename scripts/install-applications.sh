#!/usr/bin/env sh

set -e

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install --user --noninteractive flathub \
  re.sonny.Junction \
  org.gnome.Loupe org.gnome.Papers \
  org.gnome.Contacts org.gnome.Calendar \
  com.github.neithern.g4music org.videolan.VLC com.github.KRTirtho.Spotube \
  io.gitlab.librewolf-community \
  org.ferdium.Ferdium \
  org.libreoffice.LibreOffice org.onlyoffice.desktopeditors \
  org.torproject.torbrowser-launcher \
  me.kozec.syncthingtk org.keepassxc.KeePassXC \
  app.organicmaps.desktop \
  org.gnome.Firmware

systemctl enable --user --now syncthing.service
