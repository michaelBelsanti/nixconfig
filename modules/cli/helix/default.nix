{ ...}:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_macchiato";
      editor.line-number = "relative";
      editor.lsp.display-messages = true;
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      keys.normal = {
        C-h = "jump_view_left";
        C-j = "jump_view_down";
        C-k = "jump_view_up";
        C-l = "jump_view_right";
        # space.q = "buffer-close";
      };
      editor.statusline = {
        left = [ "mode" "spinner" "file-type" "diagnostics" ];
        center = [ "file-name" ];
        right = [ "selections" "position" "separator" "spacer" "position-percentage" ];
        separator = "|";
      };
    };
    languages = [ { name = "nim"; scope = "source.nim"; injection-regex = "nim"; file-types = ["nim" "nims"]; shebangs = ["nim"]; comment-token = "#"; roots = []; } ];
  };
}
