{ ... }: {
  imports =
    [ ../home.nix ../../modules/hyprland/config ../../modules/shell/laptop ];
  home.file = { };
}
