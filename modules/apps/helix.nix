{ lib, ... }:
{
  styx.apps._.helix.homeManager =
    { pkgs, ... }:
    {
      home.sessionVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
        EDIR_EDITOR = "hx";
      };
      programs.helix = {
        enable = true;
        languages = {
          language = [
            {
              name = "nix";
              formatter.command = "nixfmt";
            }
            {
              name = "markdown";
              language-servers = [
                "ltex-ls-plus"
                "marksman"
                "markdown-oxide"
              ];
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
            "space"."=" = ":format";
          };
          editor = {
            shell = [
              "bash"
              "-c"
            ];
            cursorline = true;
            cursorcolumn = true;
            color-modes = true;
            file-picker = {
              hidden = true;
              git-ignore = true;
            };
            line-number = "relative";
            lsp = {
              # display-messages = true;
              display-inlay-hints = true;
            };
            inline-diagnostics = {
              cursor-line = "hint";
            };
            end-of-line-diagnostics = "error";
            soft-wrap.enable = true;
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
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
            indent-guides = {
              render = true;
              skip-levels = 1;
            };
          };
        };
      };
      home.packages = with pkgs; [
        # language servers / formatters
        lldb
        nil
        nixd
        nixfmt-rfc-style
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
}
