{
  programs.git = {
    enable = true;
    userName = "LionsTech";
    userEmail = "lionstech@vivaldi.net";
    aliases = {
      co = "checkout";
      st = "status";
      amend = "commit --amend --no-edit";
    };
    ignores = [ "nohup.out" "*~" "\#*\#" ];
    extraConfig = {
      push.autoSetupRemote = true;
      merge.conflictstyle = "diff3";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = false;
        side-by-side = true;
      };
    };
  };
}
