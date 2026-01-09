{ inputs, styx, ... }:
{
  styx.helix = {
    homeManager =
      { pkgs, ... }:
      {
        home.sessionVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
          EDIR_EDITOR = "hx";
        };
        programs.helix = {
          enable = true;
          package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix.overrideAttrs (
            _final: prev: {
              cargoBuildFeatures = [ "steel" ];
            }
          );

          languages = {
            language-server.ucm = {
              command = "nc";
              args = [
                "localhost"
                "5757"
              ];
            };
            language = [
              {
                name = "unison";
                language-servers = [ "ucm" ];
              }
            ];
          };
          settings = {
            keys.normal = {
              X = "extend_line_above";
              C-h = "jump_view_left";
              C-j = "jump_view_down";
              C-k = "jump_view_up";
              C-l = "jump_view_right";
              C-r = ":reload";
              A-r = ":reset-diff-change";
              C-d = ":half-page-down-smooth";
              C-u = ":half-page-up-smooth";
              pageup = ":page-up-smooth";
              pagedown = ":page-down-smooth";
              space."=" = ":format";
            };
            editor = {
              color-modes = true;
              cursorcolumn = true;
              cursorline = true;
              end-of-line-diagnostics = "error";
              inline-diagnostics.cursor-line = "hint";
              line-number = "relative";
              lsp.display-inlay-hints = true;
              rainbow-brackets = true;
              soft-wrap.enable = true;
              indent-guides = {
                render = true;
                skip-levels = 1;
              };
              cursor-shape = {
                insert = "bar";
                normal = "block";
                select = "underline";
              };
              shell = [
                "bash"
                "-c"
              ];
              statusline = {
                left = [
                  "mode"
                  "spinner"
                  "file-type"
                  "diagnostics"
                ];
                center = [ "file-name" ];
                right = [
                  "selections"
                  "position"
                  "separator"
                  "spacer"
                  "position-percentage"
                ];
                separator = "|";
              };
            };
          };
        };
      };
    provides.with-tools = {
      includes = [ styx.helix ];
      homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            # language servers / formatters
            lldb
            nil
            nixd
            nixfmt
            rust-analyzer
            gopls
            delve
            golangci-lint-langserver
            golangci-lint
            ty
            nodePackages.bash-language-server
            nodePackages_latest.typescript-language-server
          ];
        };
    };
  };
}
