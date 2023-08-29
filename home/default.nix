# Main NixOS home-manager configuration, imported by all NixOS configs
{
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./modules/shell
    ./modules/cli
    ./modules/theming
  ];

  # Home Manager Setup
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";
    sessionPath = ["$HOME/.local/bin"];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Git
  services = {
    pueue.enable = true;
    gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.dataHome}/bash/history";
    };
    git = {
      enable = true;
      userName = "michaelBelsanti";
      userEmail = "quasigod-io@protonmail.com";
      delta.enable = true;
      extraConfig = {
        init = {defaultBranch = "main";};
        pull = {rebase = true;};
      };
    };
    tealdeer.settings = {
      enable = true;
      updates.auto_update = true;
    };
  };

  # Cleaning up ~
  xdg.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    EDIR_EDITOR = "hx";
    BROWSER = "librewolf";
    FZF_DEFAULT_COMMAND = "find .";

    MANGOHUD = "0";
    __GL_SHADER_DISK_CACHE_PATH = "${config.home.homeDirectory}/Games/cache";

    ANDROID_HOME = "${config.xdg.dataHome}/android";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    GOPATH = "${config.xdg.dataHome}/go";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    MPLAYER_HOME = "${config.xdg.configHome}/mplayer";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
    OCTAVE_HISTFILE = "${config.xdg.cacheHome}/octave-hsts";
    OCTAVE_SITE_INITFILE = "${config.xdg.configHome}/octave/octaverc";
    STACK_ROOT = "${config.xdg.dataHome}/stack";
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    _Z_DATA = "${config.xdg.dataHome}/z";
  };
}
