{ config, pkgs, ... }:
{
  imports = 
    [
      ../packages/user.nix
      ../modules/zsh.nix
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
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  # home.pointerCursor.package = pkgs.phinger-cursors;
  # home.pointerCursor.name = "Phinger Cursors";

  # Git
  programs.git = {
    enable = true;
    userName = "quasigod-io";
    userEmail = "quasigod-io@protonmail.com";
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
    
    CARGO_HOME = "\$XDG_DATA_HOME/cargo";
    CUDA_CACHE_PATH = "\$XDG_CACHE_HOME/nv";
    GNUPGHOME = "\$XDG_DATA_HOME/gnupg";
    GOPATH = "\$XDG_DATA_HOME/go";
    LESSHISTFILE = "\$XDG_CACHE_HOME/less/history";
    MPLAYER_HOME = "\$XDG_CONFIG_HOME/mplayer";
    NUGET_PACKAGES = "\$XDG_CACHE_HOME/NuGetPackages";
    OCTAVE_HISTFILE = "\$XDG_CACHE_HOME/octave-hsts";
    OCTAVE_SITE_INITFILE = "\$XDG_CONFIG_HOME/octave/octaverc";
    STACK_ROOT = "\$XDG_DATA_HOME/stack";
    # WGETRC = "\$XDG_CONFIG_HOME/wgetrc";
    WINEPREFIX = "\$XDG_DATA_HOME/wineprefixes/default";
    ZDOTDIR = "\$HOME/.config/zsh";
    _Z_DATA = "\$XDG_DATA_HOME/z";
  };

}
