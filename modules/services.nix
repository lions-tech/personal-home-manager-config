{ lib, ... }:
{
  # TODO: fix dropbox
  services = {
    dropbox.enable = true;
    flameshot.enable = true;
  };

  # fix: flameshot.service no "tray.target"
  systemd.user.services.flameshot.Unit = {
    Requires = lib.mkForce [ ];
    Wants = lib.mkForce [ "tray.target" ];
  };
}
