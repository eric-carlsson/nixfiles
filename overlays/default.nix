{inputs, ...}: {
  # Package pins to support GNOME 42
  gnome42PkgPins = final: prev: {
    gnomeExtensions =
      prev.gnomeExtensions
      // {
        pop-shell = inputs.nixpkgs-e49db01.legacyPackages.${final.system}.gnomeExtensions.pop-shell;
      };
  };

  # Package pins shared by all hosts
  sharedPkgPins = final: prev: let
    nixpkgsConfig = {
      system = final.system;
      config.allowUnfree = true;
    };
  in {
    vscode = (import inputs.nixpkgs-unstable nixpkgsConfig).vscode;
    terraform = (import inputs.nixpkgs-2bf9669 nixpkgsConfig).terraform;
    fluxcd = inputs.nixpkgs-3ec56f6.legacyPackages.${final.system}.fluxcd;
  };

  # Additional package shared by all hosts
  sharedPkgAdditions = final: prev: import ../pkgs final.pkgs;
}
