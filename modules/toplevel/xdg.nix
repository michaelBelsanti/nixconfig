{
  unify = {
    home =
      { config, ... }:
      {
        xdg.enable = true;
        home.sessionVariables = {
          # cleaning up ~
          ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
          CARGO_HOME = "${config.xdg.dataHome}/cargo";
          CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
          DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
          GOPATH = "${config.xdg.dataHome}/go";
          GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
          LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
          MPLAYER_HOME = "${config.xdg.configHome}/mplayer";
          NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
          NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
          OCTAVE_HISTFILE = "${config.xdg.cacheHome}/octave-hsts";
          OCTAVE_SITE_INITFILE = "${config.xdg.configHome}/octave/octaverc";
          STACK_ROOT = "${config.xdg.dataHome}/stack";
          WINEPREFIX = "${config.xdg.dataHome}/wine";
          XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
          _Z_DATA = "${config.xdg.dataHome}/z";
        };
      };
    modules.workstation = {
      nixos.xdg = {
        portal.enable = true;
        terminal-exec.enable = true;
      };
      home.xdg.userDirs = {
        enable = true;
        createDirectories = true;
        desktop = null;
        templates = null;
        music = null;
      };
    };
  };
}
