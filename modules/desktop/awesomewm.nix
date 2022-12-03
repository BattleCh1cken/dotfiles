{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.awesomewm;
  configDir = config.dotfiles.configDir;
  bling = pkgs.luaPackages.luaLib.toLuaModule (pkgs.stdenv.mkDerivation rec {
    name = "bling";
    src = pkgs.fetchFromGitHub {
      owner = "BlingCorp";
      repo = "bling";
      rev = "e6de047ced41051236a390b081105f598cb0ad8b";
      hash = "sha256-ehFUAhLUEOfqB/2Dung7fBPTCvuXepZB6oVLUv+rkTk=";
    };

    buildInputs = [ pkgs.lua ];

    installPhase = ''
      mkdir -p $out/lib/lua/${pkgs.lua.luaversion}/
      cp -r . $out/lib/lua/${pkgs.lua.luaversion}/bling/
      printf "package.path = '$out/lib/lua/${pkgs.lua.luaversion}/?/init.lua;' ..  package.path\n \
      local bling = {require((...) .. '.init')}\n \
      return bling\n"\
      > $out/lib/lua/${pkgs.lua.luaversion}/bling.lua
    '';

    meta = with lib; {
      description = "Utilities for the awesome window manager";
      homepage = "https://github.com/BlingCorp/bling";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  });
in
{
  options.modules.desktop.awesomewm = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    nixpkgs.overlays = [
      inputs.nixpkgs-f2k.overlays.window-managers
    ];

    services = {
      picom.enable = true;
      xserver = {
        enable = true;
        displayManager = {
          lightdm.enable = true;
          #lightdm.greeters.mini.enable = true;
        };
        windowManager.awesome = {
          package = pkgs.awesome-git;
          enable = true;
          luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
            luadbi-mysql # Database abstraction layer
          ];
        };

      };
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
      light
    ];
    home.configFile = {
      #"awesome" = { source = "${configDir}/awesome"; recursive = true; };
    };
  };
}
