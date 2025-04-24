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
    default = boolOption false;
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
    };
  };
}
