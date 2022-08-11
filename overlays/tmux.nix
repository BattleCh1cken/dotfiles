{ lib, stdenv, fetchFromGithub, ... }:
{
  battery = mkTmuxPlugin {
    pluginName = "battery";
    version = "unstable-2019-07-04";
    src = fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-battery";
      rev = "f8b8e8451990365e0c98c38c184962e4f83b793b";
      sha256 = "1bhdzsx3kdjqjmm1q4j8937lrpkzf71irr3fqhdbddsghwrrmwim";
    };
  };
}
