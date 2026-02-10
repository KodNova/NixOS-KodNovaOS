{inputs, ...}: {
  flake.nixosModules.broswers = {...}: {
    programs.firefox.enable = true;
  };
}
