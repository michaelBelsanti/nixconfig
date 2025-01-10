{
  lib,
  ...
}:
_self: super:
lib.custom.infuse super {
  bottles.__input.removeWarningPopup.__assign = true;
}
