{ stdenvNoCC, fetchzip }:
stdenvNoCC.mkDerivation {
  pname = "latencyflex";
  version = "0.1.1";

  src = fetchzip {
    url =
      "https://github.com/ishitatsuyuki/LatencyFleX/releases/download/v0.1.1/latencyflex-v0.1.1.tar.xz";
    sha256 = "c/o0wcTZ8TJwLzUHlvmS/kcoOPlfCPHupWFABTVXtok=";
  };

  installPhase = ''
    mkdir -p $out/share $out/lib
    cp ./layer/usr/share/vulkan/implicit_layer.d/latencyflex.json $out/share
    cp ./layer/usr/lib/x86_64-linux-gnu/liblatencyflex_layer.so $out/lib
  '';
}
