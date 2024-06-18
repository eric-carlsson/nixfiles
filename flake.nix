{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = {
      hades = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/hades/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.eric = import ./hosts/hades/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      "ecarls18@5CG2149Z4L" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./hosts/5CG2149Z4L/home.nix
        ];
      };
    };
  };
}
