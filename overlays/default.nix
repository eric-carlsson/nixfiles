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
      terraform = pkgs-unstable.terraform;
      kind = pkgs-unstable.kind;
      clusterctl = pkgs-unstable.clusterctl;
      go_1_23 = pkgs-unstable.go_1_23;
      crossplane-cli = pkgs-unstable.crossplane-cli;
    };

    additions = final: prev: import ../pkgs final.pkgs;
  };

  # Overlays to support gnome42
  gnome42 = {
    pins = final: prev: {
      gnomeExtensions =
        prev.gnomeExtensions
        // {
          pop-shell = inputs.nixpkgs-e49db01.legacyPackages.${final.system}.gnomeExtensions.pop-shell;
        };
    };
  };
}
