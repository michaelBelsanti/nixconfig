{ inputs, ... }:
let
  inherit (inputs.nix-colors.colorSchemes.catppuccin-macchiato) palette;
in
{
  text = ''
    .widget {
      margin: 0px 4px;
    }

    .background {
      border-radius: 8px;
    }

    #bar {
      padding: 6px 4px;
    }

    #bar #end {
      padding: 0px 4px;
    }

    .workspaces .item {
      margin: 0px 2px
    }

    .workspaces .item.focused {
      min-width: 3.2em;
      background-size: 400% 400%;
      transition: all 0.3s ease;
      background: linear-gradient(58deg,
          #${palette.base0E},
          #${palette.base0E},
          #${palette.base0E},
          #${palette.base0D},
          #${palette.base0D},
          #${palette.base0D});
    }

    .tray {
      border-radius: 8px;
      padding: 0px 4px;
    }

    .clock {
      margin-right: 8px;
    }

    .notifications .count {
      padding-right: .5em
    }
  '';
}
