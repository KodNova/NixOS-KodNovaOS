{inputs, ...}: {
  flake.nixosModules.home-manager = {
    lib,
    config,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    options.my = {
      username = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
      home = lib.mkOption {
        type = lib.types.deferredModule;
        default = {};
      };
    };

    config = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      home-manager.users.${config.my.username} = {
        imports = [config.my.home];
        home.stateVersion = "25.11";
      };
    };
  };
}
