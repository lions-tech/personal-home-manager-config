{ pkgs, ... }:

{
  home.packages = [ pkgs.zettlr ];
  home.file = {
    "custom.css" = {
      enable = true;
      source = ./custom.css;
      target = ".config/Zettlr/custom.css";
    };
  };
}
