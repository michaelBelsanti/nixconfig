{ pkgs, inputs, ... }:
{
  # Enable flakes
  nix = {
    # much is copied from https://github.com/nix-community/srvos/blob/main/nixos/common/nix.nix
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
    registry.nixpkgs.flake = inputs.nixpkgs;
    gc.automatic = true;
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "quasi"
        "michaelbelsanti"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      log-lines = 25;
      keep-outputs = true;
      keep-derivations = true;
      builders-use-substitutes = true;
    };
  };
}
