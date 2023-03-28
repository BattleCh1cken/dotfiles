{ appimageTools
, fetchurl
,
}:
appimageTools.wrapType2 rec {
  pname = "super-slicer-appimage";
  version = "2.4.58.5";

  src = fetchurl {
    url = "https://github.com/supermerill/SuperSlicer/releases/download/2.4.58.5/SuperSlicer-ubuntu_18.04-2.4.58.5.AppImage";
    hash = "sha256-8+RQFQgz4sUPvHiNI4mMxsW0vCo/VKlhyyHy2wnhqOo=";
  };

  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  multiPkgs = null;
}
