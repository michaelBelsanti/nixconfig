{
  unify.nixos =
    { pkgs, homeConfig, ... }:
    {
      environment = {
        binsh = "${pkgs.dash}/bin/dash";
        # fixes some issues, mainly root $PATH
        systemPackages = homeConfig.home.packages;
      };
      zramSwap.enable = true;
      time.timeZone = "America/New_York";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.supportedLocales = [ "all" ];
    };
}
