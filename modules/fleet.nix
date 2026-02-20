{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations = {
    sol = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.solModule
        self.nixosModules.base
        self.nixosModules.home-manager
        self.nixosModules.workstation
        self.nixosModules.impermanence
        self.nixosModules.gaming
        self.nixosModules.hyprland
      ];
    };

    luna = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.lunaModule
        self.nixosModules.base
        self.nixosModules.home-manager
        self.nixosModules.workstation
        self.nixosModules.impermanence
        self.nixosModules.hyprland
      ];
    };

    zpm = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.zpmModule
        self.nixosModules.base
        self.nixosModules.home-manager
        self.nixosModules.server
        self.nixosModules.impermanence
      ];
    };
  };
}
