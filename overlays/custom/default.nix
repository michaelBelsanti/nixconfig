{
  helix,
  nix-gaming,
  plasma-manager,
  nix-alien,
  hypr-contrib,
  zen-browser,
  ...
}:
_self: super: {
  inherit (helix.packages.${super.system}) helix;
  inherit (plasma-manager.packages.${super.system}) rc2nix;
  inherit (nix-alien.packages.${super.system}) nix-alien;
  inherit (hypr-contrib.packages.${super.system}) grimblast;
  inherit (zen-browser.packages.${super.system}) zen-browser;
  gaming = nix-gaming.packages.${super.system};
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
  gpu-screen-recorder = super.gpu-screen-recorder.overrideAttrs rec {
    version = "5.0.0";
    src = super.fetchurl {
      url = "https://dec05eba.com/snapshot/gpu-screen-recorder.git.${version}.tar.gz";
      hash = "sha256-w1dtFLSY71UileoF4b1QLKIHYWPE5c2KmsHyRPtn+sA=";
    };
  };
  gpu-screen-recorder-gtk = super.gpu-screen-recorder-gtk.overrideAttrs rec {
    version = "5.0.0";
    src = super.fetchurl {
      url = "https://dec05eba.com/snapshot/gpu-screen-recorder-gtk.git.${version}.tar.gz";
      hash = "sha256-uXbiuA1XPWZVwQGLh47rKzCZSEUEPWqYALqMuCGA7do=";
    };
  };
}
