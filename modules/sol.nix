{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.sol = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.solModule
      self.nixosModules.browsers
    ];
  };

  flake.nixosModules.solModule = {
    pkgs,
    lib,
    config,
    ...
  }: {
    boot = {
      initrd = {
        availableKernelModules = ["xhci_pci" "ahci" "nvme" "uas" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
        kernelModules = [];
        luks.devices = {
          "crypt1".device = "/dev/disk/by-id/nvme-eui.002538d61141e9ff-part2";
          "crypt2".device = "/dev/disk/by-id/wwn-0x5002538d405c1877-part1";
          "crypt3".device = "/dev/disk/by-id/wwn-0x50025388a0541652-part1";
          "crypt4".device = "/dev/disk/by-id/wwn-0x5002538f3118e037-part1";
        };
      };
      kernelModules = ["kvm-intel"];
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
      "/games" = {
        device = "/dev/mapper/crypt1";
        fsType = "btrfs";
        options = ["subvol=@games" "nodatacow" "noatime"];
      };
      "/repos" = {
        device = "/dev/mapper/crypt1";
        fsType = "btrfs";
        options = ["subvol=@repos" "compress=zstd" "noatime"];
      };
      "/boot" = {
        device = "/dev/disk/by-id/nvme-eui.002538d61141e9ff-part1";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
