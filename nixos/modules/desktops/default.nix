{ pkgs, ... }:
{
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    wezterm
    kitty
    dolphin
    ark
    selectdefaultapplication
    wmctrl
    gwenview
    pamixer
    pavucontrol
    libsForQt5.okular

    qt5ct
    breeze-icons
    libsForQt5.lightly

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
