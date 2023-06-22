{ config, lib, ... }:
{
  services = {
    dropbox.enable = true;
    flameshot.enable = true;
  };

  # fix: flameshot.service no "tray.target"
  systemd.user.services.flameshot.Unit = {
    Requires = lib.mkForce [ ];
    Wants = lib.mkForce [ "tray.target" ];
  };

  # we need to set DISPLAY, otherwise the icon will not appear
  systemd.user.services.dropbox.Service.Environment = lib.mkForce [
    "HOME=${config.home.homeDirectory}/.dropbox-hm"
    "DISPLAY=:0"
  ];
}
