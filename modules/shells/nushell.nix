{ delib, pkgs, ... }:
delib.module {
  name = "shells.nushell";
  options = delib.singleEnableOption true;
  nixos.ifEnabled = {myconfig, ...}: {
    environment.shells = [ pkgs.nushell ];
    users.users.${myconfig.constants.username}.shell = pkgs.nushell;
  };
  home.ifEnabled = {
    home.packages = with pkgs; [ carapace ];
    programs = {
      starship.enableNushellIntegration = true;
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
