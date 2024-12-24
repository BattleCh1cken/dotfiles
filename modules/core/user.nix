{ pkgs, ... }: {
  users.users = {
    battlechicken = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" "networkmanager" "libvirtd" "input" ];
    };

  };
}
