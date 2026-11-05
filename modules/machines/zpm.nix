_: {
  flake.nixosModules.zpmModule = {
    lib,
    config,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    networking = {
      hostName = "zpm";
      networkmanager.enable = true;
    };

    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 7;
        efi.canTouchEfiVariables = true;
      };

      initrd = {
        # replace with the output of nixos-generate-config on the server
        availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod"];
        kernelModules = [];
        luks.devices = {
          "crypt1".device = "/dev/disk/by-id/nvme-eui.002538d61141ea07-part2";
          "crypt-hdd2".device = "/dev/disk/by-id/ata-WDC_WD20EZRZ-00Z5HB0_WD-WCC4M6PN8U5K-part1";
          "crypt-hdd4".device = "/dev/disk/by-id/ata-WDC_WD40EFAX-68JH4N0_WD-WX61DC9K7AL7-part1";
        };
      };
      kernelModules = ["kvm-intel"]; # kvm-amd if AMD
      extraModulePackages = [];
    };

    fileSystems = {
      "/" = {
        device = "/dev/mapper/crypt1";
        fsType = "btrfs";
        options = ["subvol=@" "compress=zstd" "noatime"];
      };
      "/nix" = {
        device = "/dev/mapper/crypt1";
        fsType = "btrfs";
        options = ["subvol=@nix" "compress=zstd" "noatime"];
      };
      "/persist" = {
        device = "/dev/mapper/crypt1";
        fsType = "btrfs";
        options = ["subvol=@persist" "compress=zstd" "noatime"];
        neededForBoot = true;
      };
      "/repos" = {
        device = "/dev/mapper/crypt1";
        fsType = "btrfs";
        options = ["subvol=@repos" "compress=zstd" "noatime"];
      };
      "/boot" = {
        device = "/dev/disk/by-id/nvme-eui.002538d61141ea07-part1";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };

      # HDD pool (2TB + 4TB). Either member device works for mounting.
      "/mnt/pool1" = {
        device = "/dev/mapper/crypt-hdd4";
        fsType = "btrfs";
        options = ["subvol=@pool1" "compress=zstd" "noatime" "nofail"];
      };
      "/mnt/pool1-snapshots" = {
        device = "/dev/mapper/crypt-hdd4";
        fsType = "btrfs";
        options = ["subvol=@snapshots" "compress=zstd" "noatime" "nofail"];
      };
    };

    swapDevices = [];

    services.fstrim = {
      enable = true;
      interval = "weekly";
    };

    zramSwap = {
      enable = true;
      memoryPercent = 20;
    };

    system.stateVersion = "25.11";

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
