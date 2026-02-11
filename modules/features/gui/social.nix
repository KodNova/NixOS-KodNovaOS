_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.signal-desktop pkgs.discord];
  };
}
