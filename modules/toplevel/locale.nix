{ delib, ... }:
delib.module {
  name = "locale";
  nixos.always = {
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = [ "all" ];
  };
}
