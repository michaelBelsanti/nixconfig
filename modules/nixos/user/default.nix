{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.custom) mkOpt;
in
{
  options.users.mainUser = mkOpt types.str "quasi" "Main user for the system.";
}
