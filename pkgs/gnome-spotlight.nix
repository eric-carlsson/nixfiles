{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "gnome-spotlight";
  version = "main";

  src = fetchFromGitHub {
    owner = "eric-carlsson";
    repo = "gnome-spotlight";
    rev = version;
    hash = "sha256-qK3nul/FsqzACK7Tr9BKWq1wufvDZTWdY9GCwsllLR0=";
  };

  vendorHash = null;
}
