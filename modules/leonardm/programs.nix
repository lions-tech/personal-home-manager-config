{ pkgs, ... }:

{
  imports = [
    ../leonard/programs/bat.nix
    ../leonard/programs/direnv.nix
    ../leonard/programs/emacs.nix
    ../leonard/programs/eza.nix
    ../leonard/programs/fzf.nix
    ../leonard/programs/git.nix
    ../leonard/programs/ripgrep.nix
    ../leonard/programs/tmux.nix
    ../leonard/programs/zoxide.nix
    ../leonard/programs/zsh.nix

  ];

  programs = {
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    aspell
    cherrytree
    easytag
    fd
    gimp
    gcc
    keepassxc
    #libreoffice - unsupported system
    nix-inspect
    nixpkgs-fmt
    plantuml
    telegram-desktop
    utm
    #vivaldi - unsupported system
    #vlc - unsupported system

    aspellDicts.de
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];
}
