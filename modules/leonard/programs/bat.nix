{
  programs.bat = {
    enable = true;
    config.theme = "Solarized (light)";
  };

  home = {
    shellAliases = {
      cat = "bat --paging=never";
    };
    sessionVariables = {
      PAGER = "bat";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      BAT_THEME = "Solarized (light)"; # used by delta
    };
  };
}
