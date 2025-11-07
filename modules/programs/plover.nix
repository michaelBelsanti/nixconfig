{ inputs, ... }:
{
  unify.modules.plover = {
    nixos =
      { hostConfig, ... }:
      {
        services.udev.extraRules = ''
          KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
        '';
        users.users.${hostConfig.primaryUser}.extraGroups = [
          "input"
          "dialout"
        ];
      };
    home =
      { pkgs, ... }:
      {
        imports = [ inputs.plover.homeManagerModules.plover ];
        programs.plover = {
          enable = true;
          package = inputs.plover.packages.${pkgs.stdenv.hostPlatform.system}.plover-full;
        };
      };
  };
}
