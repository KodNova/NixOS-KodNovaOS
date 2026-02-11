_: {
  flake.nixosModules.base = {pkgs, ...}: {
    programs.firefox.enable = true;
    environment.systemPackages = [pkgs.qbittorrent];
  };
}
