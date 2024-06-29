{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Pop-shell for GNOME 42
    nixpkgs-e49db01.url = "github:nixos/nixpkgs/e49db01d2069ef3ed78d557c6ad6bd426b86d806";

    # Terraform 1.7.5
    nixpkgs-2bf9669.url = "github:nixos/nixpkgs/2bf96698281d49ec9002e180b577b19353c3d806";

    # FluxCD 2.1.2
    nixpkgs-3ec56f6.url = "github:nixos/nixpkgs/3ec56f6636c2753571cac4616a16743e0810b93e";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-e49db01,
    nixpkgs-2bf9669,
    nixpkgs-3ec56f6,
    home-manager,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";

    nixpkgsConfig = {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs = import nixpkgs nixpkgsConfig;
    pkgs-unstable = import nixpkgs-unstable nixpkgsConfig;
    pkgs-e49db01 = import nixpkgs-e49db01 nixpkgsConfig;
    pkgs-2bf9669 = import nixpkgs-2bf9669 nixpkgsConfig;
    pkgs-3ec56f6 = import nixpkgs-3ec56f6 nixpkgsConfig;
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      hades = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/hades/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit pkgs-unstable;};
              sharedModules = [
                nixvim.homeManagerModules.nixvim
              ];
              users.eric = import ./hosts/hades/home.nix;
            };
          }
        ];
      };
    };

    homeConfigurations = {
      "ecarls18@5CG2149Z4L" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit pkgs-unstable pkgs-e49db01 pkgs-2bf9669 pkgs-3ec56f6;};
        modules = [
          nixvim.homeManagerModules.nixvim
          ./hosts/5CG2149Z4L/home.nix
        ];
      };
    };
  };
}
