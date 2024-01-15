{
  xdg.mimeApps =
    let
      defaultBrowsers = [ "vivaldi-stable.desktop" "firefox.desktop" ];
      imageViewer = "org.gnome.Shotwell-Viewer.desktop";
      pdfViewer = "okularApplication_pdf.desktop";
      packet-tracer = "cisco-pt8.desktop.desktop";
      telegram = "userapp-Telegram Desktop-GIH8E2.desktop";
    in
    {
      enable = true;
      defaultApplications = {
        "text/html" = defaultBrowsers;
        "application/x-httpd-php" = defaultBrowsers;
        "application/xhtml+xml" = defaultBrowsers;
        "application/xml" = defaultBrowsers;
        "x-scheme-handler/http" = defaultBrowsers;
        "x-scheme-handler/https" = defaultBrowsers;

        "application/octet-stream" = packet-tracer;
        "x-scheme-handler/pttp" = packet-tracer;

        "application/pdf" = pdfViewer;
        "application/epub+zip" = pdfViewer;

        "image/png" = imageViewer;
        "image/gif" = imageViewer;
        "image/jpeg" = imageViewer;
        "image/svg+xml" = imageViewer;
        "image/webp" = imageViewer;

        "x-scheme-handler/tg" = telegram;
      };
      associations.added = {
        "x-scheme-handler/pttp" = packet-tracer;
        "application/octet-stream" = packet-tracer;
        "x-scheme-handler/tg" = telegram;
      };
    };
}
