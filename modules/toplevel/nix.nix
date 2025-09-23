{ inputs, ... }:
{
  unify = {
    nixos =
      { pkgs, ... }:
      {
        programs.command-not-found.enable = true;
        programs.command-not-found.dbPath = "${pkgs.path}/programs.sqlite";
        nixpkgs.config.allowUnfree = true;
        nix = {
          package = pkgs.lixPackageSets.latest.lix;
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
    home.nix.registry = {
      develop = {
        exact = true;
        from = {
          id = "develop";
          type = "indirect";
        };
        to = {
          type = "git";
          url = "https://codeberg.org/quasigod/develop";
        };
      };
    };
  };
}
