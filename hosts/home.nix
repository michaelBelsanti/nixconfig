{ config, pkgs, ... }:
{
  imports = 
    [
      ../packages/user.nix
      ../modules/alacritty
      ../modules/helix
      ../modules/rofi
      ../modules/scripts
    ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "quasi";
  home.homeDirectory = "/home/quasi";

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
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.file = { };
  
  # Main system theming
  xresources.path = "${config.home.homeDirectory}/X11/xresources";
  gtk = {
    enable = true;
    font = {
      name = "Montserrat Semibold";
      package = pkgs.montserrat;
      size = 12;
    };
    # iconTheme = "Adwaita";
    theme.name = "Catppuccin-Purple-Dark";
    theme.package = pkgs.catppuccin-gtk;
  };
  xdg.configFile."gtk.css" = {
    target = "gtk-3.0/gtk.css";
    text = ''
      decoration, window, window.background, window.titlebar, * {
        border-radius: 0px;
      }
    '';
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    gtk.enable = true;
    x11.enable = true;
  };

  # Git
  services.gpg-agent.enable = true;
  programs.git = {
    enable = true;
    userName = "quasigod-io";
    userEmail = "quasigod-io@protonmail.com";
    delta.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  
  home.sessionVariables = {
    EDIR_EDITOR = "hx";
    BROWSER = "librewolf";
    FZF_DEFAULT_COMMAND = "'find .'";
    
    XDG_CONFIG_HOME = "\$HOME/.config";
    XDG_CACHE_HOME = "\$HOME/.cache";
    XDG_DATA_HOME = "\$HOME/.local/share";
    XDG_STATE_HOME = "\$HOME/.local/state";
    
    __GL_SHADER_DISK_CACHE = 1;
    __GL_SHADER_DISK_CACHE_PATH = "\$HOME/Games/cache";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = 1;
    
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    GOPATH = "${config.xdg.dataHome}/go";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    MPLAYER_HOME = "${config.xdg.configHome}/mplayer";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
    OCTAVE_HISTFILE = "${config.xdg.cacheHome}/octave-hsts";
    OCTAVE_SITE_INITFILE = "${config.xdg.configHome}/octave/octaverc";
    STACK_ROOT = "${config.xdg.dataHome}/stack";
    # WGETRC = "${config.xdg.configHome}/wgetrc";
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes/default";
    ZDOTDIR = "${config.xdg.configHome}/zsh";
    _Z_DATA = "${config.xdg.dataHome}/z";
  };

}
