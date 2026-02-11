_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    fonts = {
      packages = [
        pkgs.noto-fonts
        pkgs.noto-fonts-cjk-sans
        pkgs.noto-fonts-color-emoji
        pkgs.liberation_ttf
        pkgs.fira-code
        pkgs.fira-code-symbols
        pkgs.mplus-outline-fonts.githubRelease
        pkgs.dina-font
        pkgs.proggyfonts
        pkgs.nerd-fonts.hack
        pkgs.nerd-fonts.droid-sans-mono
        pkgs.nerd-fonts.fira-code
      ];
      fontconfig.defaultFonts = {
        serif = ["Liberation Serif" "Noto Serif" "Hack Nerd Font"];
        sansSerif = ["Ubuntu" "Noto Sans" "Hack Nerd Font"];
        monospace = ["Hack Nerd Font"];
      };
    };
  };
}
