{ inputs, ... }:
{
  den.default = {
    nixos = {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];
      nixpkgs.config.allowUnfree = true;
      programs.nix-index-database.comma.enable = true;
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
            "@wheel"
          ];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          log-lines = 25;
          keep-outputs = true;
          keep-derivations = true;
          builders-use-substitutes = true;
          use-xdg-base-directories = true;
        };
      };
    };
    homeManager = {
      imports = [ inputs.nix-index-database.homeModules.nix-index ];
      programs.nix-index-database.comma.enable = true;
      programs.nix-index.enable = true;
      nix.registry = {
        quix = {
          exact = true;
          from = {
            id = "quix";
            type = "indirect";
          };
          to = {
            type = "git";
            url = "https://tangled.org/@belsanti.xyz/quix";
          };
        };
      };
    };
  };
}
