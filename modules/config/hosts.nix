{ delib, lib, ... }:
delib.module {
  name = "hosts";

  options =
    with delib;
    let
      host =
        { config, ... }:
        {
          options = hostSubmoduleOptions // {
            type = noDefault (enumOption [ "desktop" "laptop" "server" ] null);

            isDesktop = boolOption (config.type == "desktop");
            isLaptop = boolOption (config.type == "laptop");
            isServer = boolOption (config.type == "server");
            hasGUI = boolOption (config.type == "laptop" || config.type == "desktop");
            isWorkstation = boolOption (config.type == "laptop" || config.type == "desktop");
            primaryDisplay =
              attrsOption
                (builtins.head (lib.attrsToList (lib.filterAttrs (_: v: v.primary) config.displays))).value;

            displays = attrsOfOption (submodule (
              { name, ... }:
              {
                options = {
                  enable = boolOption true;
                  touchscreen = boolOption false;

                  name = strOption name;
                  primary = boolOption (builtins.length (lib.attrNames config.displays) == 1);
                  refreshRate = intOption 60;

                  width = intOption 1920;
                  height = intOption 1080;
                  x = intOption 0;
                  y = intOption 0;
                  scaling = floatOption 1.0;
                  roundScaling = intOption (builtins.ceil config.displays."${name}".scaling);
                };
              }
            )) { };
          };
        };
    in
    {
      host = hostOption host;
      hosts = hostsOption host;
    };

  myconfig.always =
    { myconfig, ... }:
    {
      args.shared = {
        inherit (myconfig) host hosts;
      };
    };

  home.always =
    { myconfig, ... }:
    {
      assertions =
        delib.hostNamesAssertions myconfig.hosts
        ++ lib.singleton {
          assertion =
            builtins.length (lib.attrsToList (lib.filterAttrs (_: v: v.primary) myconfig.host.displays)) <= 1;
          message = "Only one display may be set as primary.";
        };
    };
}
