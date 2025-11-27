{ ... }:
{
  styx.apps._.git.homeManager =
    { lib, ... }:
    {
      programs = lib.mkMerge [
        {
          difftastic.enable = true;
          git = {
            enable = true;
            lfs.enable = true;
            signing = {
              format = "ssh";
              key = "~/.ssh/id_ed25519.pub";
              signByDefault = true;
            };
            settings = {
              user.name = "quasigod";
              user.email = "quasigod-io@proton.me";
              init.defaultBranch = "main";
              pull.rebase = true;
              rerere.enabled = true;
              column.ui = "auto";
              fetch.prune = true;
              interactive.singlekey = true;
            };
          };
        }
      ];
    };
}
