_: {
  flake.nixosModules.workstation = _: {
    services = {
      flatpak.enable = true;
    };
  };
}
