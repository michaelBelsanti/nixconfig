{
  delib,
  pkgs,
  lib,
  constants,
  ...
}:
delib.module {
  name = "programs.shells.nushell";
  options.programs.shells.nushell = with delib; {
    enable = boolOption true;
    default = boolOption true;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.shells = [ pkgs.nushell ];
      users.users.${constants.username}.shell = lib.mkIf cfg.default pkgs.nushell;
    };
  home.ifEnabled = {
    programs = {
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
          highlight
          net
          query
          skim
          units
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
