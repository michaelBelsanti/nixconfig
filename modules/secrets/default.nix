{ inputs, ... }:
let
  sops_config = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/secrets/sops/age/keys.txt";
  };
in
{
  unify.home =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];
      sops = sops_config;
      home.sessionVariables.SOPS_AGE_KEY_FILE = sops_config.age.keyFile;
      home.packages = [ pkgs.sops ];
    };
  unify.nixos = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops = sops_config;
  };
}
