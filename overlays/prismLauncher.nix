{ appimageTools
, fetchurl
,
}:
appimageTools.wrapType2 rec {
  pname = "PrismLauncher";
  version = "5.0";

  src = fetchurl {
    url = "https://github.com/PrismLauncher/PrismLauncher/releases/download/${version}/PrismLauncher-Linux-${version}-x86_64.AppImage";
    hash = "sha256-adxcXFCzh2ntMb/JVCUBY6Zw7r4JnKzVA6xjQDjZd88=";
  };

  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  multiPkgs = null;
}
