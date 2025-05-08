{
  unify.home =
    { mkCompat, ... }:
    {
      home.shellAliases.jji = "jj --ignore-immutable";
      programs = {
        jujutsu = {
          enable = true;
          settings = {
            user = {
              name = "quasigod";
              email = "quasigod-io@proton.me";
            };
            ui = {
              paginate = "never";
              default-command = "log";
            };
            git.private-commits = "description(glob:'private:*')";
          };
        };
        git =
          {
            enable = true;
            lfs.enable = true;
            userName = "quasigod";
            userEmail = "quasigod-io@proton.me";
            difftastic.enable = true;
            aliases = {
              ci = "commit";
              co = "checkout";
              st = "status";
            };
            signing = {
              key = "~/.ssh/id_ed25519.pub";
              signByDefault = true;
            };
            extraConfig = {
              init.defaultBranch = "main";
              pull.rebase = true;
              rerere.enabled = true;
              column.ui = "auto";
              fetch.prune = true;
              interactive.singlekey = true;
            };
          }
          // mkCompat
            {
              signing.format = "ssh";
            }
            {
              extraConfig.gpg.format = "ssh";
            };
      };
    };
}
