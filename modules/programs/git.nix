{
  delib,
  compat,
  ...
}:
delib.module {
  name = "programs.git";
  options = delib.singleEnableOption true;
  home.ifEnabled.programs.git =
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
    // compat.mkCompat
      {
        signing.format = "ssh";
      }
      {
        extraConfig.gpg.format = "ssh";
      };
}
