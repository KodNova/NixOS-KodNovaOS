{inputs, ...}: {
  flake.nixosModules.impermanence = {lib, ...}: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    boot = {
      # Wipe root on boot
      initrd.postResumeCommands = lib.mkAfter ''
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
