{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Azure CLI 2.62
    nixpkgs-e081643.url = "github:nixos/nixpkgs/e0816431a23a06692d86c0b545b4522b9a9bc939";

    disko.url = "github:nix-community/disko/master";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    home-manager,
    nixvim,
    ...
  } @ inputs: let
    inherit (self) outputs;

    system = "x86_64-linux";

    sharedNixpkgsConfig = {
      nixpkgs = {
        config.allowUnfree = true;
        overlays = builtins.attrValues outputs.overlays.shared;
      };
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    overlays = import ./overlays {inherit inputs;};

    packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};

    nixosConfigurations = {
      hades = nixpkgs.lib.nixosSystem {
        modules = [
          sharedNixpkgsConfig
          home-manager.nixosModules.home-manager
          ./hosts/hades
        ];
        specialArgs = {
          inherit nixvim;
        };
      };
      zeus = nixpkgs.lib.nixosSystem {
        modules = [
          sharedNixpkgsConfig
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          ./hosts/zeus
        ];
        specialArgs = {
          inherit nixvim;
        };
      };
    };

    homeConfigurations = {
      "ecarls18@5CG2149Z4L" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          sharedNixpkgsConfig
          nixvim.homeManagerModules.nixvim
          ./hosts/5CG2149Z4L/home.nix
        ];
      };
    };
  };
}
