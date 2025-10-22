{
  unify.home = {
    programs.difftastic.enable = true;
    programs.git = {
      enable = true;
      lfs.enable = true;
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
      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };
  };
}
