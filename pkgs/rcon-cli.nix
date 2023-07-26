{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "rcon-cli";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "itzg";
    repo = "rcon-cli";
    rev = "${version}";
    hash = "sha256-WezxkwNKJQe6whTksvpZNn85WNtD1k6VHHyUC3czQLw=";
  };

  vendorHash = "sha256-+J1xc2tOERMheVRY/GdRRuj7iRN7IhWQQXtkJIlFWzI=";

  doCheck = false;

  meta = with lib; {
    maintainers = with maintainers; [BattleCh1cken];
  };
}
