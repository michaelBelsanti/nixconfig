{ pkgs, flakePath, ... }:
let
in
# nuprompt = pkgs.writeText "nuprompt" "${builtins.readFile ./panache-git.nu}";
{
  home.packages = with pkgs; [ carapace ];
  programs = {
    starship.enableNushellIntegration = true;
    nushell = {
      enable = true;
      # envFile.source = ./env.nu;
      # configFile.source = ./config.nu;
      extraConfig = ''
        # nitch

        alias ls = ls -a
        alias lg = lazygit
        alias o = xdg-open
        # alias nixup = doas nixos-rebuild switch --flake '${flakePath}'
        # alias nixUp = (nix flake update ${flakePath}; doas nixos-rebuild switch --flake '${flakePath}')

        # carapace setup
        source ~/.cache/carapace/init.nu
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
