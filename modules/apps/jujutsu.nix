{
  styx.apps._.jujutsu.homeManager =
    { pkgs, ... }:
    {
      home.shellAliases.jji = "jj --ignore-immutable";
      home.packages = [ pkgs.gnupg ];
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "quasigod";
            email = "quasigod-io@proton.me";
          };
          aliases.tug = [
            "bookmark"
            "move"
            "--from"
            "heads(::@- & bookmarks())"
            "--to"
            "@-"
          ];
          ui = {
            default-command = [
              "log"
              "--no-pager"
              "--reversed"
            ];
            show-cryptographic-signatures = true;
            diff-formatter = "difft";
          };
          git = {
            private-commits = "description(glob:'private:*')";
            write-change-id-header = true;
          };
          signing = {
            behavior = "own";
            backend = "ssh";
            key = "~/.ssh/id_ed25519.pub";
          };
        };
      };
    };
}

