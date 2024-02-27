{lib, ...}:
with lib;
with lib.custom; {
  options.users.mainUser = mkOpt types.str "quasi" "Main user for the system.";
}
