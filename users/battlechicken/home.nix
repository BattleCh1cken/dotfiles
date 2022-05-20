{ config, pkgs, home, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "battlechicken";
  home.homeDirectory = "/home/battlechicken";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #Terminal Utils  
    htop
    neofetch
    unzip
    wget
    tmux
    #Language Utils
    gcc
    nodejs

    #IDE
    neovim

    #Apps
    mailspring
    discord



  ];
  
  programs = {
    git = {
      enable = true;
      userName = "Battle Ch1cken";
      userEmail = "trazyn@larkov.de";
    };
    zsh = {
    enable = true;
    shellAliases = {
        c = "clear";
      };
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
    eval "$(${pkgs.starship}/bin/starship init zsh)"

    '';

    };
    exa = {
      enable = true;
      enableAliases = false;
    };
    kitty = {
      enable = true;
      theme = "Catppuccin";
      settings = {
          enable_audio_bell = false;
          shell = "zsh";
          font_family = "JetBrainsMono Nerd Font";
        };
    };
    starship = {
      enable = true;
      settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
      };



  firefox = {
      enable = true;
      package = pkgs.firefox;
  };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;


}
