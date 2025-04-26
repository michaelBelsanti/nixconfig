{
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
{
  nixos.xdg = {
    terminal-exec.enable = host.is "workstation";
    portal.xdgOpenUsePortal = host.is "workstation";
    autostart.enable = lib.mkForce false;
  };
  home = {
    home.sessionVariables = vars;
    xdg = {
      enable = true;
      inherit
        configHome
        dataHome
        cacheHome
        stateHome
        ;
      userDirs = lib.mkIf host.is "workstation" {
        enable = true;
        createDirectories = true;
        desktop = null;
        templates = null;
        music = null;
      };
    };
  };
}
