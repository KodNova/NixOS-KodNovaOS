_: {
  flake.nixosModules.workstation = _: {
    my.home = {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          # Browser
          "text/html" = ["firefox.desktop"];
          "x-scheme-handler/http" = ["firefox.desktop"];
          "x-scheme-handler/https" = ["firefox.desktop"];
          "x-scheme-handler/about" = ["firefox.desktop"];
          "x-scheme-handler/unknown" = ["firefox.desktop"];

          # Editor
          "text/plain" = ["dev.zed.Zed.desktop"];
          "application/json" = ["dev.zed.Zed.desktop"];

          # Images - Gwenview (Confirmed as org.kde.gwenview.desktop)
          "image/png" = ["org.kde.gwenview.desktop"];
          "image/jpeg" = ["org.kde.gwenview.desktop"];
          "image/gif" = ["org.kde.gwenview.desktop"];
          "image/webp" = ["org.kde.gwenview.desktop"];
          "image/bmp" = ["org.kde.gwenview.desktop"];
          "image/svg+xml" = ["org.kde.gwenview.desktop"];

          # Video - VLC & MPV (Confirmed as vlc.desktop and mpv.desktop)
          "video/mp4" = ["umpv.desktop"];
          "video/x-matroska" = ["umpv.desktop"];
          "video/webm" = ["umpv.desktop"];
          "video/mkv" = ["umpv.desktop"];

          # PDF & Directories
          "application/pdf" = ["firefox.desktop"];
          "inode/directory" = ["org.kde.dolphin.desktop"];

          # Archives
          "application/zip" = ["org.kde.ark.desktop"];
          "application/x-tar" = ["org.kde.ark.desktop"];
          "application/gzip" = ["org.kde.ark.desktop"];
        };

        # This section fixes the "Open With" menu showing no options
        associations.added = {
          "image/png" = ["org.kde.gwenview.desktop" "gimp.desktop"];
          "image/jpeg" = ["org.kde.gwenview.desktop" "gimp.desktop"];
          "video/mp4" = ["vlc.desktop" "umpv.desktop"];
          "video/x-matroska" = ["vlc.desktop" "umpv.desktop"];
          "video/webm" = ["vlc.desktop" "umpv.desktop"];
          "video/mkv" = ["vlc.desktop" "umpv.desktop"];
        };
      };
    };
  };
}
