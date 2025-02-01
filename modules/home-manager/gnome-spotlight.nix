{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.gnome-spotlight;
in {
  options.gnome-spotlight = {
    enable = lib.mkEnableOption "Enable gnome-spotlight";

    preserve = lib.mkOption {
      type = lib.types.ints.unsigned;
      description = "number of old wallpapers to preserved";
      default = 3;
    };

    schedule = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "schedule for systemd timer";
      default = "weekly";
    };
  };

  config = lib.mkIf config.gnome-spotlight.enable {
    home.packages = [pkgs.gnome-spotlight];

    systemd.user.services."gnome-spotlight" = {
      Unit = {
        Description = "Randomize desktop wallpaper with gnome-spotlight";
      };
      Service = {
        Environment = ["PATH=${lib.makeBinPath [pkgs.dconf]}"];
        ExecStart = "${pkgs.gnome-spotlight}/bin/gnome-spotlight -preserve ${toString cfg.preserve}";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };

    systemd.user.timers."gnome-spotlight" = {
      Unit = {
        Description = "Timer for gnome-spotlight service";
      };

      Timer = {
        OnCalendar = cfg.schedule;
        AccuracySec = "6h";
        Persistent = true;
        Unit = "gnome-spotlight.service";
      };

      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
