{ ... }: {
  programs.helix = {
    enable = true;
    settings = {
      keys.normal = {
        X = "extend_line_above";
        C-h = "jump_view_left";
        C-j = "jump_view_down";
        C-k = "jump_view_up";
        C-l = "jump_view_right";
        # space.q = "buffer-close";
      };
      editor = {
        shell = [ "nu" "-c" ];
        cursorline = true;
        cursorcolumn = true;
        color-modes = true;
        file-picker.hidden = false;
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        statusline = {
          left = [ "mode" "spinner" "file-type" "diagnostics" ];
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
}
