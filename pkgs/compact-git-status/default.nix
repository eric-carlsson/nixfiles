{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "compact-git-status";
  version = "3aafad1310513395c8b93c0a38058c5116e9c296";

  src = fetchFromGitHub {
    owner = "eric-carlsson";
    repo = "compact-git-status";
    rev = version;
    hash = "sha256-aHnGG8ytXbkzkLhfgJ0E7fws0lbyuxGJT5Cxo3GnOyw=";
  };

  vendorHash = null;

  meta = {
    description = "Utility for printing compact git status";
    mainProgram = "compact-git-status";
  };
}
