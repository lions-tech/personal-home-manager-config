{ config, pkgs, ... }:

{
  home = {
    username = "leonard";
    homeDirectory = "/home/leonard";
    stateVersion = "22.11";
    packages = with pkgs; [
      vivaldi
      libreoffice
      nixpkgs-fmt
      easytag

      # TODO Upgrade to v 8.2.1
      #ciscoPacketTracer8

      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    sessionVariables = {
      EDITOR = "emacs";
    };
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    direnv.enable = true;

    terminator.enable = true;

    git = {
      enable = true;
      userName = "Leonard Mayer";
      userEmail = "lionstech@vivaldi.net";
      aliases = {
        co = "checkout";
        st = "status";
        amend = "commit --amend --no-edit";
      };
      ignores = [ "nohup.out" "*~" "#*" ];
    };

    emacs = {
      enable = true;
      extraConfig = ''
        (load-theme 'spacemacs-dark t)
        (setq-default indent-tabs-mode nil)
        (global-display-line-numbers-mode)

        (add-hook 'nix-mode-hook
                  (lambda () (setq standard-indent 2)))
        (add-hook 'nix-mode-hook
                  'nixpkgs-fmt-on-save-mode)
      '';
      # to list available packages: nix-env -f '<nixpkgs>' -qaP -A emacsPackages
      extraPackages = epkgs: [
        epkgs.spacemacs-theme
        epkgs.nix-mode
        epkgs.magit
        epkgs.nixpkgs-fmt
        epkgs.org
      ];
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      defaultKeymap = "emacs";
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
        alias emacs="emacs -nw"
      '';
    };
  };

  services = {
    dropbox.enable = true;
  };
}
