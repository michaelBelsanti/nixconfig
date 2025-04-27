{
  inputs,
  pkgs,
  config,
  mylib,
  lib,
  ...
}:
let
  # https://git.eriedaberrie.me/eriedaberrie/dotfiles/src/branch/main/modules/home/graphical/firefox.nix
  mkNixPak = inputs.nixpak.result.lib.nixpak {
    inherit (pkgs) lib;
    inherit pkgs;
  };
  zen = mkNixPak {
    config =
      { sloth, ... }:
      {
        app.package = inputs.zen-browser.result.packages.${pkgs.system}.default;
        app.extraEntrypoints = [
          "/bin/zen"
          "/bin/zen-beta"
        ];
        flatpak.appId = "app.zen_browser.zen";
        etc.sslCertificates.enable = true;
        fonts = {
          enable = true;
          fonts = config.fonts.packages;
        };
        gpu.enable = true;
        locale.enable = true;
        dbus.policies = {
          "org.mozilla.*" = "own";
          "org.mpris.MediaPlayer2.firefox.*" = "own";
          "org.freedesktop.DBus" = "talk";
          "org.freedesktop.DBus.*" = "talk";
          "org.freedesktop.Notifications" = "talk";
          "org.freedesktop.ScreenSaver" = "talk";
          "org.freedesktop.portal" = "talk";
          "org.freedesktop.portal.*" = "talk";
          "org.freedesktop.NetworkManager" = "talk";
          "org.freedesktop.FileManager1" = "talk";
          "org.freedesktop.UPower" = "talk";
        };

        bubblewrap = {
          network = true;
          sockets = {
            wayland = true;
            pulse = true;
          };
          bind.rw = [
            (sloth.concat' sloth.xdgCacheHome "/fontconfig")
            (sloth.concat' sloth.homeDir "/.zen")
            (sloth.concat' sloth.runtimeDir "/bus")
            (sloth.concat' sloth.runtimeDir "/dconf")
            (sloth.concat' sloth.runtimeDir "/doc")
          ];
          bind.ro =
            let
              themingPaths = [
                (sloth.concat' sloth.homeDir ".nix-profile/share/themes")
                (sloth.concat' sloth.homeDir ".nix-profile/share/icons")
                "/run/current-system/sw/share/themes"
                "/run/current-system/sw/share/icons"
              ];
            in
            [
              "/etc/localtime"
              (sloth.concat' sloth.xdgConfigHome "/gtk-2.0")
              (sloth.concat' sloth.xdgConfigHome "/gtk-3.0")
              (sloth.concat' sloth.xdgConfigHome "/gtk-4.0")
              (sloth.concat' sloth.xdgConfigHome "/dconf")
              [
                "${inputs.zen-browser.result.packages.${pkgs.system}.default}/lib/firefox"
                "/app/etc/firefox"
              ]
            ]
            ++ themingPaths;
        };
      };
  };

in
{
  options.programs.zen.enable = mylib.mkEnabledIf "workstation";
  config.home = lib.mkIf config.programs.zen.enable {
    programs.zen-browser.enable = true;
    home.sessionVariables.BROWSER = "zen";
  };
}
