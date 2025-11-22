{
  styx.apps._.topgrade.homeManager.programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        cleanup = true;
        disable = [
          # Broken stuff on NixOS
          "system"
          "helix"
          "uv"
          "bun"
          "github_cli_extensions"
        ];
      };
    };
  };
}
