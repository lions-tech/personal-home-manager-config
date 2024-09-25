{ pkgs, lib, config, ... }:

{
  imports = [
    ../leonard/programs/bat.nix
    ../leonard/programs/direnv.nix
    ../leonard/programs/emacs.nix
    ../leonard/programs/eza.nix
    ../leonard/programs/fzf.nix
    ../leonard/programs/git.nix
    ../leonard/programs/pandoc.nix
    ../leonard/programs/ripgrep.nix
    ../leonard/programs/syncthing.nix
    ../leonard/programs/tmux.nix
    ../leonard/programs/zoxide.nix
    ../leonard/programs/zsh.nix
  ];


  programs = {
    home-manager.enable = true;
    zsh = {
      profileExtra = builtins.readFile ./.zprofile;
      initExtra = ''
        # Make sure nix is available (this is persistent over upgrades)
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
      '';
    };
  };

  services.syncthing.extraOptions = lib.mkForce [
    "--home=${config.home.homeDirectory}/.config/syncthing"
  ];

  # TODO: https://github.com/sbmpost/AutoRaise
  home.packages = with pkgs; [
    android-tools
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
    #telegram-desktop - video view not working well
    texmacs
    #utm - broken, when creating kali 2024.2 ARM VM efi_vars.fd is readonly and VM crashes
    #      chmod u+w prevents the crash, but non-graphical install is not
    #      possible due to black screen
    #vivaldi - unsupported system
    #vlc - unsupported system
    wireguard-tools

    aspellDicts.de
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];

  /*
   * PACKAGES INSTALLED WITHOUT home-manager
   *
   * ---------------------------------------
   * - Cisco PacketTracer (manual)
   * - homebrew (manual)
   * - utm (brew)
   * - vivaldi (brew)
   * - Pixea (AppStore)
   * - telegram (brew)
   * - Kindle (AppStore)
   * - foxitreader (brew)
   * - libreoffice (brew)
   */
}

