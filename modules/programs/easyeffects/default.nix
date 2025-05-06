{ lib, ... }:
{
  unify.modules.workstation.home = {
    systemd.user.services.easyeffects.Service.Restart = lib.mkForce "never";
    services.easyeffects = {
      enable = true;
      extraPresets =
        let
          presets = [
            "AKG K7XX"
            "Hifiman Edition XS"
            "Moondrop Starfield"
            "Nothing Ear (a)"
            "7RYMS"
            "Yeti"
          ];
          mkPresets =
            names:
            builtins.listToAttrs (
              map (name: {
                name = name;
                value = builtins.fromJSON (builtins.readFile (./presets + "/${name}.json"));
              }) names
            );
        in
        mkPresets presets;
    };
  };
}
