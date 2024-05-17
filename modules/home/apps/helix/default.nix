{ lib, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "nix";
          formatter.command = "nixfmt";
        }
        {
          name = "css";
          language-servers = [ ];
        }
        {
          name = "scss";
          language-servers = [ ];
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
      };
      editor = {
        shell = [
          "fish"
          "-c"
        ];
        cursorline = true;
        cursorcolumn = true;
        color-modes = true;
        file-picker.hidden = true;
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
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
    nil
    nixfmt-rfc-style
    rust-analyzer
    gopls
    delve
    golangci-lint-langserver
    golangci-lint
    taplo
    python3Packages.python-lsp-server
    lua-language-server
    haskell-language-server
    nodePackages.bash-language-server
    shellcheck
    vscode-langservers-extracted
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.typescript-language-server
    marksman
    custom.markdown-oxide

    (writeScriptBin "toggle" ''
      #!${lib.getExe pkgs.nushell}

      def main [x] {
        let sx = $x | into string
        match $sx {
          'true' => 'false',
          'True' => 'False',
          'false' => 'true',
          'False' => 'True',
          _ => $sx
        } 
      }
    '')
  ];
}
