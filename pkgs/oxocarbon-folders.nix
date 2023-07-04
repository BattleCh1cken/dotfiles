{
  lib,
  stdenv,
  fetchFromGitHub,
  papirus-icon-theme,
}:
stdenv.mkDerivation rec {
  pname = "oxocarbon-folders";
  version = "5da6589c2e0cae4fb369ec9f273fc132365edb83";

  src = fetchFromGitHub {
    owner = "BattleCh1cken";
    repo = "oxocarbon-papirus-folders";
    rev = "${version}";
    sha256 = "sha256-o0g7o+tzBRpTLbIGczaAeYfU/rJ2fZ6cQcL6FKeoxcw=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Papirus
    cp -r ${papirus-icon-theme}/share/icons/Papirus $out/share/icons
    chmod -R u+rw $out
    cp -r src/* $out/share/icons/Papirus
    bash ./papirus-folders -C oxocarbon-pink --theme $out/share/icons/Papirus -o
  '';
}
