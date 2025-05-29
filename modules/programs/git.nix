{
  unify.home = {
    programs.git = {
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
        format = "ssh";
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
    };
  };
}
