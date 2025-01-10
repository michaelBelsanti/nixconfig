{delib, ...}:
delib.module {
  name = "constants";

  options.constants = let
    user = "quasi";
  in with delib; {
    username = readOnly (strOption user);
    configHome = readOnly (strOption "/home/${user}/.config");
    cacheHome = readOnly (strOption "/home/${user}/.cache");
    dataHome = readOnly (strOption "/home/${user}/.local/share");
  };
}
