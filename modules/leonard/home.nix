{ config, pkgs, ... }:

{
  home = {
    username = "leonard";
    homeDirectory = "/home/leonard";
    stateVersion = "22.11";
    packages = with pkgs; [
      audacious
      ciscoPacketTracer8
      easytag
      gimp
      inkscape
      keepassxc
      #libreoffice
      neofetch
      nixpkgs-fmt
      prismlauncher
      shotwell
      telegram-desktop
      virtualbox
      vivaldi
      vlc

      gnome.dconf-editor
      gnome.gnome-system-monitor

      libsForQt5.okular
    ];

    sessionVariables = {
      EDITOR = "emacs -nw";
    };
  };
}
