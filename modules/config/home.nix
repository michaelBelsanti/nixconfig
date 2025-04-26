{ username, ... }:
{
  nixos.always.home-manager.useGlobalPkgs = true;
  home = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "22.05";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
    };
    programs.home-manager.enable = true;
  };
}
