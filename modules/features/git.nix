_: {
  flake.nixosModules.base = {
    config,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.git pkgs.lazygit pkgs.jujutsu];
    my.home = {
      programs.git = {
        enable = true;
        settings = {
          user.name = config.my.username;
          user.email = config.my.email;
        };
      };
    };
  };
}
