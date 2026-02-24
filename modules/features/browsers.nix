_: {
  flake.nixosModules.base = {pkgs, ...}: {
    #NOTE: Zen and helium flatpaks. firefox is just a fallback.
    programs.firefox.enable = true;
    environment.systemPackages = [pkgs.qbittorrent];
  };
}
