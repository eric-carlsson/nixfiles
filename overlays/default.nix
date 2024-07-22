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
  sharedPkgPins = final: prev: {
    vscode =
      (import inputs.nixpkgs-unstable
        {
          system = final.system;
          config.allowUnfree = true;
        })
      .vscode;
    terraform = inputs.nixpkgs-2bf9669.legacyPackages.${final.system}.terraform;
    fluxcd = inputs.nixpkgs-3ec56f6.legacyPackages.${final.system}.fluxcd;
  };

  # Additional package shared by all hosts
  sharedPkgAdditions = final: prev: import ../pkgs final.pkgs;
}
