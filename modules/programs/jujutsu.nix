{
  unify.home = {
    home.shellAliases.jji = "jj --ignore-immutable";
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "quasigod";
          email = "quasigod-io@proton.me";
        };
        ui = {
          default-command = [
            "log"
            "--no-pager"
          ];
          show-cryptographic-signatures = true;
        };
        git.private-commits = "description(glob:'private:*')";
        signing = {
          behavior = "own";
          backend = "ssh";
          key = "~/.ssh/id_ed25519.pub";
        };
      };
    };
  };
}
