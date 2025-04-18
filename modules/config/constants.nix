{ delib, homeManagerUser, ... }:
delib.module {
  name = "constants";

  options.constants =
    let
      user = homeManagerUser;
    in
    with delib;
    {
      username = readOnly (strOption user);
      home = readOnly (strOption "/home/${user}");
      configHome = readOnly (strOption "/home/${user}/.config");
      cacheHome = readOnly (strOption "/home/${user}/.cache");
      dataHome = readOnly (strOption "/home/${user}/.local/share");
      stateHome = readOnly (strOption "/home/${user}/.local/state");
      flakePath = readOnly (strOption "/home/${user}/.flake");
    };

  myconfig.always =
    { cfg, ... }:
    {
      args.shared.constants = cfg;
    };
}
