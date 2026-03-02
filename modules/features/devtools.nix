_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.opencode
      pkgs.opencode-desktop
    ];
  };
}
