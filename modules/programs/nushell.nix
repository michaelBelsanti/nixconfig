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
              highlight
              net
              query
              skim
              units
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
            package = pkgs.carapace.overrideAttrs {
              src = pkgs.fetchFromGitHub {
                owner = "carapace-sh";
                repo = "carapace-bin";
                rev = "d8fc7d6bfac349dc0272dcf27e5b1f75c454327a";
                hash = "sha256-7BTORiiGTp+uDDeOB7QGyrOxdHlcOkCEzDr2p70RHZM=";
              };
              vendorHash = "sha256-XRbqxL2ANWi2aZbB30tNBxJoBIoDoMxKXMpOx++JJ6M=";
            };
            enableNushellIntegration = true;
          };
        };
      };
  };
}
