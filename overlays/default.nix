{inputs, ...}: {
  # Shared overlays
  shared = {
    pins = final: prev: let
      nixpkgsConfig = {
        system = final.system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import inputs.nixpkgs-unstable nixpkgsConfig;
    in {
      vscode = pkgs-unstable.vscode;
      azure-cli = (import inputs.nixpkgs-e081643 nixpkgsConfig).azure-cli;
      kind = pkgs-unstable.kind;
      clusterctl = pkgs-unstable.clusterctl;
      go_1_23 = pkgs-unstable.go_1_23;
      velero = pkgs-unstable.velero;
      gnomeExtensions =
        prev.gnomeExtensions
        // {
          pop-shell = prev.gnomeExtensions.pop-shell.overrideAttrs (old: {
            src = prev.fetchFromGitHub {
              owner = "pop-os";
              repo = "shell";
              rev = "104269ede04d52caf98734b199d960a3b25b88df";
              hash = "sha256-rBu/Nn7e03Pvw0oZDL6t+Ms0nesCyOm4GiFY6aYM+HI=";
            };
          });
        };
      nexusmods-app-unfree = pkgs-unstable.nexusmods-app-unfree;
    };

    additions = final: prev: import ../pkgs final.pkgs;
  };
}
