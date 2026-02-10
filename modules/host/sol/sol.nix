{
  config,
  inputs,
  ...
}: {
  flake.nixosConfigurations.sol.sol = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      config.flake.modules.hosts.sol.hardware
    ];
  };
}
