{
  delib,
  pkgs,
  inputs,
  config,
  ...
}:
delib.module {
  name = "gaming.chaotic";
  options = delib.singleEnableOption config.myconfig.gaming.enable;
  nixos.always.imports = [ inputs.chaotic.nixosModules.default ];
  nixos.ifEnabled = {
    nixpkgs.overlays = [
      (_: super: {
        lutris = super.lutris.override {
          extraLibraries = pkgs: [ pkgs.latencyflex-vulkan ];
        };
      })
    ];
    chaotic.nyx.overlay.enable = true;
    environment.systemPackages = with pkgs; [
      latencyflex-vulkan
    ];
    programs.steam.extraPackages = with pkgs; [ latencyflex-vulkan ];
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
  };
}
