{ config, pkgs, flakePath, ... }:
  let 
    nuprompt = pkgs.writeText "nuprompt" "${builtins.readFile ./panache-git.nu}";
  in
{
  home.packages = with pkgs; [ carapace ];
  programs = {
    nushell = {
      enable = true;
      envFile.source = ./env.nu;
      configFile.source = ./config.nu;
      extraConfig = ''
        nitch

        alias ls = ls -a
        alias lg = lazygit
        alias o = xdg-open
        alias nixup = doas nixos-rebuild switch --flake '${flakePath}'
        alias nixUp = (nix flake update ${flakePath}; doas nixos-rebuild switch --flake '${flakePath}')
      '';
      extraEnv = ''
        sh -c "source /etc/profile"
        sh -c "source ~/.profile"

        use ${nuprompt} panache-git
        let-env PROMPT_COMMAND = { panache-git }
        let-env PROMPT_INDICATOR = { "" }
      '';
    };
  };
}
