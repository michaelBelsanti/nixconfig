{
  delib,
  inputs,
  constants,
  pkgs,
  ...
}:
let
  sops_config = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${constants.configHome}/sops/age/keys.txt";
  };
in
delib.module {
  name = "secrets";
  options = delib.singleEnableOption true;
  home.always = {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];
    sops = sops_config;
    home.sessionVariables.SOPS_AGE_KEY_FILE = "${constants.configHome}/sops/age/keys.txt";
    home.packages = [ pkgs.sops ];
  };
  nixos.always = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops = sops_config;
  };
}
