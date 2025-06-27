{ lib, ... }:
{
  args.sources = import ./_sources/generated.nix {
    inherit (lib)
      fetchgit
      fetchurl
      fetchFromGitHub
      dockerTools
      ;
  };
}
