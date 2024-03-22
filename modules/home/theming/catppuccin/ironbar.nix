{ inputs, ... }:
let
  inherit (inputs.nix-colors.colorSchemes.catppuccin-macchiato) palette;
in
{
  text = ''
    .background {
      border-radius: 8px;
    }

    #bar #start {
      border-radius: 8px;
      margin-left: 10px;
    }

    #bar #end {
      border-radius: 8px;
      margin-right: 10px;
    }

    .workspaces {
      border-radius: 8px;
    }

    .workspaces .item.focused {
      min-width: 3em;
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

    .notifications {
      background: linear-gradient(58deg,
          #${palette.base0E},
          #${palette.base0E},
          #${palette.base0E},
          #${palette.base0D},
          #${palette.base0D},
          #${palette.base0D});
    }
  '';
}
