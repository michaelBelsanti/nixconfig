{ stdenvNoCC, fetchFromGitHub }:
stdenvNoCC.mkDerivation {
  pname = "framework-grub-theme";
  version = "unstable-2022-07-23";

  src = fetchFromGitHub {
    owner = "HeinrichZurHorstMeyer";
    repo = "Framework-Grub-Theme";
    rev = "b2666b1c85d58a5b7768e4f13e73770b196e85bd";
    sparseCheckout = [ "Framework" ];
    sha256 = "sha256-P3W4rkp/LAnJtfFnHxtAtYlUmkavR2Dy1HYmT+jZjW4=";
  };

  installPhase = ''
    mkdir $out
    cp Framework/* $out
  '';
}

