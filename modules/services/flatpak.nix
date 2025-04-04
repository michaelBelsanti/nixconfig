{
  unify,
  host,
  ...
}:
unify.module {
  name = "services.flatpak";
  options = unify.singleEnableOption host.isWorkstation;
  nixos.ifEnabled = {
    appstream.enable = true;
    services.flatpak.enable = true;
  };
}
