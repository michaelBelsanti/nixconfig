{
  delib,
  host,
  lib,
  constants,
  ...
}:
let
  inherit (constants)
    dataHome
    configHome
    cacheHome
    stateHome
    ;
  vars = {
    # cleaning up ~
    ANDROID_USER_HOME = "${dataHome}/android";
    CARGO_HOME = "${dataHome}/cargo";
    CUDA_CACHE_PATH = "${cacheHome}/nv";
    DOTNET_CLI_HOME = "${dataHome}/dotnet";
    GOPATH = "${dataHome}/go";
    GRADLE_USER_HOME = "${dataHome}/gradle";
    LESSHISTFILE = "${cacheHome}/less/history";
    MPLAYER_HOME = "${configHome}/mplayer";
    NODE_REPL_HISTORY = "${stateHome}/node_repl_history";
    NUGET_PACKAGES = "${cacheHome}/NuGetPackages";
    OCTAVE_HISTFILE = "${cacheHome}/octave-hsts";
    OCTAVE_SITE_INITFILE = "${configHome}/octave/octaverc";
    STACK_ROOT = "${dataHome}/stack";
    WINEPREFIX = "${dataHome}/wine";
    XCOMPOSECACHE = "${cacheHome}/X11/xcompose";
    _Z_DATA = "${dataHome}/z";
  };
in
delib.module {
  name = "xdg";
  nixos.always.xdg = {
    terminal-exec.enable = host.isWorkstation;
    portal.xdgOpenUsePortal = host.isWorkstation;
    autostart.enable = lib.mkForce false;
  };
  home.always = {
    home.sessionVariables = vars;
    xdg = {
      enable = true;
      inherit
        configHome
        dataHome
        cacheHome
        stateHome
        ;
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
