{ lib, ... }:
{
  styx.nushell =
    { user, ... }:
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [ pkgs.nushell ];
          users.users.${user.userName}.shell = pkgs.bashInteractive;
        };
      homeManager =
        { pkgs, ... }:
        {
          programs = {
            nushell = {
              enable = true;
              package = pkgs.nushell.override {
                additionalFeatures = _: [
                  "full"
                  "mcp"
                ];
              };
              plugins = with pkgs.nushellPlugins; [
                # highlight
                # query
                # skim
              ];
              shellAliases = {
                o = "xdg-open";
                l = "ls";
                la = "ls -a";
                ll = "ls -al";
                tree = "eza -T";
              };
              extraConfig = ''
                $env.config = {
                  show_banner: false
                  display_errors: {
                      exit_code: false
                      termination_signal: true
                  }
                  completions: {
                    algorithm: "substring"
                  }
                }

                $env.config.keybindings ++= [
                  {
                    name: deleteword
                    modifier: control
                    keycode: backspace
                    mode: [ emacs vi_normal vi_insert ]
                    event: { edit: BackspaceWord }
                  }
                ]
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
          xdg.configFile = {
            "nushell/autoload/def.nu".text = ''
              # zoxide poorly handles trailing /
              def cd --env --wrapped (...rest: string) {
              let trimmed = if ($rest | is-empty) {
                  $rest
              } else {
                  $rest | update ($rest | length | $in - 1) { str trim -r -c '/' }
              }
                __zoxide_z ...$trimmed
              }

              # faster nix shell command when needing many packages
              def --wrapped nxs (...input: string) {
                let flags = $input | where ($it | str starts-with "-")
                let packages = $input | where not ($it | str starts-with "-")
                let formatted_packages = $packages | each {|package|
                  if not ($package | str contains "#") {
                    return $"nixpkgs#($package)"
                  }
                  $package
                }
                ^nix shell ...$formatted_packages ...$flags
              }
            '';
          };
        };
    };
}
