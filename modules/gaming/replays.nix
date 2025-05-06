{
  lib,
  config,
  ...
}:
{
  unify.modules.replays = {
    # Allows gpu-screen-recorder to record screens without escalating
    nixos =
      { pkgs, ... }:
      {
        security.wrappers.gsr-kms-server = {
          source = lib.getExe' pkgs.gpu-screen-recorder "gsr-kms-server";
          capabilities = "cap_sys_admin+ep";
          owner = "root";
          group = "root";
        };
      };
    home =
      { pkgs, hostConfig, ... }:
      {
        systemd.user.services.gpu-screen-recorder-replay = {
          # Save a video using `killall -SIGUSR1 gpu-screen-recorder` (or any other way to send a SIGUSR1 signal to gpu-screen-recorder)
          Unit.Description = "gpu-screen-recorder replay service";
          Install.WantedBy = [ "graphical-session.target" ];
          Service = {
            ExecStart = "${lib.getExe pkgs.gpu-screen-recorder} -w ${
              config.unify.hosts.${hostConfig.name}.primaryDisplay.name
            } -f 60 -r 60 -a 'default_output|default_input' -c mp4 -q very_high -o %h/Videos/Replays -restore-portal-session yes -v no";
          };
        };
      };
  };
}
