{
  delib,
  pkgs,
  inputs,
  self,
  ...
}:
delib.module {
  name = "nix";
  # Enable flakes
  nixos.always = {
    imports = [ inputs.lix-module.nixosModules.default ];
    nixpkgs.config.allowUnfree = true;
    nix = {
      package = pkgs.lix;
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
          "pipe-operator"
        ];
        log-lines = 25;
        keep-outputs = true;
        keep-derivations = true;
        builders-use-substitutes = true;
      };
    };
  };
  home.always = {
    nixpkgs.config.allowUnfree = true;
    nix.registry = {
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
      nixconfig = {
        exact = true;
        from = {
          id = "nixconfig";
          type = "indirect";
        };
        to = {
          type = "path";
          path = "${self.outPath}";
        };
      };
    };
  };
}
