{ config
, options
, lib
, pkgs
, ...
}:
{
  config = {
    environment.systemPackages = with pkgs; [
      git
    ];

    #home.configFile = {
    #"git/config".source = "${configDir}/git/config";
    #"git/ignore".source = "${configDir}/git/ignore";
    #};
  };
}
