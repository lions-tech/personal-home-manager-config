{ pkgs, ... }:

{
  home.sessionVariables.EDITOR = "emacs -nw";

  # configure custom-safe-themes via HomeManager?
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraConfig = ''
      ;; --------------- basics ---------------
      (setq column-number-mode t)
      (global-display-line-numbers-mode)
      (load-theme 'solarized-selenized-light t)

      ;; get rid of the annoying welcome buffer
      (defun startup-screen-advice (orig-fun &rest args)
        (when (= (seq-count #'buffer-file-name (buffer-list)) 0)
          (apply orig-fun args)))
      (advice-add 'display-startup-screen :around #'startup-screen-advice)

      ;; projectile
      (setq projectile-project-search-path '("~/devel/"))
      (setq projectile-completion-system 'ivy)
      (projectile-mode 1)

      ;; --------------- window ---------------
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (menu-bar-mode -1)

      ;; ace-window keys
      (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

      (defun toggle-window-split ()
        (interactive)
        (if (= (count-windows) 2)
            (let* ((this-win-buffer (window-buffer))
                (next-win-buffer (window-buffer (next-window)))
                (this-win-edges (window-edges (selected-window)))
                (next-win-edges (window-edges (next-window)))
                (this-win-2nd (not (and (<= (car this-win-edges)
                            (car next-win-edges))
                            (<= (cadr next-win-edges)))))
                (splitter
                  (if (= (car this-win-edges)
                    (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))


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
      ;; LSP servers
      (setq lsp-keymap-prefix "s-i")
      (setq lsp-nix-nil-server-path "${pkgs.nil}/bin/nil")
      (require 'lsp-mode)

      ;; magit
      (add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))

      ;; nix
      (add-hook 'nix-mode-hook 'nixpkgs-fmt-on-save-mode (lambda ()
        (setq standard-indent 2)
        (setq tab-width 2)
        (setq indent-tabs-mode nil))
      )
      (add-hook 'nix-mode-hook #'lsp-deferred)

      ;; shell
      (add-hook 'sh-mode-hook (lambda ()
        (setq standard-indent 2)
        (setq tab-width 2)
        (setq sh-basic-offset 2))
      )

      ;; plantuml
      (setq plantuml-executable-path "${pkgs.plantuml}/bin/plantuml")
      (setq plantuml-jar-path "${pkgs.plantuml}/lib/plantuml.jar")
      (setq plantuml-default-exec-mode 'executable) ;; possible values: 'jar 'executable 'server

      (global-aggressive-indent-mode 1)
      (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

      (require 'smartparens-config)
      (smartparens-global-mode)

      (add-hook 'after-init-hook 'global-company-mode)

      (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
      (setq xref-show-definitions-function #'xref-show-definitions-completing-read)

      ;; enable in all programming buffers
      (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

      (setq-default indent-tabs-mode nil)

      ;; --------------- text editing ---------------
      (defun enable-auto-fill ()
        "Activate auto-fill-mode and display-fill-column-indicator-mode"
        (interactive)
        (auto-fill-mode)
        (display-fill-column-indicator-mode)
      )
      (setq-default fill-column 100)

      ;; --------------- keybindings ---------------
      (with-eval-after-load 'lsp-ui-mode
        (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
        (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
      )

      (with-eval-after-load 'projectile
        (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

      (global-set-key (kbd "M-o") 'ace-window)

      (global-set-key (kbd "C-x |") 'toggle-window-split)

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

      (global-set-key (kbd "C-c q") 'enable-auto-fill)
    '';
    # to list available packages: nix-env -f '<nixpkgs>' -qaP -A emacsPackages
    extraPackages = epkgs: [
      epkgs.ace-window
      epkgs.aggressive-indent
      epkgs.auctex
      epkgs.company
      epkgs.counsel
      epkgs.dumb-jump
      epkgs.flycheck
      epkgs.idle-highlight-mode
      epkgs.ivy
      epkgs.lsp-mode
      epkgs.lsp-ivy
      epkgs.lsp-treemacs
      epkgs.lsp-ui
      epkgs.magit
      epkgs.magit-delta
      epkgs.marginalia
      epkgs.markdown-mode
      epkgs.multiple-cursors
      epkgs.nix-mode
      epkgs.nixpkgs-fmt
      epkgs.org
      epkgs.php-mode
      epkgs.plantuml-mode
      epkgs.projectile
      epkgs.python
      epkgs.rainbow-delimiters
      epkgs.rainbow-mode
      epkgs.rust-mode
      epkgs.smartparens
      epkgs.solarized-theme
      epkgs.swiper
      epkgs.typescript-mode
      epkgs.which-key
      epkgs.yasnippet
    ];
  };
}
