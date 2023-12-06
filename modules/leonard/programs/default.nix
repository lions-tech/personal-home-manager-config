{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./git.nix
    ./pandoc.nix
    ./terminator.nix
    ./texlive.nix
    ./zsh.nix

    ./xdg.nix

    ./nix.nix
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    direnv.enable = true;
    firefox.enable = true;
    yt-dlp.enable = true;
  };

  home.packages = with pkgs; [
    audacious
    ciscoPacketTracer8
    easytag
    gimp
    inkscape
    keepassxc
    libreoffice
    neofetch
    newsflash
    nixpkgs-fmt
    prismlauncher
    shotwell
    telegram-desktop
    unzip
    virtualbox
    vivaldi
    vlc
    zip

    gnome.dconf-editor
    gnome.gnome-system-monitor

    libsForQt5.okular
  ];

}

