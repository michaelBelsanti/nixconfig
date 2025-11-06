{ lib, ... }:
{
  unify = {
    nixos =
      { pkgs, hostConfig, ... }:
      {
        environment.systemPackages = [ pkgs.nushell ];
        users.users.${hostConfig.primaryUser}.shell = pkgs.bashInteractive;
      };
    home =
      { pkgs, ... }:
      {

        programs = {
          nushell = {
            package = pkgs.nushell.override {
              additionalFeatures = _: [
                "full"
                "mcp"
              ];
            };
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
                completions: {
                  algorithm: "fuzzy"
                }
              }

              # fix paths in distrobox
              use std/util "path add"
              if "DISTROBOX_ENTER_PATH" in $env {
                path add "/usr/local/sbin"
                path add "/usr/local/bin"
                path add "/usr/sbin"
                path add "/usr/bin"
                path add "/sbin"
                path add "/bin"
              }
            '';
          };
          carapace = {
            enable = true;
            enableNushellIntegration = true;
          };
          bash.initExtra = ''
            # https://discourse.nixos.org/t/nushell-as-default-shell/68609/17
            # Some programs launch interactive shells and pretend
            # to use them; such programs always expect a form of POSIX
            # shell.
            #
            # If you don't use programs like that, you can just skip
            # this conditional.
            if ! [ "$TERM" = "dumb" ]; then
              exec nu
            fi
          '';
        };
      };
  };
}
