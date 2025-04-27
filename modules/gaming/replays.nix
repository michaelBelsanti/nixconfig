{
  lib,
  pkgs,
  mylib,
  config,
  ...
}:
let
  cfg = config.gaming.replays;
in
{
  options.gaming.replays = {
    enable = mylib.mkBool false;
    portal = mylib.mkBool false;
    screen = lib.mkOption {
      type = lib.types.str;
      default = null;
    };
  };
  # Allows gpu-screen-recorder to record screens without escalating
  config = lib.mkIf cfg.enable {
    nixos.security.wrappers.gsr-kms-server = {
      source = lib.getExe' pkgs.gpu-screen-recorder "gsr-kms-server";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
    };
    home = {
      systemd.user.services.gpu-screen-recorder-replay = lib.mkIf cfg.enable {
        # Save a video using `killall -SIGUSR1 gpu-screen-recorder` (or any other way to send a SIGUSR1 signal to gpu-screen-recorder)
        Unit.Description = "gpu-screen-recorder replay service";
        Install.WantedBy = [ "graphical-session.target" ];
        Service =
          let
            w = if cfg.portal then "portal" else cfg.screen;
          in
          {
            ExecStartPre = "/usr/bin/env mkdir -p %h/Videos/Replays";
            ExecStart = "${lib.getExe pkgs.gpu-screen-recorder} -w ${w} -f 60 -r 60 -a 'default_output|default_input' -c mp4 -q very_high -o %h/Videos/Replays -restore-portal-session yes -v no";
          };
      };
    };
  };
}
