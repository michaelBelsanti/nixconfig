{ styx, inputs, ... }:
{
  styx.gaming = {
    provides.min =
      { host, ... }:
      {
        nixos =
          { pkgs, ... }:
          {
            boot.kernelModules = [ "ntsync" ];
            environment.systemPackages = with pkgs; [
              # Launchers
              cartridges
              heroic
              (lutris.override {
                extraPkgs = _: [ umu-launcher ];
                extraLibraries = _: [ latencyflex-vulkan ];
              })
              prismlauncher
              umu-launcher
            ];
            hardware.graphics.enable32Bit = true;
            programs = {
              steam = {
                enable = true;
                extraCompatPackages = with pkgs; [
                  proton-ge-bin
                  steamtinkerlaunch
                ];
              };
              gamescope = {
                enable = true;
                args = [
                  "-W ${toString host.primaryDisplay.width}"
                  "-H ${toString host.primaryDisplay.height}"
                  "-r ${toString host.primaryDisplay.refreshRate}"
                  "-O ${host.primaryDisplay.name}"
                  "-f"
                  "--adaptive-sync"
                  "--mangoapp"
                ];
              };
            };
          };
      };

    provides.max = {
      includes = [ styx.gaming._.replays ];
      nixos =
        { pkgs, ... }:
        {
          imports = [
            inputs.nix-gaming.nixosModules.platformOptimizations # TODO needed?
            inputs.chaotic.nixosModules.default
          ];
          hardware.opentabletdriver.enable = true;
          services = {
            input-remapper.enable = true;
            system76-scheduler.enable = true;
          };
          programs = {
            steam = {
              platformOptimizations.enable = true;
              remotePlay.openFirewall = true;
              localNetworkGameTransfers.openFirewall = true;
              extraPackages = [ pkgs.latencyflex-vulkan ];
            };
          };
          chaotic.nyx.overlay.enable = true;
          environment.systemPackages = with pkgs; [
            # Utility
            goverlay
            gpu-screen-recorder-gtk
            latencyflex-vulkan
            lsfg-vk
            lsfg-vk-ui
            ludusavi
            mangohud
            nexusmods-app
            protonplus
            protontricks
            r2modman
            winetricks
          ];
        };
    };

    provides.replays.homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = [ pkgs.gpu-screen-recorder ];
        systemd.user.services.gpu-screen-recorder = {
          # Save a video using `killall -SIGUSR1 gpu-screen-recorder` (or any other way to send a SIGUSR1 signal to gpu-screen-recorder)
          Unit.Description = "gpu-screen-recorder replay service";
          Install.WantedBy = [ "graphical-session.target" ];
          Service.ExecStart = "${lib.getExe pkgs.gpu-screen-recorder} -w portal -f 60 -r 60 -a 'default_output' -a 'default_input' -c mp4 -q high -o %h/Videos/Replays -restore-portal-session yes -v no";
        };
      };
  };
}
