{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "compact-git-status";
  version = "main";

  src = fetchFromGitHub {
    owner = "eric-carlsson";
    repo = "compact-git-status";
    rev = version;
    hash = "sha256-aHnGG8ytXbkzkLhfgJ0E7fws0lbyuxGJT5Cxo3GnOyw=";
  };

  vendorHash = null;
}
