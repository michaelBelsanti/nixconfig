{ config, pkgs, user, ... }:
{
  imports =
    [
      ../modules/alacritty
      ../modules/scripts
      ../modules/cli
    ];

  # Home Manager Setup
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Main system theming
  xsession = {
    enable = true;
    initExtra = ''
      xrdb merge ~/.config/X11/xresources
    '';
  };
  gtk = {
    enable = true;
    font = {
      name = "Montserrat Semibold";
      package = pkgs.montserrat;
      size = 12;
    };
    # iconTheme = "Adwaita";
    theme.name = "Catppuccin-Pink-Dark";
    theme.package = pkgs.catppuccin-gtk;
    gtk3 = {
      bookmarks = [
        "file:///home/quasi/Downloads Downloads"
        "file:///home/quasi/Documents Documents"
        "file:///home/quasi/Pictures Pictures"
        "file:///home/quasi/Videos Videos"
        "file:///home/quasi/Games Games"
      ];
      extraCss = ''
        decoration, window, window.background, window.titlebar, * {
          border-radius: 0px;
        }
      '';
    };
  };
  qt = {
    enable = true;
    # platformTheme = "qt5ct";
    style = {
      # package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      # name = "kvantum";
    };
  };
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    x11.enable = true;
    gtk.enable = true;
  };
  xresources = {
    path = "${config.xdg.configHome}/X11/xresources";
    properties = {
      "*background" = "#1E1D2F";
      "*foreground" = "#D9E0EE";
      "*lightbg" = "#2F2F4C";
      # Grey
      "*color0" = "#6E6C7E";
      "*color8" = "#988BA2";
      # Red
      "*color1" = "#F28FAD";
      "*color9" = "#F28FAD";
      # Green
      "*color2" = "#ABE9B3";
      "*color10" = "#ABE9B3";
      # Yellow
      "*color3" = "#FAE3B0";
      "*color11" = "#FAE3B0";
      # Blue
      "*color4" = "#96CDFB";
      "*color12" = "#96CDFB";
      # Maguve
      "*color5" = "#DDB6F2";
      "*color13" = "#DDB6F2";
      # Pink
      "*color6" = "#F5C2E7";
      "*color14" = "#F5C2E7";
      # Whites
      "*color7" = "#C3BAC6";
      "*color15" = "#D9E0EE";
      # Other (really just for nsxiv)
      "window.background" = "#1E1D2F";
      "window.foreground" = "#DADAE8";
      "bar.font" = "Montserrat 11";
    };
  };

  # Git
  services.gpg-agent.enable = true;
  programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";
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
    FZF_DEFAULT_COMMAND = "find .";

    MANGOHUD = "0";

    XDG_CONFIG_HOME = "\$HOME/.config";
    XDG_CACHE_HOME = "\$HOME/.cache";
    XDG_DATA_HOME = "\$HOME/.local/share";
    XDG_STATE_HOME = "\$HOME/.local/state";

    __GL_SHADER_DISK_CACHE = 1;
    __GL_SHADER_DISK_CACHE_PATH = "\$HOME/Games/cache";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = 1;

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    GOPATH = "${config.xdg.dataHome}/go";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    MPLAYER_HOME = "${config.xdg.configHome}/mplayer";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
    OCTAVE_HISTFILE = "${config.xdg.cacheHome}/octave-hsts";
    OCTAVE_SITE_INITFILE = "${config.xdg.configHome}/octave/octaverc";
    STACK_ROOT = "${config.xdg.dataHome}/stack";
    # WGETRC = "${config.xdg.configHome}/wgetrc";
    _Z_DATA = "${config.xdg.dataHome}/z";
  };
}
