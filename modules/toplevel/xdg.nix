{
  den = {
    default.homeManager =
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
          _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
          LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
          MPLAYER_HOME = "${config.xdg.configHome}/mplayer";
          NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
          NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
          NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
          NPM_CONFIG_TMP = "$XDG_RUNTIME_HOME/npm";
          NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
          OCTAVE_HISTFILE = "${config.xdg.cacheHome}/octave-hsts";
          OCTAVE_SITE_INITFILE = "${config.xdg.configHome}/octave/octaverc";
          STACK_ROOT = "${config.xdg.dataHome}/stack";
          PYTHON_HISTORY = "${config.xdg.configHome}/python/history";
          WINEPREFIX = "${config.xdg.dataHome}/wine";
          XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
          _Z_DATA = "${config.xdg.dataHome}/z";
        };
      };
    aspects.workstation = {
      nixos.xdg.terminal-exec.enable = true;
      homeManager.xdg = {
        autostart.enable = true;
        autostart.readOnly = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = null;
          templates = null;
          music = null;
          publicShare = null;
        };
      };
    };
  };
}
