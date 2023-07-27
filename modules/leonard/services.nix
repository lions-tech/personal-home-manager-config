{ config, lib, pkgs, ... }:

{
  services = {
    dropbox.enable = true;
    flameshot.enable = true;
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
    };
  };
}
