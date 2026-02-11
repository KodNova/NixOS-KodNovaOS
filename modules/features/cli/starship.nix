_: {
  flake.nixosModules.base = _: {
    my.home = {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
