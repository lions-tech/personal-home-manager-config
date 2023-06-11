{
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv.enable = true;

    terminator = {
      enable = true;
      # see man terminator_config(5)
      config = {
        global_config = {
          handle_size = 0;
          window_state = "maximise";
          borderless = true;
        };
        profiles = rec {
          default = {
            scrollback_infinite = true;
          } // theme-3024-night;
          # Source for themes: https://github.com/EliverLara/terminator-themes/tree/master/schemes
          theme-3024-night = {
            palette = "#090300:#db2d20:#01a252:#fded02:#01a0e4:#a16a94:#b5e4f4:#a5a2a2:#5c5855:#e8bbd0:#3a3432:#4a4543:#807d7c:#d6d5d4:#cdab53:#f7f7f7";
            background_color = "#090300";
            cursor_color = "#a5a2a2";
            foreground_color = "#a5a2a2";
            background_image = null;
          };
          theme-3024-day = {
            palette = "#090300:#db2d20:#01a252:#fded02:#01a0e4:#a16a94:#b5e4f4:#a5a2a2:#5c5855:#e8bbd0:#3a3432:#4a4543:#807d7c:#d6d5d4:#cdab53:#f7f7f7";
            background_color = "#f7f7f7";
            cursor_color = "#4a4543";
            foreground_color = "#4a4543";
            background_image = null;
          };
        };
      };
    };

    git = {
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

    # configure custom-safe-themes via HomeManager?
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
        epkgs.python
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
        neofetch
      '';
    };
  };
}
