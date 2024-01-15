{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira
    fira-mono
    fira-code
    liberation_ttf
  ];

  # discover fonts installed via home.packages
  fonts.fontconfig.enable = true;
}
