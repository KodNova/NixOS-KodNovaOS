_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.libreoffice-fresh pkgs.gimp];

    my.home = {
      programs.obsidian = {
        enable = true;
      };
    };
  };
}
