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
        # self.nixosModules.mango
      ];
    };

    luna = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.lunaModule
        self.nixosModules.base
        self.nixosModules.home-manager
        self.nixosModules.workstation
        self.nixosModules.impermanence
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
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
