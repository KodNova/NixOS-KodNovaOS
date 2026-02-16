_: {
  flake.nixosModules.base = _: {
    nixpkgs.config.allowUnfree = true;
    time.timeZone = "Canada/Central";

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
