# Main NixOS home-manager configuration, imported by all NixOS configs
{
  delib,
  config,
  ...
}:
delib.module {
  name = "home";
  home.always =
    { myconfig, ... }:
    {
      # Home Manager Setup
      home = {
        username = "quasi";
        homeDirectory = "/home/quasi";
        stateVersion = "22.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
      nixpkgs.config.allowUnfree = true;

      # Git
      services = {
        pueue.enable = true;
      };
      programs = {
        git = {
          enable = true;
          userName = "michaelBelsanti";
          userEmail = "quasigod-io@proton.me";
          difftastic.enable = true;
          signing = {
            key = "~/.ssh/github.pub";
            signByDefault = true;
          };
          extraConfig = {
            gpg.format = "ssh";
            init.defaultBranch = "main";
            pull.rebase = true;
            rerere.enabled = true;
            column.ui = "auto";
          };
        };
      };

      # Cleaning up ~
      xdg.enable = true;
      home.sessionVariables =
        let
          inherit (myconfig.constants) configHome cacheHome dataHome;
        in
        {
          EDITOR = "hx";
          VISUAL = "hx";
          EDIR_EDITOR = "hx";
          BROWSER = "zen";
          FZF_DEFAULT_COMMAND = "find .";

          NIXPKGS_ALLOW_UNFREE = "1";

          MANGOHUD = "0";

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
