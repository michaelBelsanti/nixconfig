{
  delib,
  inputs,
  constants,
  pkgs,
  ...
}:
delib.module {
  name = "secrets";
  options = delib.singleEnableOption true;
  home.always.home = {
    sessionVariables.SOPS_AGE_KEY_FILE = "${constants.configHome}/sops/age/keys.txt";
    packages = [ pkgs.sops ];
  };
  nixos.always = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${constants.configHome}/sops/age/keys.txt";
    };
  };
}
