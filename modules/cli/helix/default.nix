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
        C-q = ":bc";
        space.q = ":quit"; 
      };
      editor = {
        shell = [ "nu" "-c" ];
        cursorline = true;
        cursorcolumn = true;
        color-modes = true;
        file-picker.hidden = true;
        line-number = "relative";
        lsp.display-messages = true;
        soft-wrap.enable = true;
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
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
      };
    };
  };
}
