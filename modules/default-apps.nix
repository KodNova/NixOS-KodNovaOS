_: {
  flake.nixosModules.workstation = _: {
    my.home = {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          # Browser
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";

          # Editor
          "text/plain" = "dev.zed.Zed.desktop";
          "application/json" = "dev.zed.Zed.desktop";

          # Images - Gwenview
          "image/png" = "org.kde.gwenview.desktop";
          "image/jpeg" = "org.kde.gwenview.desktop";
          "image/gif" = "org.kde.gwenview.desktop";
          "image/webp" = "org.kde.gwenview.desktop";
          "image/bmp" = "org.kde.gwenview.desktop";
          "image/svg+xml" = "org.kde.gwenview.desktop";

          # Video - VLC
          "video/mp4" = "org.videolan.VLC.desktop";
          "video/x-matroska" = "org.videolan.VLC.desktop";
          "video/webm" = "org.videolan.VLC.desktop";

          # PDF - Okular
          "application/pdf" = "org.kde.okular.desktop";

          # Archives - Ark
          "application/zip" = "org.kde.ark.desktop";
          "application/x-tar" = "org.kde.ark.desktop";
          "application/gzip" = "org.kde.ark.desktop";
        };
      };
    };
  };
}
