{ lib, ... }:
{
  unify = {
    nixos =
      { pkgs, hostConfig, ... }:
      {
        environment.shells = [ pkgs.nushell ];
        users.users.${hostConfig.primaryUser}.shell = pkgs.nushell;
      };
    home =
      { pkgs, ... }:
      {
        programs = {
          nushell = {
            plugins = with pkgs.nushellPlugins; [
              highlight
              net
              query
              skim
              units
            ];
            enable = true;
            shellAliases = {
              l = "ls";
              la = "ls -a";
              ll = "ls -al";
              mkdir = lib.mkForce "mkdir";
            };
            extraConfig = ''
              $env.config = {
                show_banner: false
                display_errors: {
                    exit_code: false
                    termination_signal: true
                }
              }
            '';
          };
          carapace = {
            enable = true;
            enableNushellIntegration = true;
          };
        };
      };
  };
}
