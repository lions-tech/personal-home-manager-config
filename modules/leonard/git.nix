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
    ignores = [ "nohup.out" "*~" "#*" ];
  };
}
