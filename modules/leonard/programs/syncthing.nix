let
  configDir = ".config/syncthing";
in
{
  # Via GUI manually configure mayerbox as distributing device
  # and enable automatic acception of folders from mayerbox.
  # Do not pin the config as this makes problems with devices
  # learned from mayerbox.
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--home=${configDir}"
    ];
  };
}
