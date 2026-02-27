_: {
  flake.nixosModules.lunaModule = {
    lib,
    config,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
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

    boot.initrd.availableKernelModules = ["nvme" "ehci_pci" "xhci_pci_renesas" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/mapper/crypt1";
      fsType = "btrfs";
      options = ["subvol=@"];
    };

    boot.initrd.luks.devices."crypt1".device = "/dev/disk/by-uuid/6500c6a4-bae3-4840-a1b5-5f44bd28cba7";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/C21C-20E4";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    fileSystems."/nix" = {
      device = "/dev/mapper/crypt1";
      fsType = "btrfs";
      options = ["subvol=@nix"];
    };

    fileSystems."/persist" = {
      device = "/dev/mapper/crypt1";
      fsType = "btrfs";
      options = ["subvol=@persist"];
      neededForBoot = true;
    };

    fileSystems."/repos" = {
      device = "/dev/mapper/crypt1";
      fsType = "btrfs";
      options = ["subvol=@repos"];
    };

    swapDevices = [];

    zramSwap = {
      enable = true;
      memoryPercent = 50;
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
