{ lib, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "fingers";
      disable-while-typing = true;
      natural-scroll = true;
      tap-and-drag = true;
      # 1 finger = left; 2 fingers = right; 3 fingers = middle
      tap-button-map = "lrm";
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/shell" = {
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" ];
    };
  };

  home.packages = [ pkgs.gnomeExtensions.appindicator ];
}
