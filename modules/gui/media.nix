_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.vlc pkgs.mpv pkgs.obs-studio];
  };
}
