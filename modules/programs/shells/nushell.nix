{
  pkgs,
  lib,
  user,
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
    default = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.shells = [ pkgs.nushell ];
      users.users.${user}.shell = lib.mkIf cfg.default pkgs.nushell;
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
        extraEnv = ''
          sh -c "source /etc/profile"
          sh -c "source ~/.profile"
        '';
      };
    };
  };
}
