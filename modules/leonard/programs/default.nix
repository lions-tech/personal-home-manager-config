{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./foot.nix
    ./git.nix
    ./java.nix
    ./pandoc.nix
    ./ripgrep.nix
    ./texlive.nix
    ./zettlr
    ./zoxide.nix
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
    aspell
    audacious
    ciscoPacketTracer8
    dbeaver
    easytag
    fd
    gimp
    inkscape
    keepassxc
    libreoffice
    neofetch
    newsflash
    nixpkgs-fmt
    nodejs
    plantuml
    prismlauncher
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

    gnome.dconf-editor
    gnome.gnome-system-monitor

    libsForQt5.okular
  ];

}

