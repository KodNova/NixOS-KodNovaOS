{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.sol = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.solModule
      self.nixosModules.base
      self.nixosModules.workstation
      self.nixosModules.impermanence
    ];
  };
}
