{
  delib,
  ...
}:
delib.module {
  name = "programs.git";
  options = delib.singleEnableOption true;
  home.always.programs = {
    git = {
      enable = true;
      userName = "michaelBelsanti";
      userEmail = "quasigod-io@proton.me";
      difftastic.enable = true;
      aliases = {
        ci = "commit";
        co = "checkout";
        st = "status";
      };
      signing = {
        key = "~/.ssh/git.pub";
        signByDefault = true;
      };
      extraConfig = {
        gpg.format = "ssh";
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
