{ den, inputs, ... }:
{
  # Some preferred defaults
  den.default = {
    nixos =
      { pkgs, lib, ... }:
      {
        imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
        environment = {
          binsh = "${pkgs.dash}/bin/dash";
          defaultPackages = lib.mkForce [ ];
        };
        documentation.doc.enable = false;
        documentation.info.enable = false;
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.supportedLocales = [ "all" ];
        services.dbus.implementation = "broker";
        system.rebuild.enableNg = true;
        system.stateVersion = "22.05";
        time.timeZone = "America/New_York";
        zramSwap.enable = true;
        home-manager.useUserPackages = true;
        home-manager.useGlobalPkgs = true;
      };
    homeManager = {
      programs.home-manager.enable = true;
      home = {
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
        stateVersion = "22.05";
      };
    };
    includes = [
      den.provides.home-manager
      den.provides.define-user
    ];
  };
}
