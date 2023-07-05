{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  name = "mrpack-install";
  version = "0.16.7";

  src = fetchFromGitHub {
    owner = "nothub";
    repo = "mrpack-install";
    rev = "v${version}";
    hash = "sha256-aGIfCd5k8zCKwi/U2Ry4d+9ff4zmFTfl8W0n0m0IJwQ=";
  };

  vendorHash = "sha256-tQbc8fIkSgC9G1m4tMzk7MrOGOwXhNH+GTVXDZR//54=";

  doCheck = false;

  meta = with lib; {
    maintainers = with maintainers; [BattleCh1cken];
  };
}
