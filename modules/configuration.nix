# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #boot.loader.grub.useOSProber = true;
  #time.hardwareClockInLocalTime = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = " http://user:password@proxy:port/ ";
  # networking.proxy.noProxy = " 127.0 .0 .1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.

  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.extraLocaleSettings = {
  #   LANG = "de_DE.UTF-8";
  #   LANGUAGE = "de_DE";
  #   LC_CTYPE = "de_DE.UTF-8";
  #   LC_NUMERIC = "de_DE.UTF-8";
  #   LC_TIME = "de_DE.UTF-8";
  #   LC_COLLATE = "de_DE.UTF-8";
  #   LC_MONETARY = "de_DE.UTF-8";
  #   LC_MESSAGES = "de_DE.UTF-8";
  #   LC_PAPER = "de_DE.UTF-8";
  #   LC_NAME = "de_DE.UTF-8";
  #   LC_ADDRESS = "de_DE.UTF-8";
  #   LC_TELEPHONE = "de_DE.UTF-8";
  #   LC_MEASUREMENT = "de_DE.UTF-8";
  #   LC_IDENTIFICATION = "de_DE.UTF-8";
  # LC_ALL = "de_DE.UTF-8";
  # };


  # Configure keymap in X11
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  #It does what it says, just read it.
  nixpkgs.config.allowUnfree = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.battlechicken = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "battlechicken";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };


  # List packages installed in system profile. To search, run:
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  environment.systemPackages = with pkgs; [
    #cli utils
    vim
    htop
    neofetch
    zip
    unzip
    xorg.xkill
    zsh
    protonup
    #apps
    pavucontrol
    cmus
    #random dependencies
    gcc
    cmake
    libnotify
    glibcLocales

    papirus-icon-theme
  ];

  hardware.opengl.driSupport = true;

  services = {

    xserver = {
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "0";
          middleEmulation = false;
        };

        touchpad = {
          disableWhileTyping = true;
          accelProfile = "flat";
          accelSpeed = "0.6";
          naturalScrolling = true;
          tapping = true;
        };
      };
      layout = "us";
      xkbVariant = "";
    };
  };
  security = {

    pam.services.login.enableGnomeKeyring = true;

  };


  # List services that you want to enable:
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}


