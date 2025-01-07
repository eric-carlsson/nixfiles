{nixvim, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      nixvim.homeManagerModules.nixvim
    ];

    users.eric = {
      imports = [
        ../../modules/home-manager
      ];

      config = {
        home = {
          stateVersion = "24.11";
          username = "eric";
          homeDirectory = "/home/eric";
        };

        nixos.enable = true;
      };
    };
  };
}
