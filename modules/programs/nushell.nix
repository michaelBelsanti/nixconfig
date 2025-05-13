{ lib, constants, ... }:
{
  unify = {
    nixos =
      { pkgs, ... }:
      {
        environment.shells = [ pkgs.nushell ];
        users.users.${constants.user}.shell = pkgs.nushell;
      };
    home =
      { pkgs, mkCompat, ... }:
      {
        programs = {
          # TODO reenable when fixed
          nushell =
            mkCompat {
              plugins = with pkgs.nushellPlugins; [
                highlight
                net
                # query
                # skim
                # units
              ];
            } { }
            // {
              enable = true;
              shellAliases = {
                l = "ls";
                la = "ls -a";
                ll = "ls -al";
                lg = "lazygit";
                o = "xdg-open";
                cd = "z";
                # overrides for global aliases
                mkdir = lib.mkForce "mkdir";
                open = lib.mkForce "open";
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
