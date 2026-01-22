{ inputs, ... }:
{
  styx.apps._.gui.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        libreoffice
        hunspell
        hunspellDicts.en_US-large
        remmina
        (bottles.override { removeWarningPopup = true; })
        varia
        proton-pass
        element-desktop
        obsidian
        orca-slicer
        freecad
        gearlever
        dino
        ungoogled-chromium
        (pkgs.discord.override {
          withOpenASAR = true;
          enableAutoscroll = true;
          withMoonlight = true;
          moonlight = inputs.moonlight.packages.${pkgs.stdenv.hostPlatform.system}.default;
        })
      ];
    };
}
