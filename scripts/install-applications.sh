#!/usr/bin/env sh

set -e

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install --user --noninteractive flathub \
  org.gnome.Loupe org.gnome.Papers \
  org.gnome.Contacts org.gnome.Calendar \
  com.github.neithern.g4music org.videolan.VLC com.github.KRTirtho.Spotube \
  io.gitlab.librewolf-community com.github.Eloston.UngoogledChromium \
  org.ferdium.Ferdium \
  org.libreoffice.LibreOffice org.onlyoffice.desktopeditors \
  io.github.alexkdeveloper.calculator \
  org.torproject.torbrowser-launcher \
  ch.protonmail.protonmail-bridge \
  me.kozec.syncthingtk org.keepassxc.KeePassXC \
  app.organicmaps.desktop \
  org.gnome.Firmware
