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

    services = {
      fstrim = {
        enable = true;
        interval = "weekly"; # This is the default; can also be "daily"
      };

      # Laptop-specific power savings
      tlp = {
        enable = true;
        settings = {
          # Default to 80% to protect battery health
          START_CHARGE_THRESH_BAT0 = 75;
          STOP_CHARGE_THRESH_BAT0 = 80;

          # Better power management for T14
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        };
      };

      libinput = {
        enable = true;
        touchpad = {
          accelSpeed = "-0.5";
          accelProfile = "flat";
        };
        mouse = {
          accelSpeed = "-0.2";
          accelProfile = "flat";
        };
      };
    };

    system.stateVersion = "25.11";
  };
}
