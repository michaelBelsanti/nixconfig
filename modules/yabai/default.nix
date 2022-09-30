{ config, lib, pkgs, ...}: {
  services.yabai = {
    enable = true;
    # enableScriptingAddition = true;
    package = pkgs.yabai;
    config = {
      # layout
      layout = "bsp";
      auto_balance = "on";
      split_ratio = "0.50";
      window_placement = "second_child";
      # Gaps
      window_gap = 8;
      top_padding = 36;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      # shadows and borders
      window_border = "off";
      window_border_width = 3;
      window_opacity = "on";
      window_opacity_duration = "0.1";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      # mouse
      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
      focus_follows_mouse = "on";
      mouse_follows_focus = "on";
    };
    extraConfig = ''
      # rules
      yabai -m rule --add app=emacs-29.0.50 manage=on
      yabai -m rule --add app='Firefox Nightly' manage=on
      yabai -m rule --add app='System Preferences' manage=off
      yabai -m rule --add app='Activity Monitor' manage=off
    '';
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position = "top";
      height = 28;
      title = "on";
      spaces = "on";
      power = "on";
      clock = "off";
      right_shell = "off";
      padding_left = 20;
      padding_right = 20;
      spacing_left = 25;
      spacing_right = 25;
      text_font = ''"Montserrat:18.0"'';
      icon_font = ''"Montserrat:18.0"'';
      background_color = "0xff161616";
      foreground_color = "0xffFFFFFF";
      space_icon_color = "0xff3ddbd9";
      power_icon_strip = " ";
      space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
      spaces_for_all_displays = "on";
      display_separator = "on";
      display_separator_icon = "|";
      clock_format = ''"%d/%m/%y %R"'';
      right_shell_icon = " ";
      right_shell_command = "whoami";
    };
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # open terminal
      cmd - return : alacritty
      # focus window
      lalt - h : yabai -m window --focus west
      lalt - j : yabai -m window --focus south
      lalt - k : yabai -m window --focus north
      lalt - l : yabai -m window --focus east
      # swap managed window
      shift + lalt - h : yabai -m window --swap west
      shift + lalt - l : yabai -m window --swap east
      shift + lalt - j : yabai -m window --swap south
      shift + lalt - k : yabai -m window --swap north
      # focus spaces
      lalt - 1 : yabai -m space --focus 1
      lalt - 2 : yabai -m space --focus 2
      lalt - 3 : yabai -m space --focus 3
      lalt - 4 : yabai -m space --focus 4
      lalt - 5 : yabai -m space --focus 5
      lalt - 6 : yabai -m space --focus 6
      lalt - 7 : yabai -m space --focus 7
      lalt - 8 : yabai -m space --focus 8
      # send window to desktop
      shift + lalt - x : yabai -m window --space recent
      shift + lalt - 1 : yabai -m window --space 1
      shift + lalt - 2 : yabai -m window --space 2
      shift + lalt - 3 : yabai -m window --space 3
      shift + lalt - 4 : yabai -m window --space 4
      shift + lalt - 5 : yabai -m window --space 5
      shift + lalt - 6 : yabai -m window --space 6
      shift + lalt - 7 : yabai -m window --space 7
      shift + lalt - 8 : yabai -m window --space 8
      # float / unfloat window and center on screen
      lalt - return : yabai -m window --toggle float;\
                 yabai -m window --grid 4:4:1:1:2:2;;
      # toggle window zoom
      lalt - f : yabai -m window --toggle zoom-parent
    '';
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    dock = {
      autohide = true;
      showhidden = true;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = true;
    };
    NSGlobalDomain = {
      _HIHideMenuBar = true;
    };
  };
}
