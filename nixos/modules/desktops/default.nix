{pkgs, ...}: {
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    dolphin
    ark
    selectdefaultapplication
    wmctrl
    gwenview
    pamixer
    pavucontrol
    libsForQt5.okular
    celluloid

    qt5ct
    breeze-icons
    libsForQt5.lightly
    libsForQt5.baloo # dolphin
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
