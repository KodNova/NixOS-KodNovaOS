_: {
  flake.nixosModules.base = _: {
    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
