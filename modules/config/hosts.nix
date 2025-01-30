{ delib, ... }:
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

            displays = listOfOption (submodule {
              options = rec {
                enable = boolOption true;
                touchscreen = boolOption false;

                name = noDefault (strOption null);
                primary = boolOption (builtins.length config.displays == 1);
                refreshRate = intOption 60;

                width = intOption 1920;
                height = intOption 1080;
                x = intOption 0;
                y = intOption 0;
                scaling = floatOption 1;
                roundScaling = intOption builtins.ciel scaling;
              };
            }) [ ];
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
      assertions = delib.hostNamesAssertions myconfig.hosts;
    };
}
