_: {
  flake.nixosModules.lunaModule = _: {
    networking = {
      hostName = "luna";
      networkmanager.enable = true;
    };

    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 7;
        efi.canTouchEfiVariables = true;
      };
    };

    services.fstrim = {
      enable = true;
      interval = "weekly"; # This is the default; can also be "daily"
    };

    system.stateVersion = "25.11";
  };
}
