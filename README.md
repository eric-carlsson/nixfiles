# nixfiles

## Installing NixOS

The NixOS configurations contained in the flake are 100% declarative, and can be installed without user input. This sections describes how to bootstrap a new NixOS machine.

## Create live disk Nix installer

1. Download Nix (minimal) ISO, see [Download](https://nixos.org/download/).
2. Plug in a flash drive and get where its mounted (for example with `df` or `lsblk`).
3. Unmount the flash drive.
    ```bash
    sudo umount /dev/sd<drive letter><partition number>
    ```
4. Write the ISO to the flash drive.
    ```bash
    sudo dd if=<path to .iso> of=/dev/sd<drive letter> bs=4M status=progress oflag=sync
    ```

Boot into the flash drive and select the option to start the Nix installer.

## Prepare the live disk

The minimal Nix installer does not have network manager, so WIFI is configured manually.

1. Configure the WIFI credentials.
    ```bash
    wpa_passphrase <WIFI SSID> > wifi.conf
    ```
2. Get the name of the WIFI interface.
    ```bash
    ls /sys/class/net
    ```
3. Connect to the WIFI endpoint.
    ```bash
    wpa_supplicant -i <WIFI interface> -c wifi.conf -B
    ```

## Create a swap partition

The minimal Nix installer uses an in-memory file system for the Nix store. This tends cause OOM issues. Solve this by creating a swap partition.

1. Create a new partition.
    ```bash
    sudo fdisk /dev/sd<drive letter>
    ```
    Hit *n* and press enter until asked to enter the last cylinder. Enter a size that will fit on the flash drive, for example `+16000M`. Once created, assign a type by hitting *t* and entering `82`. Hit *w* to write changes to disk.
2. Format the swap partition.
    ```bash
    sudo mkswap /dev/sd<drive letter>
    ```
3. Activate swap.
    ```bash
    sudo swapon /dev/sd<drive letter>
    ```
