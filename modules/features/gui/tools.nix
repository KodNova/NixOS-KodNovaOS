_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.libreoffice-fresh pkgs.gimp pkgs.localsend pkgs.remmina];

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
