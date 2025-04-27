{
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
{
  home = {
    sops = sops_config;
    home.sessionVariables.SOPS_AGE_KEY_FILE = "${constants.configHome}/sops/age/keys.txt";
    home.packages = [ pkgs.sops ];
  };
  nixos.sops = sops_config;
}
