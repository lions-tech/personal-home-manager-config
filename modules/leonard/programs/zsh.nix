{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "emacs";
    syntaxHighlighting.enable = true;
    history = {
      ignoreDups = true;
      share = true;
    };
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "web-search"
        "dirhistory"
      ];
      theme = "candy";
    };
    initExtra = ''
      neofetch
    '';
    plugins = [
      {
        name = "cmdtime";
        src = pkgs.fetchFromGitHub
          {
            owner = "tom-auger";
            repo = "cmdtime";
            rev = "ffc72641dcfa0ee6666ceb1dc712b61be30a1e8b";
            sha256 = "0a1q2k5kpdq5l33c49bjplibrdwn7a0m3cifn7vk0p0gv9y05b5z";
          };
      }
    ];
  };
}
