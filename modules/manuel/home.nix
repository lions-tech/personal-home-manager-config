{ config, pkgs, ... }:

{
  home = {
    username = "manuel";
    homeDirectory = "/home/manuel";
    stateVersion = "22.11";
    packages = with pkgs; [
      gimp
      gnome-console
      gnome-text-editor
      libreoffice
      shotwell
      telegram-desktop
      vivaldi

      libsForQt5.okular
    ];
  };
}
