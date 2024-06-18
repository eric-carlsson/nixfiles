{
  pkgs,
  pkgs-e49db01,
  ...
}: {
  imports = [
    ../../modules/home-manager/default.nix
  ];

  config = {
    home.username = "ecarls18";
    home.homeDirectory = "/home/ecarls18";
    home.stateVersion = "24.05";

    home.packages = with pkgs-e49db01; [
      gnomeExtensions.pop-shell
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Yaru-dark";
      };

      # Customizations to Ubuntu flavoured dash-to-dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        show-trash = false;
        dock-position = "BOTTOM";
        extend-height = false;
        dock-fixed = false;
        multi-monitor = true;
        show-show-apps-button = false;
      };
    };
  };
}
