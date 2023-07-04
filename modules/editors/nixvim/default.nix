{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.editors.nixvim;
in {
  options.modules.editors.nixvim = {
    enable = mkEnableOption "nixvim";
  };

  config = mkIf cfg.enable {
    home.config = {
      imports = [
        inputs.nixvim.homeManagerModules.nixvim
        ./_config/options.nix
        ./_config/mappings.nix
      ./_config/plugins
      ];

      programs.nixvim = {
        enable = true;
      };
    };
  };
}
