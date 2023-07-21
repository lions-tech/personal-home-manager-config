{ config, lib, pkgs, ... }:

{
  services = {
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

      # Keep in mind: This does not update flake inputs
      home-manager-auto-upgrade.Service.ExecStart = lib.mkForce (toString
        (pkgs.writeShellScript "home-manager-upgrade-script" ''
          ${pkgs.home-manager}/bin/home-manager switch --flake github:lions-tech/personal-home-manager-config#manuel
        '')
      );
    };
  };
}
