_: {
  flake.nixosModules.base = {pkgs, ...}: {
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

        superfile = {
          enable = true;
        };

        btop.enable = true;
      };
    };
  };

  flake.nixosModules.workstation = {pkgs, ...}: {
    my.home = {
      programs.btop.package = pkgs.btop-rocm;
    };
    environment.systemPackages = [pkgs.bleachbit pkgs.devbox];
  };
}
