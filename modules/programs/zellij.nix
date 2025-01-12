{ delib, lib, config, ... }:
delib.module {
  name = "programs.zellij";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };
    xdg.configFile = {
      "zellij/config.kdl".text = ''
        // default_mode "locked"
        pane_frames false
        theme "catppuccin-macchiato"
        // default_layout "compact"
        keybinds {
            unbind "Ctrl h"
            normal {
                bind "Ctrl n" { SwitchToMode "move"; }
            }
            move {
                bind "Ctrl n" { SwitchToMode "normal"; }
            }
            shared {
                bind "Alt q" { CloseFocus; }
                bind "Alt n" { NewPane; }
                bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
                bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
                bind "Alt j" "Alt Down" { MoveFocus "Down"; }
                bind "Alt k" "Alt Up" { MoveFocus "Up"; }
                bind "Alt =" "Alt +" { Resize "Increase"; }
                bind "Alt -" { Resize "Decrease"; }
                bind "Alt [" { PreviousSwapLayout; }
                bind "Alt ]" { NextSwapLayout; }
                bind "Alt w" { ToggleFloatingPanes; }
            }
        }
      '';
      "zellij/layouts/haskell.kdl".text = ''
        layout {
          pane split_direction="horizontal" {
        		pane edit="main.hs"
            pane size="20%" {
              command "ghci"
        			args "main.hs"
        		}
          }
        }
      '';
      "zellij/themes/catppuccin.kdl".text = ''
        themes {
            catppuccin-frappe {
                fg 198 208 245
                bg 98 104 128
                black 41 44 60

                red 231 130 132
                green 166 209 137
                yellow 229 200 144
                blue 140 170 238
                magenta 244 184 228
                cyan 153 209 219
                white 198 208 245
                orange 239 159 118
            }
            catppuccin-latte {
                fg 172 176 190
                bg 172 176 190
                black 76 79 105
                red 210 15 57
                green 64 160 43
                yellow 223 142 29
                blue 30 102 245
                magenta 234 118 203
                cyan 4 165 229
                white 220 224 232
                orange 254 100 11
            }
            catppuccin-macchiato {
                fg 202 211 245
                bg 91 96 120
                black 30 32 48
                red 237 135 150
                green 166 218 149
                yellow 238 212 159
                blue 138 173 244
                magenta 245 189 230
                cyan 145 215 227
                white 202 211 245
                orange 245 169 127
            }
            catppuccin-mocha {
                fg 205 214 244
                bg 88 91 112
                black 24 24 37
                red 243 139 168
                green 166 227 161
                yellow 249 226 175
                blue 137 180 250
                magenta 245 194 231
                cyan 137 220 235
                white 205 214 244
                orange 250 179 135
            }
        }
      '';
    };
  };
}
