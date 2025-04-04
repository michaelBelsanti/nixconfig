{ unify, ... }:
unify.module {
  name = "rices";

  options =
    with unify;
    let
      rice = {
        options = riceSubmoduleOptions;
      };
    in
    {
      rice = riceOption rice;
      rices = ricesOption rice;
    };

  home.always =
    { myconfig, ... }:
    {
      assertions = unify.riceNamesAssertions myconfig.rices;
    };
}
