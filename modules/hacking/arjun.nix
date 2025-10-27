{
  perSystem =
    { pkgs, ... }:
    {
      packages.arjun = pkgs.arjun.overrideAttrs {
        version = "0-unstable-2025-02-20";
        src = pkgs.fetchFromGitHub {
          owner = "s0md3v";
          repo = "Arjun";
          rev = "d1fb995cb1e064d4e171d83f19f6af79b0a3c5ce";
          hash = "sha256-z6YGCwypp69+98KSC1YUzJETfwb3V4Qp1sV5V3N9zMI=";
        };
      };
    };
}
