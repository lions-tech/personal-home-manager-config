{ config, pkgs, ... }:

{
  home = {
    username = "leonard";
    homeDirectory = "/home/leonard";
    stateVersion = "22.11";
    packages = with pkgs; [
      ciscoPacketTracer8
      easytag
      gimp
      keepassxc
      libreoffice
      neofetch
      nixpkgs-fmt
      shotwell
      telegram-desktop
      virtualbox
      vivaldi

      gnome.dconf-editor
      gnome.gnome-system-monitor

      libsForQt5.okular
    ];

    sessionVariables = {
      EDITOR = "emacs -nw";
    };
  };
}