{ ... }:
{
  config.home = {
    home.shellAliases.jji = "jj --ignore-immutable";
    programs.jujutsu = {
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
  };
}
