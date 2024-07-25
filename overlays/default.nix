{inputs, ...}: {
  # Shared overlays
  shared = {
    pins = final: prev: let
      nixpkgsConfig = {
        system = final.system;
        config.allowUnfree = true;
      };
    in {
      vscode = (import inputs.nixpkgs-unstable nixpkgsConfig).vscode;
      terraform = (import inputs.nixpkgs-2bf9669 nixpkgsConfig).terraform;
      fluxcd = inputs.nixpkgs-3ec56f6.legacyPackages.${final.system}.fluxcd;
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
