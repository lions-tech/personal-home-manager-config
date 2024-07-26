{ pkgs, ... }:

{
  # TODO: Merge esg config
  imports = [
    ./bat.nix
    ./direnv.nix
    ./emacs.nix
    ./eza.nix
    ./foot.nix
    ./fzf.nix
    ./git.nix
    ./java.nix
    #./obs-studio.nix
    ./pandoc.nix
    ./ripgrep.nix
    #./texlive.nix
    ./tmux.nix
    ./zettlr
    ./zoxide.nix
    ./zsh.nix

    ./xdg.nix

    #./nix.nix - normally system-wide configured
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    firefox.enable = true;
    yt-dlp.enable = true;
  };

  home.packages = with pkgs; [
    aspell
    audacious
    ciscoPacketTracer8
    cherrytree
    dbeaver-bin
    easytag
    fd
    gimp
    inkscape
    keepassxc
    libreoffice
    libxml2
    newsflash
    nix-inspect
    nixpkgs-fmt
    nodejs
    plantuml
    prismlauncher
    qalculate-qt
    shotwell
    swaylock-effects
    telegram-desktop
    unzip
    virtualbox
    vivaldi
    vlc
    zip

    aspellDicts.de
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    dconf-editor
    gnome-system-monitor

    libsForQt5.okular
  ];

}

