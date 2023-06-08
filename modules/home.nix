{ config, pkgs, ... }:

{
  home = {
    username = "leonard";
    homeDirectory = "/home/leonard";
    stateVersion = "22.11";
    packages = with pkgs; [
      vivaldi
      libreoffice
      nixpkgs-fmt
      easytag
      keepassxc
      telegram-desktop
      neofetch
      #ciscoPacketTracer8
      gimp
      virtualbox
    ];

    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
