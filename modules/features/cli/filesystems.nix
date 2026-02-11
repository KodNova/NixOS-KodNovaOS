_: {
  flake.nixosModules.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.parted];
  };

  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.exfatprogs pkgs.ntfs3g];
  };
}
