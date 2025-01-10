{
  delib,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
in
delib.module {
  name = "gaming.replays";
  options.gaming.replays = with delib; {
    enable = boolOption false;
    portal = boolOption false;
    screen = noDefault (strOption null);
  };
  # Allows gpu-screen-recorder to record screens without escalating
  nixos.ifEnabled.security.wrappers.gsr-kms-server = {
    source = getExe' pkgs.gpu-screen-recorder "gsr-kms-server";
    capabilities = "cap_sys_admin+ep";
    owner = "root";
    group = "root";
  };
  home.ifEnabled = {cfg, ...}: {
    systemd.user.services.gpu-screen-recorder-replay = mkIf cfg.enable {
      # Save a video using `killall -SIGUSR1 gpu-screen-recorder` (or any other way to send a SIGUSR1 signal to gpu-screen-recorder)
      Unit.Description = "gpu-screen-recorder replay service";
      Install.WantedBy = [ "graphical-session.target" ];
      Service =
        let
          w = if cfg.portal then "portal" else cfg.screen;
        in
        {
          ExecStartPre = "/usr/bin/env mkdir -p %h/Videos/Replays";
          ExecStart = "${getExe pkgs.gpu-screen-recorder} -w ${w} -f 60 -r 60 -a 'default_output|default_input' -c mp4 -q very_high -o %h/Videos/Replays -restore-portal-session yes -v no";
        };
    };
  };
}
