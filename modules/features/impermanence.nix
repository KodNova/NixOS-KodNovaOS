{inputs, ...}: {
  flake.nixosModules.impermanence = _: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a blank snapshot";
      wantedBy = ["initrd.target"];
      after = ["dev-mapper-crypt1.device"];
      requires = ["dev-mapper-crypt1.device"];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /btrfs_tmp
        mount -o subvol=/ /dev/mapper/crypt1 /btrfs_tmp

        if [[ -e /btrfs_tmp/@blank ]]; then
            # Delete any nested subvolumes inside @ first
            btrfs subvolume list -o /btrfs_tmp/@ | cut -f9- -d' ' | \
              while read subvol; do
                btrfs subvolume delete "/btrfs_tmp/$subvol"
              done

            # Delete @ itself
            btrfs subvolume delete /btrfs_tmp/@

            # Restore from blank
            btrfs subvolume snapshot /btrfs_tmp/@blank /btrfs_tmp/@
        fi

        umount /btrfs_tmp
      '';
    };
  };
}
