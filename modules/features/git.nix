_: {
  flake.nixosModules.base = {
    config,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.git];
    my.home = {
      programs.git = {
        enable = true;
        userName = config.my.username;
        userEmail = config.my.email;
      };
    };
  };
}
