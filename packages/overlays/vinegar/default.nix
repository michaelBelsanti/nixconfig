{ lib, buildGoModule, fetchFromGitHub, makeWrapper, wineWowPackages, gnutls }:
buildGoModule rec {
  pname = "vinegar";
  version = "1.0.1";

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ wineWowPackages.stable gnutls ];

  ldflags = [
    "-s" "-w"
    "-X main.Version=v${version}"
    "-X main.Commit=v${version}"
  ];

  postInstall = ''
    wrapProgram $out/bin/vinegar \
    --prefix PATH : ${lib.makeBinPath [wineWowPackages.stable]} \
    --set WINEARCH win64
  '';

  vendorHash = null;

  makeWrapperArgs = [
  ];

  src = fetchFromGitHub {
    owner = "vinegarhq";
    repo = "vinegar";
    rev = "v${version}";
    hash = "sha256-bu+B5zhC3HeXgw9CxDomhD/BfnUGHvqbDuOe4e4L27Y=";
  };
}
