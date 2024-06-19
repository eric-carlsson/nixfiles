{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/default.nix
  ];

  config = {
    home.username = "eric";
    home.homeDirectory = "/home/eric";
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      gnomeExtensions.dash-to-dock
      gnomeExtensions.pop-shell
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell".enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
        ];

        "org/gnome/shell/extensions/dash-to-dock" = {
          click-action = "focus-or-previews";
          multi-monitor = true;
          show-show-apps-button = false;
          disable-overview-on-startup = true;
          apply-custom-theme = true;
        };
      };
    };
  };
}
