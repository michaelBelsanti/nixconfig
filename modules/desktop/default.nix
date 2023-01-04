{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wezterm
    dolphin
    ark
    selectdefaultapplication
    wmctrl
    nsxiv
    pamixer
    networkmanagerapplet
    pavucontrol

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

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
