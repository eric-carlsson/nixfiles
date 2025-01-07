# nixfiles

## Bootstrap a new NixOS machine

NixOS can be bootstrapped onto new machines from a live disk. This method requires minimal user input, and allows NixOS to be installed from existing configuration.

### Create a Nix live disk

1. Download the (minimal) Nix ISO, see [Download](https://nixos.org/download/).
2. Plugin the flash drive and unmount if needed.
3. Write the ISO to the flash drive.
    ```bash
    sudo dd if=<path to .iso> of=/dev/sd<drive letter> bs=4M status=progress oflag=sync
    ```
4. Boot into the flash drive and select **NixOS ... Installer**.

### Prepare the live disk environment

The minimal Nix ISO does not have network manager, so WIFI is configured manually.

1. Configure the WIFI credentials.xsel
    ```bash
    wpa_passphrase <WIFI SSID> > wifi.conf
    ```
2. Get the name of the WIFI interface.
    ```bash
    ls /sys/class/net | grep w
    ```
3. Connect to the WIFI endpoint.
    ```bash
    sudo wpa_supplicant -i <WIFI interface> -c wifi.conf -B
    ```

### Install NixOS

1. Clone the Nix configuration.
    ```bash
    git clone https://github.com/eric-carlsson/nixfiles.git
    cd nixfiles
    ```

2. Before proceeding, the NixOS configuration should contain hardware and disk configuration files. Hardware configuration can be generated (without filesystem config since this is managed by disko).
    ```bash
    sudo nixos-generate-config --no-filesystems --show-hardware-config
    ```
3. Format disk(s).
    ```bash
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --flake .#<hostname>
    ```
4. Install NixOS.
    ```bash
    sudo nixos-install --no-root-passwd --flake .#<hostname>
    ```
5.  Set the user login password.
    ```bash
    sudo nixos-enter --root /mnt -c 'passwd <username>'
    ```
6. Reboot.

<details>

<summary>WIP: Single cmd install with disko-install</summary>

### Prepare the live disk environment

The minimal Nix installer uses an in-memory file system for the Nix store. This tends cause OOM issues. Solve this by creating a swap partition.

1. Create a new partition.
    ```bash
    sudo fdisk /dev/sd<drive letter>
    ```
    Enter `n` and press enter until asked to enter the last sector. Enter a size that will fit on the flash drive, for example `+16000M`. Once created, assign a type by entering `t` and entering `82`. Enter `w` to write changes to disk.
2. Format the swap partition.
    ```bash
    sudo mkswap /dev/sd<drive letter><partition number>
    ```
3. Activate the swap partition.
    ```bash
    sudo swapon /dev/sd<drive letter><partition number>
    ```
4. Remount the Nix store to use the swap space.
    ```bash
    sudo mount -o remount,size=15G,noatime /nix/.rw-store
    ```

### Generate hardware configuration

Generate a hardware configuration file for the machine.

```bash
sudo nixos-generate-config --no-filesystems --show-hardware-config
```

Add the output to `host/<hostname>/hardware-configuration.nix` and push to remote.


### Install NixOS

```bash
sudo nix \
    --extra-experimental-features 'flakes nix-command' \
    run github:nix-community/disko#disko-install -- \
    --flake "github:eric-carlsson/nixfiles#<hostname>" \
    --write-efi-boot-entries \
    --disk main "<disk device>"
```

</details>
