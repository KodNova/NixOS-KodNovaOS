{inputs, ...}: {
  flake.nixosModules.base = {...}: {
    programs.firefox.enable = true;
  };
}
