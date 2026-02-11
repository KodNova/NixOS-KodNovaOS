_: {
  flake.nixosModules.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.neovim];
  };

  flake.nixosModules.workstation = _: {
    my.home = {
      programs = {
        zed-editor = {
          enable = false;
        };
        neovide = {
          enable = false;
        };
      };
    };
  };
}
