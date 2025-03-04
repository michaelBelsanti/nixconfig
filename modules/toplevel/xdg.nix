{
  delib,
  host,
  lib,
  ...
}:
let
  vars = {
    # cleaning up ~
    ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    DOTNET_CLI_HOME ="$XDG_DATA_HOME/dotnet";
    GOPATH = "$XDG_DATA_HOME/go";
    GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
    LESSHISTFILE = "$XDG_CACHE_HOME/less/history";
    MPLAYER_HOME = "$XDG_CONFIG_HOME/mplayer";
    NUGET_PACKAGES = "$XDG_CACHE_HOME/NuGetPackages";
    OCTAVE_HISTFILE = "$XDG_CACHE_HOME/octave-hsts";
    OCTAVE_SITE_INITFILE = "$XDG_CONFIG_HOME/octave/octaverc";
    STACK_ROOT = "$XDG_DATA_HOME/stack";
    WINEPREFIX = "$XDG_DATA_HOME/wine";
    XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
    _Z_DATA = "$XDG_DATA_HOME/z";
  };
in
delib.module {
  name = "xdg";
  nixos.always.xdg = {
    terminal-exec.enable = host.isWorkstation;
    portal.xdgOpenUsePortal = host.isWorkstation;
  };
  home.always = {
    home.sessionVariables = vars;
    xdg = {
      enable = true;
      userDirs = lib.mkIf host.isWorkstation {
        enable = true;
        createDirectories = true;
        desktop = null;
        templates = null;
        music = null;
      };
    };
  };
}
