{
  disko.devices.disk = {
    znvme = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-eui.002538d61141ea07";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1024M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypt1";
              passwordFile = "/tmp/secret.txt";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@repos" = {
                    mountpoint = "/repos";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
    };

    hdd2tb = {
      type = "disk";
      device = "/dev/disk/by-id/ata-WDC_WD20EZRZ-00Z5HB0_WD-WCC4M6PN8U5K";
      content = {
        type = "gpt";
        partitions.data = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypt-hdd2";
            passwordFile = "/tmp/secret.txt";
            settings.allowDiscards = true;
            # no content: member of the btrfs on hdd4tb
          };
        };
      };
    };

    hdd4tb = {
      type = "disk";
      device = "/dev/disk/by-id/ata-WDC_WD40EFAX-68JH4N0_WD-WX61DC9K7AL7";
      content = {
        type = "gpt";
        partitions.data = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypt-hdd4";
            passwordFile = "/tmp/secret.txt";
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "-d"
                "single"
                "-m"
                "raid1"
                "/dev/mapper/crypt-hdd2"
              ];
              subvolumes = {
                "@pool1" = {
                  mountpoint = "/mnt/pool1";
                  mountOptions = ["compress=zstd" "noatime"];
                };
                "@snapshots" = {
                  mountpoint = "/mnt/pool1-snapshots";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
  };
}
