{ appimageTools
, fetchurl
,
}:
appimageTools.wrapType2 rec {
  pname = "ultimaker-cura-modern";
  version = "5.2.1";

  src = fetchurl {
    url = "https://github.com/Ultimaker/Cura/releases/download/${version}/Ultimaker-Cura-${version}-linux-modern.AppImage";
    hash = "sha256-0RDKjmLv1efGR6/VN0Enx7jiuA9DCKboNoaVdHZGXTg=";
  };

  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  multiPkgs = null;
}
