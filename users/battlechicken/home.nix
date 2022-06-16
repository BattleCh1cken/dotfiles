{ config, pkgs, home, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "battlechicken";
  home.homeDirectory = "/home/battlechicken";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #Terminal Utils  
    xclip
    htop
    neofetch
    unzip
    wget
    tmux
    ripgrep
    direnv
    #Language Utils
    gcc
    sumneko-lua-language-server
    stylua
    rnix-lsp
    rust-analyzer
    shellcheck

    #IDE
    neovim

    #Apps
    mailspring
    discord
    vscode
    obsidian
    vlc



  ];
  programs = {
    git = {
      enable = true;
      userName = "Battle Ch1cken";
      userEmail = "trazyn@larkov.de";
    };
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    zsh = {
      enable = true;
      shellAliases = {
        c = "clear";
        e = "exit";
        n = "nvim";
        cd = "z";
        sl = "exa --icons --sort type";
        ls = "exa --icons --sort type";
        ll = "exa --icons --long --sort type";
        l = "exa --icons --long --sort type";
        tree = "exa --icons --git -a --tree -s type -I '.git|node_modules|bower_components'";
        gp = "gitpush";


      };
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      initExtra = ''
          bindkey '^ ' autosuggest-accept
          export EDITOR=nvim
          eval "$(${pkgs.starship}/bin/starship init zsh)"
          gitpush() {  
                git add .
                git commit -m "$*"
                git pull
                git push
          }
        eval "$(direnv hook zsh)"    
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
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
        hide_windows_decorations = "yes";
        wayland_titlebar_color = "system";
      };
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };

        package.disabled = true;
      };
    };



    firefox = {
      enable = true;
      package = pkgs.firefox;
    };
  };
  home.file = {
    #    ".config/nvim".source = ./config/nvim;
    #   ".config/nvim".recursive = true;
    ".config/bspwm".source = ./config/bspwm/bspwmrc;
    ".config/bspwm".recursive = true;
    ".config/sxhkd".source = ./config/sxhkd/sxhkdrc;
    ".config/sxhkd".recursive = true;
    # ".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;
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
