{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.boot.plymouth;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.boot.plymouth = {
    enable = mkEnableOption "plymouth";
  };
  config =
    let
      nixos-boot-src = pkgs.fetchFromGitHub {
        owner = "Melkor333";
        repo = "nixos-boot";
        rev = "dd53e70176c9986a9094b3851396e330f13a7def";
        sha256 = "sha256-kcYd39n58MVI2mFn/PSh5O/Wzr15kEYWgszMRtSQ+1w";
      };

      nixos-boot = pkgs.callPackage nixos-boot-src {
        bgColor = "22, 22, 22"; # Weird 0-1 range RGB. In this example roughly mint
      };
    in
    mkIf cfg.enable
      {
        boot.plymouth = {
          enable = true;
          themePackages = [ nixos-boot ];
          theme = "load_unload";
        };

      };
}
