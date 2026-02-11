{...}: {
  flake.nixosModules.solModule = {
    pkgs,
    lib,
    config,
    ...
  }: {
    my.username = "kodnova";
    my.email = "Dev@KodNova.dev";
    networking.hostName = "sol";

    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 7;
        efi.canTouchEfiVariables = true;
      };

      kernel.sysctl = {
        "vm.dirty_background_bytes" = 67108864;
        "vm.dirty_bytes" = 268435456;
        "vm.vfs_cache_pressure" = 50;
      };
    };

    services.fstrim.enable = true;

    # --- USER CONFIG ---
    users.mutableUsers = false;
    users.users.${config.my.username} = {
      isNormalUser = true;
      description = config.my.username;
      # WARN: placeholder password
      hashedPassword = "$y$j9T$aK/y4/XGb2iKqAEyjyXI70$yLczsgiS6cWz/U6JMlPHa2OVyYTnY52hmOGBx8s42cB";
      extraGroups = ["networkmanager" "wheel" "scanner" "lp" "libvirtd" "video" "render"];
      shell = pkgs.zsh;
    };

    # --- IMPERMANENCE --- NOTE:keeps
    environment.persistence."/persist" = {
      hideMounts = false;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/etc/NetworkManager/system-connections"
        "/var/lib/NetworkManager"
        "/etc/secureboot"
        "/var/db/sudo"
        "/srv"
      ];
      files = [
        "/etc/machine-id"
      ];

      users.${config.my.username} = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".local/share/Steam"
          ".steam"
          ".config/heroic"
          ".local/share/flatpak"
          ".var/app"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
        ];
        files = [
          ".zsh_history"
        ];
      };
    };

    system.stateVersion = "25.11";

    # NOTE: below here is from hardware gen
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
