{ pkgs, flakePath, ... }:
{
  home.packages = with pkgs; [ carapace ];
  programs = {
    starship.enableNushellIntegration = true;
    nushell = {
      enable = true;
      shellAliases = {
        l = "ls -a";
        lg = "lazygit";
        o = "xdg-open";
        nixup = "doas nixos-rebuild switch --flake '${flakePath}'";
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
}
