_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.libreoffice-fresh
      pkgs.gimp
      pkgs.localsend
      pkgs.remmina
      pkgs.papirus-icon-theme
      pkgs.bleachbit
      pkgs.piper
    ];

    services = {
      ratbagd.enable = true; # Backend for Piper. Mouse.
    };

    programs = {
      appimage = {
        enable = true;
        binfmt = true;
      };
    };

    my.home = {
      programs.obsidian = {
        enable = true;
        vaults.obsidian_main = {
          target = "Documents/obsidian_vaults/obsidian_main";
        };
      };
    };
  };
}
