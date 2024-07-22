{inputs, ...}: {
  pkgPins = final: prev: {
    vscode =
      (import inputs.nixpkgs-unstable
        {
          system = final.system;
          config.allowUnfree = true;
        })
      .vscode;
    gnomeExtensions =
      prev.gnomeExtensions
      // {
        pop-shell = inputs.nixpkgs-e49db01.legacyPackages.${final.system}.gnomeExtensions.pop-shell;
      };
    terraform = inputs.nixpkgs-2bf9669.legacyPackages.${final.system}.terraform;
    fluxcd = inputs.nixpkgs-3ec56f6.legacyPackages.${final.system}.fluxcd;
  };

  pkgAdditions = final: prev: import ../pkgs final.pkgs;
}
