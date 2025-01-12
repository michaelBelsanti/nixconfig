{
  delib,
  ...
}:
delib.module {
  name = "programs.git";
  home.always = {
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
}
