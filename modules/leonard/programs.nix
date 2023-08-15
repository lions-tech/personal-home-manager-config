{ pkgs, ... }:

let
  defaultBrowsers = [ "vivaldi-stable.desktop" "firefox.desktop" ];
in
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
        ;; --------------- basics ---------------
        (setq column-number-mode t)
        (global-display-line-numbers-mode)
        (load-theme 'spacemacs-dark t)

        ;; --------------- window ---------------
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (menu-bar-mode -1)
        (toggle-frame-fullscreen)

        ;; ace-window keys
        (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

        ;; get rid of the annoying welcome buffer
        (defun startup-screen-advice (orig-fun &rest args)
          (when (= (seq-count #'buffer-file-name (buffer-list)) 0)
            (apply orig-fun args)))
        (advice-add 'display-startup-screen :around #'startup-screen-advice)


        ;; --------------- editing and minibuffer ---------------
        (ivy-mode 1)
        (setq ivy-use-virtual-buffers t)
        (setq ivy-count-format "(%d/%d) ")

        (which-key-mode)
        (which-key-setup-side-window-bottom)

        (marginalia-mode)

        (idle-highlight-global-mode)

        (require 'multiple-cursors)


        ;; --------------- programming settings ---------------
        (add-hook 'nix-mode-hook 'nixpkgs-fmt-on-save-mode (lambda ()
          (setq standard-indent 2)
          (setq tab-width 2)
          (setq indent-tabs-mode nil))
        )

        (global-aggressive-indent-mode 1)
        (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

        (require 'smartparens-config)
        (smartparens-global-mode)

        (add-hook 'after-init-hook 'global-company-mode)

        (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
        (setq xref-show-definitions-function #'xref-show-definitions-completing-read)

        ;; enable in all programming buffers
        (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

        ;; --------------- keybindings ---------------
        (global-set-key (kbd "M-o") 'ace-window)

        (global-set-key (kbd "C-x c e") 'mc/edit-lines)
        (global-set-key (kbd "C-x c n") 'mc/mark-next-like-this)
        (global-set-key (kbd "C-x c p") 'mc/mark-previous-like-this)
        (global-set-key (kbd "C-x c a") 'mc/mark-all-like-this)

        (global-set-key (kbd "C-s") 'swiper-isearch)
        (global-set-key (kbd "M-x") 'counsel-M-x)
        (global-set-key (kbd "C-x C-f") 'counsel-find-file)
        (global-set-key (kbd "M-y") 'counsel-yank-pop)
        (global-set-key (kbd "<f1> f") 'counsel-describe-function)
        (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
        (global-set-key (kbd "<f1> l") 'counsel-find-library)
        (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
        (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
        (global-set-key (kbd "<f2> j") 'counsel-set-variable)
        (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
        (global-set-key (kbd "C-c v") 'ivy-push-view)
        (global-set-key (kbd "C-c V") 'ivy-pop-view)

        (global-set-key (kbd "C-c c") 'counsel-compile)
        (global-set-key (kbd "C-c g") 'counsel-git)
        (global-set-key (kbd "C-c j") 'counsel-git-grep)
        (global-set-key (kbd "C-c L") 'counsel-git-log)
        (global-set-key (kbd "C-c k") 'counsel-rg)
        (global-set-key (kbd "C-c m") 'counsel-linux-app)
        (global-set-key (kbd "C-c n") 'counsel-fzf)
        (global-set-key (kbd "C-x l") 'counsel-locate)
        (global-set-key (kbd "C-c J") 'counsel-file-jump)
        (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
        (global-set-key (kbd "C-c w") 'counsel-wmctrl)

        (global-set-key (kbd "C-c C-r") 'ivy-resume)
        (global-set-key (kbd "C-c b") 'counsel-bookmark)
        (global-set-key (kbd "C-c d") 'counsel-descbinds)
        (global-set-key (kbd "C-c g") 'counsel-git)
        (global-set-key (kbd "C-c o") 'counsel-outline)
        (global-set-key (kbd "C-c t") 'counsel-load-theme)
        (global-set-key (kbd "C-c F") 'counsel-org-file)
      '';
      # to list available packages: nix-env -f '<nixpkgs>' -qaP -A emacsPackages
      extraPackages = epkgs: [
        epkgs.ace-window
        epkgs.aggressive-indent
        epkgs.company
        epkgs.counsel
        epkgs.dumb-jump
        epkgs.idle-highlight-mode
        epkgs.ivy
        epkgs.magit
        epkgs.marginalia
        epkgs.markdown-mode
        epkgs.multiple-cursors
        epkgs.nix-mode
        epkgs.nixpkgs-fmt
        epkgs.org
        epkgs.python
        epkgs.rainbow-delimiters
        epkgs.rainbow-mode
        epkgs.rust-mode
        epkgs.smartparens
        epkgs.spacemacs-theme
        epkgs.swiper
        epkgs.typescript-mode
        epkgs.which-key
      ];
    };

    zsh = {
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

    firefox.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = defaultBrowsers;
      "application/x-httpd-php" = defaultBrowsers;
      "application/xhtml+xml" = defaultBrowsers;
      "application/xml" = defaultBrowsers;
      "x-scheme-handler/http" = defaultBrowsers;
      "x-scheme-handler/https" = defaultBrowsers;

      "application/octet-stream" = "cisco-pt8.desktop.desktop";

      "application/pdf" = "okularApplication_pdf.desktop";
      "application/epub+zip" = "okularApplication_epub.desktop";

      "image/png" = "org.gnome.Shotwell-Viewer.desktop";
      "image/gif" = "org.gnome.Shotwell-Viewer.desktop";
      "image/jpeg" = "org.gnome.Shotwell-Viewer.desktop";
      "image/svg+xml" = "org.gnome.Shotwell-Viewer.desktop";
      "image/webp" = "org.gnome.Shotwell-Viewer.desktop";


    };
    associations.added = {
      "application/octet-stream" = "cisco-pt8.desktop.desktop";
    };
  };
}

