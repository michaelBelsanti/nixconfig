{ pkgs, inputs, ... }: {
  # Enable flakes
  nix = {
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "quasi" "michaelbelsanti" ];
      substituters = [
        # "https://quasigod.cachix.org"
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "quasigod.cachix.org-1:z+auA/0uS8vy6DDtUZhRQagZvVdl5WYnE/7lveoM3Do="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
    # Enable flakes and prevent shells from being garbage collected
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      options = "-d";
    };
  };
}
