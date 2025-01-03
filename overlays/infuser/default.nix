{
  lib,
  ...
}:
let
 gsr-version = "5.0.0";
in
_self: super: lib.custom.infuse super {
  gpu-screen-recorder.__output.version.__assign = gsr-version;
  gpu-screen-recorder.__output.src.__assign = super.fetchurl {
    url = "https://dec05eba.com/snapshot/gpu-screen-recorder.git.${gsr-version}.tar.gz";
    hash = "sha256-w1dtFLSY71UileoF4b1QLKIHYWPE5c2KmsHyRPtn+sA=";
  };

  gpu-screen-recorder-gtk.__output.version.__assign = gsr-version;
  gpu-screen-recorder-gtk.__output.src.__assign = super.fetchurl {
    url = "https://dec05eba.com/snapshot/gpu-screen-recorder-gtk.git.${gsr-version}.tar.gz";
    hash = "sha256-uXbiuA1XPWZVwQGLh47rKzCZSEUEPWqYALqMuCGA7do=";
  };
}
