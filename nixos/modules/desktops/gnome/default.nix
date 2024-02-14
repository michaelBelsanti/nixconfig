{
  pkgs,
  user,
  ...
}: {
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.defaultSession = "gnome";
  };
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };
  environment = {
    systemPackages = with pkgs; [
      gnome.gnome-tweaks
      dconf2nix
    ];
    sessionVariables = {
      GDK_DEBUG = "gl-fractional"; # Enable fractional scaling in GNOME 45
      QT_QPA_PLATFORM="wayland";
    };
  };
  home-manager.users.${user} = {
    home.packages = with pkgs.gnomeExtensions; [
      forge
      gtk-title-bar
      appindicator
    ];
    dconf.settings = {
      "org/gnome/mutter" = {
        # Enable fractional scaling below GNOME 45
        experimental-features = [ "scale-monitor-framebuffer" ];
        edge-tiling = true;
        focus-change-on-pointer-rest = false;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        font-antialiasing = "rgba";
        font-hinting = "slight";
      };
      "org/gnome/shell" = {
        enabled-extensions = ["user-theme@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "forge@jmmaranan.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com"];
        favorite-apps = [ "floorp.desktop" "org.gnome.Nautilus.desktop" "org.codeberg.dnkl.footclient.desktop" ];
      };
      "org/gnome/shell/extensions/forge" = {
        tiling-mode-enabled = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:close";
        focus-mode = "sloppy";
        auto-raise = true;
      };

      # Keybinds
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        toggle-maximized = [ "<Super>f" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-10 = [ "<Super>0" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-6 = [ "<Shift><Super>6" ];
        move-to-workspace-7 = [ "<Shift><Super>7" ];
        move-to-workspace-8 = [ "<Shift><Super>8" ];
        move-to-workspace-9 = [ "<Shift><Super>9" ];
        move-to-workspace-10 = [ "<Shift><Super>0" ];
        begin-move = [];
        begin-resize = [];
        cycle-group = [];
        cycle-group-backward = [];
        cycle-panels = [];
        cycle-panels-backward = [];
        cycle-windows = [];
        cycle-windows-backward = [];
        maximize = [];
        minimize = [];
        move-to-monitor-down = [];
        move-to-monitor-left = [];
        move-to-monitor-right = [];
        move-to-monitor-up = [];
        move-to-workspace-last = [];
        move-to-workspace-left = [];
        move-to-workspace-right = [];
        panel-run-dialog = [];
        switch-input-source = [];
        switch-input-source-backward = [];
        switch-panels = [];
        switch-panels-backward = [];
        switch-to-workspace-last = [];
        switch-to-workspace-left = [];
        switch-to-workspace-right = [];
        unmaximize = [];
      };
      "org/gnome/shell/extensions/forge/keybindings" = {
        con-split-horizontal = [];
        con-split-layout-toggle = [];
        con-split-vertical = [];
        con-stacked-layout-toggle = [];
        con-tabbed-layout-toggle = [];
        con-tabbed-showtab-decoration-toggle = [];
        focus-border-toggle = [];
        prefs-tiling-toggle = [ "<Super>w" ];
        window-focus-down = [ "<Super>j" ];
        window-focus-left = [ "<Super>h" ];
        window-focus-right = [ "<Super>l" ];
        window-focus-up = [ "<Super>k" ];
        window-gap-size-decrease = [];
        window-gap-size-increase = [];
        window-move-down = [ "<Shift><Super>j" ];
        window-move-left = [ "<Shift><Super>h" ];
        window-move-right = [ "<Shift><Super>l" ];
        window-move-up = [ "<Shift><Super>k" ];
        window-resize-bottom-decrease = [];
        window-resize-bottom-increase = [];
        window-resize-left-decrease = [];
        window-resize-left-increase = [];
        window-resize-right-decrease = [];
        window-resize-right-increase = [];
        window-resize-top-decrease = [];
        window-resize-top-increase = [];
        window-snap-center = [];
        window-snap-one-third-left = [];
        window-snap-one-third-right = [];
        window-snap-two-third-left = [];
        window-snap-two-third-right = [];
        window-swap-down = [];
        window-swap-last-active = [];
        window-swap-left = [];
        window-swap-right = [];
        window-swap-up = [];
        window-toggle-always-float = [];
        window-toggle-float = [ "<Shift><Super>f" ];
        workspace-active-tile-toggle = [];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "footclient";
        name = "Terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        help = [];
        home = [ "<Super>e" ];
        magnifier = [];
        magnifier-zoom-in = [];
        magnifier-zoom-out = [];
        screenreader = [];
        screensaver = [ "<Super>Escape" ];
        www = [ "<Super>b" ];
      };
      "org/gnome/shell/keybindings" = {
        screenshot = [ "<Super>s" ];
        screenshot-window = [ "<Alt><Super>s" ];
        show-screen-recording-ui = [ "<Shift><Super>r" ];
        show-screenshot-ui = [ "<Shift><Super>s" ];
        toggle-message-tray = [ "<Super>v" ];
        toggle-overview = [ "<Alt><Super>space" ];
        open-application-menu = [];
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        switch-to-application-5 = [];
        switch-to-application-6 = [];
        switch-to-application-7 = [];
        switch-to-application-8 = [];
        switch-to-application-9 = [];
        switch-to-application-10 = [];
        toggle-application-view = [];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [];
        toggle-tiled-right = [];
      };
      "org/gnome/mutter/wayland/keybindings" = {
        restore-shortcuts = [];
      };
    };
  };
}
