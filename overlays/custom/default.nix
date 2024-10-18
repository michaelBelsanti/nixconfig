{
  helix,
  nix-gaming,
  plasma-manager,
  nix-alien,
  hypr-contrib,
  spicetify,
  # wezterm,
  zen-browser,
  ...
}:
_self: super: {
  inherit (helix.packages.${super.system}) helix;
  inherit (plasma-manager.packages.${super.system}) rc2nix;
  inherit (nix-alien.packages.${super.system}) nix-alien;
  inherit (hypr-contrib.packages.${super.system}) grimblast;
  zen-browser = zen-browser.packages.${super.system}.specific;
  # wezterm = wezterm.packages.${super.system}.default;
  gaming = nix-gaming.packages.${super.system};
  spicePkgs = spicetify.packages.${super.system}.default;
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
}
