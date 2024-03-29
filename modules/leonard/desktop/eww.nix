{ pkgs, ... }:

{
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ./eww;
  };

  home.packages = with pkgs; [
    pamixer
    alsa-utils
    brightnessctl
    networkmanager_dmenu
    jq
  ];
}
