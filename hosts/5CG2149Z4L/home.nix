{
  imports = [
    ../../modules/home-manager/default.nix
  ];

  config = {
    home.username = "ecarls18";
    home.homeDirectory = "/home/ecarls18";
    home.stateVersion = "24.05";
  };
}
