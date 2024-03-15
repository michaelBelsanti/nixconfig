{ config, ... }:
{
  imports = [ ./hardware.nix ];

  home-manager.users.${config.users.mainUser} = {
    # imports = [ ./plasma-manager.nix ];
  };

  # Custom options
  gaming.enable = true;
  # desktop.plasma.enable = true;
  # desktop.gnome.enable = true;
  desktop.hyprland.enable = true;

  networking = {
    hostName = "hades";
    # preferred for a wired connection
    useNetworkd = true;
    firewall = {
      enable = false;
      allowedUDPPorts = [
        3074 # BO2
        24872 # Yuzu
      ];
    };
  };

  # Display shiz
  services = {
    pipewire.lowLatency.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager.sddm.enable = true;
      libinput.mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
    };
    openssh = {
      enable = true;
      ports = [ 42069 ];
      settings.PasswordAuthentication = false;
    };
  };

  hardware = {
    keyboard.qmk.enable = true;
  };

  environment = {
    sessionVariables = {
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
