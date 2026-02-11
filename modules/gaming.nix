{inputs, ...}: {
  flake.nixosModules.gaming = _: {
    imports = [
      inputs.zwift.nixosModules.zwift
    ];

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
      zwift.enable = true;
    };
  };
}
