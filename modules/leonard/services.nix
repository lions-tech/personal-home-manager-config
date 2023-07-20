{ config, lib, pkgs, ... }:

{
  services = {
    dropbox.enable = true;
    flameshot = {
      enable = true;
      settings.General.showStartupLaunchMessage = false;
    };
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
  };

  systemd.user = {
    services = {
      # fix: flameshot.service no "tray.target"
      flameshot.Unit = {
        Requires = lib.mkForce [ ];
        Wants = lib.mkForce [ "tray.target" ];
      };

      # we need to set DISPLAY, otherwise the icon will not appear
      dropbox.Service.Environment = lib.mkForce [
        "HOME=${config.home.homeDirectory}/.dropbox-hm"
        "DISPLAY=:0"
      ];

      # Keep in mind: This does not update flake inputs
      home-manager-auto-upgrade.Service.ExecStart = lib.mkForce (toString
        (pkgs.writeShellScript "home-manager-upgrade-script" ''
          ${pkgs.home-manager}/bin/home-manager switch --flake 'github:lions-tech/personal-home-manager-config#leonard'
        '')
      );

      wallpaper-changer-gnome = {
        Unit.Description = "Change wallpaper on GNOME";
        Service.ExecStart = toString (pkgs.writeShellScript "wallpaper-changer-gnome-script" ''
          file=$(${pkgs.findutils}/bin/find ${pkgs.wallpapers} -type f | ${pkgs.coreutils}/bin/shuf -n 1)
          echo "$file"
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.background picture-uri "$file"
          ${pkgs.glib}/bin/gsettings set org.gnome.desktop.background picture-uri-dark "$file"
        '');
      };
    };

    timers = {
      wallpaper-changer-gnome = {
        Unit.Description = "Change wallpaper on GNOME timer";
        Install.WantedBy = [ "timers.target" ];

        Timer = {
          # every minute
          OnCalendar = "minutely";
          Unit = "wallpaper-changer-gnome.service";
          Persistent = true;
        };
      };
    };
  };
}
