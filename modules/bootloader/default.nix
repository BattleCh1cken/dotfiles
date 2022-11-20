{ config
, pkgs
, lib
, ...
}: {
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    # Use the latest kernel
    #I should probably pin the kernel but I'm too lazy
    #kernelPackages = mkDefault pkgs.linuxKernel.packages.linux_5_18;


    loader = {
      #systemd-boot.configurationLimit = 10;
      #systemd-boot.enable = true;
      efi = {

        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
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
