{
  pkgs,
  lib,
  constants,
  config,
  mylib,
  ...
}:
let
  cfg = config.programs.shells.nushell;
in
{
  options.programs.shells.nushell = {
    enable = mylib.mkBool true;
    default = mylib.mkBool true;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.shells = [ pkgs.nushell ];
      users.users.${constants.user}.shell = lib.mkIf cfg.default pkgs.nushell;
    };
    home.programs = {
      nushell = {
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
        plugins = with pkgs.nushellPlugins; [
          # highlight
          # net
          # query
          # skim
          # units
        ];
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
}
