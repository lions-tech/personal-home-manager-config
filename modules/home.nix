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

      # TODO Upgrade to v 8.2.1
      #ciscoPacketTracer8
    ];

    sessionVariables = {
      EDITOR = "emacs";
    };
  };
}
