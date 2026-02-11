_: {
  flake.nixosModules.base = _: {
    services = {
      tailscale.enable = true;
    };
  };

  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.veracrypt];
  };
}
