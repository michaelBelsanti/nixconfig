{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.shells.nushell;
in
{
  options.shells.nushell.enable = mkBoolOpt false "Enable nushell configuration.";
  config = mkIf cfg.enable {
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
          nixup = "doas nixos-rebuild switch --flake '${flakePath}'";
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
