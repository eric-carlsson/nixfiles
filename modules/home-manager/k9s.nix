{
  config,
  lib,
  ...
}: {
  options.k9s.enable = lib.mkEnableOption "Enable k9s";

  config.programs.k9s = lib.mkIf config.k9s.enable {
    enable = true;

    settings = {
      k9s = {
        ui = {
          logoless = true;
          skin = "vscode-dark-plus";
        };
        skipLatestRevCheck = true;
      };
    };

    skins = {
      vscode-dark-plus = {
        foreground = "&foreground '#cccccc'";
        background = "&background '#1e1e1e'";

        k9s = {
          body = {
            fgColor = "*foreground";
            bgColor = "*background";
            logoColor = "orange";
          };
          prompt = {
            fgColor = "cadetblue";
            bgColor = "*background";
            suggestColor = "dodgerblue";
          };
          info = {
            fgColor = "orange";
            sectionColor = "*foreground";
          };
          dialog = {
            fgColor = "*foreground";
            bgColor = "*background";
            buttonFgColor = "black";
            buttonBgColor = "dodgerblue";
            buttonFocusFgColor = "white";
            buttonFocusBgColor = "fuchsia";
            labelFgColor = "fuchsia";
            fieldfgColor = "*foreground";
          };
          frame = {
            border = {
              fgColor = "*foreground";
              focusColor = "aqua";
            };
            menu = {
              fgColor = "white";
              keyColor = "dodgerblue";
              numKeyColor = "fuchsia";
            };
            crumbs = {
              fgColor = "black";
              bgColor = "steelblue";
              activeColor = "orange";
            };
            status = {
              newColor = "lightskyblue";
              modifyColor = "greenyellow";
              addColor = "white";
              errorColor = "orangered";
              pendingColor = "darkorange";
              highlightColor = "aqua";
              killColor = "mediumpurple";
              completedColor = "gray";
            };
            title = {
              fgColor = "aqua";
              highlightColor = "fuchsia";
              counterColor = "papayawhip";
              filterColor = "steelblue";
            };
          };
          views = {
            charts = {
              bgColor = "*background";
              defaultDialColors = [
                "linegreen"
                "orangered"
              ];
              defaultChartColors = [
                "linegreen"
                "orangered"
              ];
            };
            table = {
              fgColor = "blue";
              bgColor = "*background";
              cursorFgColor = "black";
              cursorBgColor = "aqua";
              markColor = "darkgoldenrod";
              header = {
                fgColor = "white";
                bgColor = "*background";
                sorterColor = "orange";
              };
            };
            xray = {
              fgColor = "blue";
              bgColor = "*background";
              cursorColor = "aqua";
              graphicColor = "darkgoldenrod";
              showIcons = false;
            };
            yaml = {
              keyColor = "steelblue";
              colonColor = "white";
              valueColor = "papayawhip";
            };
            logs = {
              fgColor = "white";
              bgColor = "*background";
              indicator = {
                fgColor = "*foreground";
                bgColor = "*background";
                toggleOnColor = "papayawhip";
                toggleOffColor = "steelblue";
              };
            };
          };
        };
      };
    };
  };
}
