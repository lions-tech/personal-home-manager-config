{ pkgs, ... }:

let
  defaultBrowsers = [ "vivaldi-stable.desktop" "firefox.desktop" ];
in
{
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    firefox.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = defaultBrowsers;
      "application/x-httpd-php" = defaultBrowsers;
      "application/xhtml+xml" = defaultBrowsers;
      "application/xml" = defaultBrowsers;
      "x-scheme-handler/http" = defaultBrowsers;
      "x-scheme-handler/https" = defaultBrowsers;

      "application/octet-stream" = "cisco-pt8.desktop.desktop";

      "application/pdf" = "okularApplication_pdf.desktop";
      "application/epub+zip" = "okularApplication_epub.desktop";

      "image/png" = "org.gnome.Shotwell-Viewer.desktop";
      "image/gif" = "org.gnome.Shotwell-Viewer.desktop";
      "image/jpeg" = "org.gnome.Shotwell-Viewer.desktop";
      "image/svg+xml" = "org.gnome.Shotwell-Viewer.desktop";
      "image/webp" = "org.gnome.Shotwell-Viewer.desktop";
    };

    associations.added = {
      "application/octet-stream" = "cisco-pt8.desktop.desktop";
    };
  };
}

