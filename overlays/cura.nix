{ appimageTools
, fetchurl
,
}:
appimageTools.wrapType2 rec {
  pname = "ultimaker-cura-modern";
  version = "5.1.1";

  src = fetchurl {
    url = "https://github.com/Ultimaker/Cura/releases/download/${version}/Ultimaker-Cura-${version}-linux-modern.AppImage";
    hash = "sha256-Ce5ZiLhtEkbMojBmxYskYFSp3Jp3yTXhYcI5/0zmMd0=";
  };

  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  multiPkgs = null;
}
