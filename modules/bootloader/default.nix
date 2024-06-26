{ config
, pkgs
, lib
, ...
}: {
  boot = {
    # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # I should probably pin the kernel but I'm too lazy
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        enableCryptodisk = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        #gfxmodeEfi = "1920x1080";
        splashImage = "${./grub.png}";
      };
    };
  };
}
