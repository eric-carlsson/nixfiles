{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };
t
  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        hades = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/hades/configuration.nix ];
        };
      };
    };
}
