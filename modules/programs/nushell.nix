{ lib, ... }:
{
  unify = {
    nixos =
      { pkgs, hostConfig, ... }:
      {
        environment.shells = [ pkgs.nushell ];
        users.users.${hostConfig.primaryUser}.shell = pkgs.nushell;
      };
    home =
      { pkgs, ... }:
      {
        programs = {
          nushell = {
            plugins = with pkgs.nushellPlugins; [
              # highlight
              # net
              # query
              # skim
              # units
            ];
            enable = true;
            shellAliases = {
              l = "ls";
              la = "ls -a";
              ll = "ls -al";
              mkdir = lib.mkForce "mkdir";
            };
            extraConfig = ''
              $env.config = {
                show_banner: false
                display_errors: {
                    exit_code: false
                    termination_signal: true
                }
              }
            '';
          };
          carapace = {
            enable = true;
            enableNushellIntegration = true;
            package = pkgs.carapace.overrideAttrs (
              self: super: {
                vendorHash = "sha256-6y1eolm+QGXc0ZXyPr1tEC23RnR3sxvKAjRC2i1A/hk=";
                src = pkgs.fetchFromGitHub {
                  owner = "carapace-sh";
                  repo = "carapace-bin";
                  rev = "6ea9333a5b65d0eee7e32d73383b1aa971814a06";
                  hash = "sha256-q70wzvC3wnyXEFvfw/F6KH1c2LyLj/w6VmX1mtPfuQo=";
                };
              }
            );
          };
        };
      };
  };
}
