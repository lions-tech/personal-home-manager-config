{ pkgs, lib, ... }:

let
  configDir = ".config/Zettlr";
in
{
  home.packages = [ pkgs.zettlr ];
  home.file = {
    "custom.css" = {
      enable = true;
      source = ./custom.css;
      target = "${configDir}/custom.css";
    };
  };

  home.activation = {
    activateZettlr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p $HOME/${configDir}
      run cp --no-preserve=all ${./config.json} ${configDir}/config.json
    '';
  };
}
