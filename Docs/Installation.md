# Installation/Deploy Steps

> [!CAUTION] Ensure you have backed up any necessary data before proceeding, as
> this process involves wiping drives.

## sol

### 1. Prepare Storage

Before running the partitioner, clear any existing filesystem signatures from
the target drives:

```bash
# Replace /dev/sdX with your actual drive identifiers
wipefs -a /dev/nvme0n1 /dev/sda /dev/sdb /dev/sdc
```

Create the temporary secret file required for encryption:

```bash
echo "yourpassword" > /tmp/secret.txt
```

### 2. Partitioning with Disko

Execute the Disko command to partition and format your drives.

> [!NOTE] If you encounter an error stating /tmp/secret.txt was not found,
> re-run the command 2–3 times.

```bash
nix --extra-experimental-features "nix-command flakes" \
 run github:nix-community/disko -- \
 --mode disko ./disko/sol.nix
```

> [!NOTE] Command to run disko can also be found on
> [github.](https://github.com/nix-community/disko)

### 3. Verification

Verify that the partitioning was successful. You should see **5 subvolumes**
listed under crypt1:

```bash
lsblk
```

**(Optional)** Verify that the Disk IDs are assigned correctly. Specifically,
ensure that sda is mapped to crypt2.

### 4. Btrfs Subvolume Setup

First, mount the top-level Btrfs partition:

```bash
mount -o subvolid=5 /dev/mapper/crypt1 /mnt
```

Navigate to the mount point and create the blank subvolumes:

```bash
# Create the temporary subvolume
btrfs subvolume create /mnt/@blank-tmp

# Create a read-only snapshot of the blank subvolume
btrfs subvolume snapshot -r /mnt/@blank-tmp /mnt/@blank

# Delete the temp subvolume
btrfs subvolume delete /mnt/@blank-tmp
```

### 5. System Installation

Run the NixOS installation command. This configuration uses the sol host defined
in your flake.

```bash
sudo nixos-install --no-root-password --flake .#sol
```

### 6. Finalize

Once the installation is complete, unmount your drives and reboot:

```bash
reboot
```
