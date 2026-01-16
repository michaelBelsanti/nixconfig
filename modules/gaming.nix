{
  styx,
  inputs,
  den,
  ...
}:
{
  styx.gaming.provides = {
    min =
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
              lutris
              # (lutris.override {
              #   extraPkgs = _: [ umu-launcher ];
              # })
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
                  "-r ${toString host.primaryDisplay.refresh}"
                  "-O ${host.primaryDisplay.name}"
                  "-f"
                  "--adaptive-sync"
                  "--mangoapp"
                ];
              };
            };
          };
      };

    max = den.lib.parametric {
      includes = [
        styx.gaming._.replays
        styx.gaming._.min
      ];
      nixos =
        { pkgs, ... }:
        {
          imports = [
            inputs.nix-gaming.nixosModules.platformOptimizations
            inputs.nix-gaming.nixosModules.pipewireLowLatency
          ];
          hardware.opentabletdriver.enable = true;
          services = {
            input-remapper.enable = true;
            pipewire.lowLatency.enable = true;
          };
          programs = {
            steam = {
              platformOptimizations.enable = true;
              remotePlay.openFirewall = true;
              localNetworkGameTransfers.openFirewall = true;
            };
          };
          environment.systemPackages = with pkgs; [
            # Utility
            deadlock-mod-manager
            goverlay
            gpu-screen-recorder-gtk
            lsfg-vk
            lsfg-vk-ui
            ludusavi
            mangohud
            protonplus
            protontricks
            r2modman
            winetricks
          ];
        };
    };

    replays.homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = [ pkgs.gpu-screen-recorder ];
        systemd.user.services.gpu-screen-recorder = {
          # Save a video using `killall -SIGUSR1 gpu-screen-recorder` (or any other way to send a SIGUSR1 signal to gpu-screen-recorder)
          Unit.Description = "gpu-screen-recorder replay service";
          Install.WantedBy = [ "graphical-session.target" ];
          Service.ExecStart = "${lib.getExe pkgs.gpu-screen-recorder} -w portal -f 60 -r 60 -k av1 -a 'default_output' -a 'default_input' -c mp4 -q high -o %h/Videos/Replays -restore-portal-session yes -v no";
        };
      };
  };
}
