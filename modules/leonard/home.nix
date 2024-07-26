{ pkgs, ... }:

{
  home = {
    username = "leonard";
    homeDirectory = "/home/leonard";
    stateVersion = "22.11";
    shellAliases = {
      cat = "bat --paging=never";
    };
    sessionVariables = {
      EDITOR = "emacs -nw";
      PAGER = "bat";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      BAT_THEME = "Solarized (light)"; # used by delta
    };
  };
}
