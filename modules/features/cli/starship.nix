_: {
  flake.nixosModules.base = _: {
    my.home = {
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
