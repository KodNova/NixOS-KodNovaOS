{
  description = "Nixos-KodNovaOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zwift.url = "github:netbrain/zwift";
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    zwift,
    impermanence,
    nixos-hardware,
    ...
  }: {
    nixosConfigurations = {
      # Desktop
      sol = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/sol/configuration.nix
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kodnova = {
                imports = [
                  ./home-manager/sol.nix
                ];
              };
            };
          }
          zwift.nixosModules.zwift
        ];
      };

      # Laptop
      puddleJumper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/puddleJumper/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kodnova = {
                imports = [
                  ./home-manager/puddleJumper.nix
                ];
              };
            };
          }
        ];
      };

      # Server
      zpm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/zpm/configuration.nix
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kodnova = {
                imports = [
                  ./home-manager/zpm.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
