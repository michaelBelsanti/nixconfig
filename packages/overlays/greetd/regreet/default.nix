{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, glib
, gdk-pixbuf
, pango
, graphene
, gtk4
}:

rustPlatform.buildRustPackage rec {
  pname = "regreet";
  version = "2023-02-25";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ glib gdk-pixbuf pango graphene gtk4 ];

  src = fetchFromGitHub {
    owner = "rharish101";
    repo = pname;
    rev = "46de96b193fa9495f5ddd31ac4a7708951cf9393";
    sha256 = "peN09mItAesP3GjdWWU/xicIDJGt1mxpAMEXPWm2kEo=";
  };

  cargoSha256 = "vSTsZ30ViRXb5p1GyqKiTC+KnQ7LJrzHJtzAeCD1BSQ=";

  meta = with lib; {
    description = "Clean and customizable greeter for greetd";
    homepage = "https://github.com/rharish101/ReGreet";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ michaelBelsanti];
    platforms = platforms.linux;
  };
}
