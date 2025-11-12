{
  den.aspects.apps._.distrobox.homeManager.programs = {
    distrobox.enable = true;
    distrobox.enableSystemdUnit = false;
    nushell = {
      extraConfig = ''
        use std/util "path add"

        if "DISTROBOX_ENTER_PATH" in $env {
          path add "/usr/local/sbin"
          path add "/usr/local/bin"
          path add "/usr/sbin"
          path add "/usr/bin"
          path add "/sbin"
          path add "/bin"
        }
      '';
    };
  };
}
