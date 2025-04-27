{ hostConfig, ... }:
{
  args.constants = let
    inherit (hostConfig) user;
  in {
    inherit user;
    username = user;
    home = "/home/${user}";
    configHome = "/home/${user}/.config";
    cacheHome = "/home/${user}/.cache";
    dataHome = "/home/${user}/.local/share";
    stateHome = "/home/${user}/.local/state";
    flakePath = "/home/${user}/.flake";
  };
}
