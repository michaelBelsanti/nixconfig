inputs: _: super: {
  discord = super.discord.override {
    nss = super.nss_latest;
    withOpenASAR = true;
  };
  helix-desktop = super.makeDesktopItem {
    name = "helix";
    desktopName = "Helix (TUI)";
    genericName = "Helix";
    exec = "wezterm start hx %F";
    mimeTypes = [ "text/plain" "inode/directory" ];
    categories = [ "Utility" "TextEditor" "Development" ];
  };
  latencyflex = super.callPackage ./latencyflex { };
  protonup-qt = super.callPackage ./protonup-qt { };
  catppuccin-kde = super.callPackage ./catppuccin-kde { };
  regreet = super.callPackage ./greetd/regreet { };
  framework-grub-theme = super.callPackage ./framework-grub-theme { };
}
