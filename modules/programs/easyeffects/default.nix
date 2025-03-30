{ delib, host, ... }:
delib.module {
  name = "programs.easyeffects";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled.services.easyeffects = {
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
}
