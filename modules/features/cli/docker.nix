_: {
  flake.nixosModules.server = {
    pkgs,
    config,
    ...
  }: {
    virtualisation.docker.enable = true;

    users.users.${config.my.username}.extraGroups = ["docker"];
    environment.systemPackages = [pkgs.docker-compose];

    my.home = {
      programs.lazydocker.enable = true;
    };
  };
}
