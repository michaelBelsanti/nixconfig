{ delib, pkgs, ... }:
delib.module {
  name = "programs.shells.nushell";
  options = with delib; {
    enable = enableOption true;
    default = enableOption true;
  };
  nixos.ifEnabled =
    { cfg, myconfig, ... }:
    {
      environment.shells = [ pkgs.nushell ];
      users.users.${myconfig.constants.username}.shell = cfg.default;
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
        };
        extraConfig = ''
          # carapace setup
          source ~/.cache/carapace/init.nu
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

          # carapace setup
          mkdir ~/.cache/carapace
          carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
        '';
      };
    };
  };
}
