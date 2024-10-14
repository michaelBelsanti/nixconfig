{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.cosmic;
in
{
  options.desktop.cosmic.enable = mkBoolOpt false "Enable cosmic configuration.";
  config = mkIf cfg.enable {
    desktop.wayland.enable = true;
    # avoid bug with cosmic deleting gtk.css file
    snowfallorg.users.${config.users.mainUser}.home.config = {
      xdg.configFile."gtk-4.0/gtk.css".enable = false;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = 1;
    environment.systemPackages =
      (with pkgs; [
        pwvucontrol
        overskride
        loupe
        celluloid
        gnome-disk-utility
        peazip
      ])
      ++ (with inputs.nixos-cosmic.packages.${pkgs.system}; [
        chronos
        cosmic-ext-tweaks
        cosmic-ext-forecast
        cosmic-ext-tasks
        cosmic-ext-applet-emoji-selector
        cosmic-ext-applet-clipboard-manager
        cosmic-ext-calculator
        cosmic-ext-examine
      ]);
    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gtk2;
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      gnome.gnome-keyring.enable = true;
    };
    # workaround to avoid jank when copying from terminal
    environment.variables.COSMIC_DATA_CONTROL_ENABLED = 1;
    home-manager.users.${config.users.mainUser} = {
      gtk.iconTheme = {
        name = "Cosmic";
        package = pkgs.cosmic-icons;
      };
    };
    nixpkgs.overlays = [
      (final: prev: {
        cosmic-comp = prev.cosmic-comp.overrideAttrs (prevAttrs: {
          patches = (prevAttrs.patches or [ ]) ++ [
            (pkgs.writeText "cosmic-comp-disable-direct-scanout.patch" ''
              diff --git a/src/backend/kms/surface/mod.rs b/src/backend/kms/surface/mod.rs
              index d0cfb8d..32aaf4a 100644
              --- a/src/backend/kms/surface/mod.rs
              +++ b/src/backend/kms/surface/mod.rs
              @@ -624,7 +624,8 @@ impl SurfaceThreadState {
                           cursor_size,
                           Some(gbm),
                       ) {
              -            Ok(compositor) => {
              +            Ok(mut compositor) => {
              +                compositor.use_direct_scanout(false);
                               self.active.store(true, Ordering::SeqCst);
                               self.compositor = Some(compositor);
                               Ok(())
            '')
          ];
        });
      })
    ];
  };
}
