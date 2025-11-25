{ den, inputs, ... }:
{
  # Some preferred defaults
  den.default = {
    includes = [
      den.provides.home-manager
      den.provides.define-user
      (
        { host, ... }:
        {
          ${host.class}.networking.hostName = host.name;
        }
      )
    ];

    nixos =
      { pkgs, lib, ... }:
      {
        imports = with inputs; [
          nixos-facter-modules.nixosModules.facter
          srvos.nixosModules.desktop
          srvos.nixosModules.mixins-systemd-boot
        ];

        environment = {
          binsh = "${pkgs.dash}/bin/dash";
          defaultPackages = lib.mkForce [ ];
        };
        services.avahi.enable = false; # in favor of srvos mdns config
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
  };
}
