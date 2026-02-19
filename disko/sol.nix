{
  disko.devices = {
    disk = {
      znvme = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-eui.002538d61141e9ff";
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
                  extraArgs = ["-f" "-d" "raid0" "-m" "raid1" "/dev/mapper/crypt2" "/dev/mapper/crypt3" "/dev/mapper/crypt4"];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime" "device=/dev/mapper/crypt1" "device=/dev/mapper/crypt2" "device=/dev/mapper/crypt3" "device=/dev/mapper/crypt4"];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = ["compress=zstd" "noatime" "device=/dev/mapper/crypt1" "device=/dev/mapper/crypt2" "device=/dev/mapper/crypt3" "device=/dev/mapper/crypt4"];
                    };
                    "@games" = {
                      mountpoint = "/games";
                      mountOptions = ["nodatacow" "noatime" "device=/dev/mapper/crypt1" "device=/dev/mapper/crypt2" "device=/dev/mapper/crypt3" "device=/dev/mapper/crypt4"];
                    };
                    "@repos" = {
                      mountpoint = "/repos";
                      mountOptions = ["compress=zstd" "noatime" "device=/dev/mapper/crypt1" "device=/dev/mapper/crypt2" "device=/dev/mapper/crypt3" "device=/dev/mapper/crypt4"];
                    };
                  };
                };
              };
            };
          };
        };
      };
      sda = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5002538d405c1877";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypt2";
                passwordFile = "/tmp/secret.txt";
                settings.allowDiscards = true;
              };
            };
          };
        };
      };
      sdb = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x50025388a0541652";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypt3";
                passwordFile = "/tmp/secret.txt";
                settings.allowDiscards = true;
              };
            };
          };
        };
      };
      sdc = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5002538f3118e037";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypt4";
                passwordFile = "/tmp/secret.txt";
                settings.allowDiscards = true;
              };
            };
          };
        };
      };
    };
  };
}
