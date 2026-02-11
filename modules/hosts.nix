{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.sol = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.solModule
      self.nixosModules.workstation
    ];
  };
}
