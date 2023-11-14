{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fira
    fira-mono
    fira-code
  ];

  # discover fonts installed via home.packages
  fonts.fontconfig.enable = true;
}
