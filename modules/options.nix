{
  config,
  options,
  lib,
  home-manager,
  ...
}:
with lib;
with lib.my; {
  options = with types; {
    user = mkOpt attrs {};

    dotfiles = {
      dir =
        mkOpt path
        (removePrefix "/mnt"
          (findFirst pathExists (toString ../.) [
            "/mnt/etc/dotfiles"
            "/etc/dotfiles"
          ]));
      configDir = mkOpt path "${config.dotfiles.dir}/config";
      modulesDir = mkOpt path "${config.dotfiles.dir}/modules";
    };

    home = {
      config = mkOpt attrs {};
      file = mkOpt' attrs {} "Files to place directly in $HOME";
      configFile = mkOpt' attrs {} "Files to place in $XDG_CONFIG_HOME";
      dataFile = mkOpt' attrs {} "Files to place in $XDG_DATA_HOME";
    };

    env = mkOption {
      type = attrsOf (oneOf [str path (listOf (either str path))]);
      apply =
        mapAttrs
        (n: v:
          if isList v
          then concatMapStringsSep ":" (x: toString x) v
          else (toString v));
      default = {};
      description = "TODO";
    };
  };

  config = {
    user = let
      user = builtins.getEnv "USER";
      name =
        if elem user ["" "root"]
        then "battlechicken"
        else user;
    in {
      inherit name;
      extraGroups = ["wheel" "dialout" "docker" "networkmanager" "libvirtd"];
      isNormalUser = true;
      home = "/home/${name}";
      group = "users";
      uid = 1000;
    };

    # Install user packages to /etc/profiles instead. Necessary for
    # nixos-rebuild build-vm to work.
    home-manager = {
      useUserPackages = true;
      users.${config.user.name} = mkAliasDefinitions options.home.config;
    };

    home.config = {
      home = {
        file = mkAliasDefinitions options.home.file;
        # Necessary for home-manager to work with flakes, otherwise it will
        # look for a nixpkgs channel.
        stateVersion = config.system.stateVersion;
      };
      xdg = {
        configFile = mkAliasDefinitions options.home.configFile;
        dataFile = mkAliasDefinitions options.home.dataFile;
      };
    };

    users.users.${config.user.name} = mkAliasDefinitions options.user;

    nix.settings = let
      users = ["root" config.user.name];
    in {
      trusted-users = users;
      allowed-users = users;
    };

    environment.extraInit =
      concatStringsSep "\n"
      (mapAttrsToList (n: v: "export ${n}=\"${v}\"") config.env);
  };
}
