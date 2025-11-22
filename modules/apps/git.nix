{ mkCompat, lib, ... }:
let
  mkCompat =
    unstableOptions: stableOptions:
    if (lib.versionOlder lib.version "25.11pre") then stableOptions else unstableOptions;
in

{
  styx.apps._.git.homeManager =
    { lib, ... }:
    let
      git_settings = {
        init.defaultBranch = "main";
        pull.rebase = true;
        rerere.enabled = true;
        column.ui = "auto";
        fetch.prune = true;
        interactive.singlekey = true;
      };
    in
    {
      programs = lib.mkMerge [
        {
          git = {
            enable = true;
            lfs.enable = true;
            signing = {
              format = "ssh";
              key = "~/.ssh/id_ed25519.pub";
              signByDefault = true;
            };
          };
        }
        (mkCompat
          {
            difftastic.enable = true;
            git = {
              settings = {
                user.name = "quasigod";
                user.email = "quasigod-io@proton.me";
              }
              // git_settings;
            };
          }
          {
            git = {
              difftastic.enable = true;
              userName = "quasigod";
              userEmail = "quasigod-io@proton.me";
              extraConfig = git_settings;
            };
          }
        )
      ];
    };
}
