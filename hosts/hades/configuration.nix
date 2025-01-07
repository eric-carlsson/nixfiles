{pkgs, ...}: {
  imports = [
    ../../modules/nixos
  ];

  config = {
    system.stateVersion = "24.05";

    boot.initrd.luks.devices."luks-0c2d4121-e87f-4744-86a3-0e85a001e43d".device = "/dev/disk/by-uuid/0c2d4121-e87f-4744-86a3-0e85a001e43d";

    networking.hostName = "hades";

    # User account
    users.users.eric = {
      isNormalUser = true;
      description = "Eric Carlsson";
      extraGroups = ["networkmanager" "wheel"];
    };

    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      bitwarden
    ];
  };
}
