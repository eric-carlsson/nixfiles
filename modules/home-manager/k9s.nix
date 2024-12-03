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
        k9s = {
          body = {
            fgColor = "#cccccc";
            bgColor = "#1e1e1e";
            logoColor = "#ffd700";
          };
          prompt = {
            fgColor = "yellow";
            bgColor = "#1e1e1e";
            suggestColor = "#569cd6";
          };
          info = {
            fgColor = "#ffd700";
            sectionColor = "#cccccc";
          };
          dialog = {
            fgColor = "#cccccc";
            bgColor = "#1e1e1e";
            buttonFgColor = "black";
            buttonBgColor = "#569cd6";
            buttonFocusFgColor = "white";
            buttonFocusBgColor = "#c586c0";
            labelFgColor = "#c586c0";
            fieldfgColor = "#cccccc";
          };
          frame = {
            border = {
              fgColor = "#cccccc";
              focusColor = "#9cdcfe";
            };
            menu = {
              fgColor = "#cccccc";
              keyColor = "#569cd6";
              numKeyColor = "#c586c0";
            };
            crumbs = {
              fgColor = "#1e1e1e";
              bgColor = "#569cd6";
              activeColor = "#ffd700";
            };
            status = {
              newColor = "lightskyblue";
              modifyColor = "greenyellow";
              addColor = "white";
              errorColor = "orangered";
              pendingColor = "darkorange";
              highlightColor = "orange";
              killColor = "mediumpurple";
              completedColor = "gray";
            };
            title = {
              fgColor = "#9cdcfe";
              highlightColor = "#c586c0";
              counterColor = "#dcdcaa";
              filterColor = "#c8c8c8";
            };
          };
          views = {
            charts = {
              bgColor = "#1e1e1e";
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
              fgColor = "#9cdcfe";
              bgColor = "#1e1e1e";
              cursorFgColor = "#1e1e1e";
              cursorBgColor = "#9cdcfe";
              markColor = "darkgoldenrod";
              header = {
                fgColor = "#cccccc";
                bgColor = "#1e1e1e";
                sorterColor = "#ffd700";
              };
            };
            xray = {
              fgColor = "#9cdcfe";
              bgColor = "#1e1e1e";
              cursorColor = "#9cdcfe";
              graphicColor = "darkgoldenrod";
              showIcons = false;
            };
            yaml = {
              keyColor = "#569cd6";
              colonColor = "#569cd6";
              valueColor = "#cccccc";
            };
            logs = {
              fgColor = "#cccccc";
              bgColor = "#1e1e1e";
              indicator = {
                fgColor = "#cccccc";
                bgColor = "#1e1e1e";
                toggleOnColor = "#dcdcaa";
                toggleOffColor = "#c8c8c8";
              };
            };
          };
        };
      };
    };
  };
}
