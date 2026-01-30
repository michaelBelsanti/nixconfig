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
        };
    };
}
