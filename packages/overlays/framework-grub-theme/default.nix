{ stdenvNoCC, fetchFromGitHub }:
stdenvNoCC.mkDerivation {
  pname = "framework-grub-theme";
  version = "unstable-2022-07-23";

  src = fetchFromGitHub {
    owner = "HeinrichZurHorstMeyer";
    repo = "Framework-Grub-Theme";
    rev = "b2666b1c85d58a5b7768e4f13e73770b196e85bd";
    sparseCheckout = [ "Framework" ];
    sha256 = "sha256-7ZOF5BV++XdTJ3xf4xh/4sZ2cLdm3vB1+KT+azYsvIs=";
  };

  installPhase = ''
    mkdir $out
    cp Framework/* $out
  '';
}

