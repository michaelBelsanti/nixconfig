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

    (polkit_gnome.overrideAttrs (_oldAttrs: {
      postFixup = ''
        mkdir $out/bin
        ln -s $out/libexec/polkit-gnome-authentication-agent-1 $out/bin/polkit-gnome
      '';
    }))
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
