inputs: _self: super: {
  inherit (inputs.helix.packages.${super.system}) helix;
  inherit (inputs.devenv.packages.${super.system}) devenv;
  inherit (inputs.nix-gaming.packages.${super.system}) wine-ge;
  inherit (inputs.nix-gaming.packages.${super.system}) osu-lazer-bin;
  inherit (inputs.plasma-manager.packages.${super.system}) rc2nix;
  inherit (inputs.nix-alien.packages.${super.system}) nix-alien;
  inherit (inputs.hypr-contrib.packages.${super.system}) grimblast;
  inherit (inputs.ssbm.packages.${super.system}) slippi-netplay;
  inherit (inputs.ssbm.packages.${super.system}) slippi-playback;
  spicePkgs = inputs.spicetify.packages.${super.system}.default;
  discord = super.discord.override {
    # nss = super.nss_latest;
    withOpenASAR = true;
    withVencord = true;
  };
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
  rosepine-grub-theme = super.fetchFromGitHub {
    owner = "rose-pine";
    repo = "grub";
    rev = "8976fd7cd4ed2890cc4a324291bbac2813906f80";
    hash = "sha256-tUg0hCeSX6tFUZK3pp83UILSY0c71+dWbW93dL44Yc4=";
  };
  slippi-launcher = super.appimageTools.wrapType2 rec {
    name = "slippi-launcher";
    version = "2.10.5";
    extraPkgs = pkgs: [
      pkgs.mpg123
      pkgs.libmpg123
    ];

    src = builtins.fetchurl {
      url = "https://github.com/project-slippi/slippi-launcher/releases/download/v${version}/Slippi-Launcher-${version}-x86_64.AppImage";
      sha256 = "0qvf7xh9mjjglyad8hm41r1rkpkysk1lnj7zwxrvni24piam536d";
    };
  };
}
