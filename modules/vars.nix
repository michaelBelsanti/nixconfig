{ delib, constants, ... }:
delib.module {
  name = "home";

  home.always =
    let
      inherit (constants) configHome cacheHome dataHome;
    in
    {
      home.sessionVariables = {
        # cleaning up ~
        ANDROID_HOME = "${dataHome}/android";
        CARGO_HOME = "${dataHome}/cargo";
        CUDA_CACHE_PATH = "${cacheHome}/nv";
        GOPATH = "${dataHome}/go";
        LESSHISTFILE = "${cacheHome}/less/history";
        MPLAYER_HOME = "${configHome}/mplayer";
        NUGET_PACKAGES = "${cacheHome}/NuGetPackages";
        OCTAVE_HISTFILE = "${cacheHome}/octave-hsts";
        OCTAVE_SITE_INITFILE = "${configHome}/octave/octaverc";
        STACK_ROOT = "${dataHome}/stack";
        XCOMPOSECACHE = "${cacheHome}/X11/xcompose";
        _Z_DATA = "${dataHome}/z";
      };
    };
}
