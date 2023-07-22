inputs: _self: super: {
  inherit (inputs.helix.packages.${super.system}) helix;
  inherit (inputs.devenv.packages.${super.system}) devenv;
  inherit (inputs.nix-gaming.packages.${super.system}) wine-ge;
  inherit (inputs.nix-gaming.packages.${super.system}) osu-lazer-bin;
  inherit (inputs.plasma-manager.packages.${super.system}) rc2nix;
  inherit (inputs.nix-alien.packages.${super.system}) nix-alien;
  inherit (inputs.hypr-contrib.packages.${super.system}) grimblast;
  spicePkgs = inputs.spicetify.packages.${super.system}.default;
  discord-canary = super.discord-canary.override {
    nss = super.nss_latest;
    withOpenASAR = true;
    withVencord = true;
  };
  helix-desktop = super.makeDesktopItem {
    name = "helix";
    desktopName = "Helix (TUI)";
    genericName = "Helix";
    exec = "hx %F";
    mimeTypes = ["text/plain" "inode/directory"];
    categories = ["Utility" "TextEditor" "Development"];
    terminal = true;
  };
  rosepine-wallpaper = super.fetchurl {
    url = "https://raw.githubusercontent.com/rose-pine/wallpapers/main/flower.jpg";
    hash = "sha256-A83dUw3QT7GpWGSV+JY7F+kU38CNk5uQrzFwyL5yFdE=";
  };
}
