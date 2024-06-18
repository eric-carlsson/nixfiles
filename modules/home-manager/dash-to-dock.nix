# This module installs dash-to-dock and does some basic configuration
# It should not be used on Ubuntu systems, as they come pre-configured
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.myModule;
in {
  options = {
    myModule.enable = lib.mkEnableOption "Enable dash-to-dock extension";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnomeExtensions.pop-shell
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell.enabled-extensions" = [
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
