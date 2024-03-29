{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}'" ];
    colors = {
      fg = "-1";
      bg = "-1";
      hl = "33";
      "fg+" = "235";
      "bg+" = "-1";
      "hl+" = "33";
      info = "136";
      prompt = "136";
      pointer = "234";
      marker = "234";
      spinner = "136";
    };
  };
}
