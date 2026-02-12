_: {
  flake.nixosModules.base = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.waypipe
      pkgs.dust
      pkgs.procs
      pkgs.wget
      pkgs.unzip
      pkgs.fastfetch
      pkgs.tokei
      pkgs.bottom
      pkgs.sshfs
    ];

    my.home = {
      programs = {
        tealdeer = {
          enable = true;
          settings = {
            updates.auto_update = true;
          };
        };

        bat = {
          enable = true;
          config = {
            theme = "Catppuccin Mocha";
          };
          themes = {
            "Catppuccin Mocha" = {
              src = pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "bat";
                rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
                sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
              };
              file = "themes/Catppuccin Mocha.tmTheme";
            };
          };
        };

        eza = {
          enable = true;
          colors = "auto";
          enableZshIntegration = true;
          git = true;
          icons = "auto";
          extraOptions = ["--group-directories-first"];
        };

        ripgrep.enable = true;

        fd.enable = true;

        superfile = {
          enable = true;
        };

        btop.enable = true;
      };

      xdg.configFile."eza/theme.yml".source =
        (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "eza";
          rev = "70f805f6cc27fa5b91750b75afb4296a0ec7fec9";
          sha256 = "sha256-Q+C07IReQQBO5xYuFiFbS1wjmO4gdt/wIJWHNwIizSc=";
        })
        + "/themes/catppuccin_mocha.yml";
    };
  };

  flake.nixosModules.workstation = {pkgs, ...}: {
    my.home = {
      programs.btop.package = pkgs.btop-rocm;
    };
    environment.systemPackages = [pkgs.devbox pkgs.yt-dlp pkgs.ffmpeg];
  };
}
