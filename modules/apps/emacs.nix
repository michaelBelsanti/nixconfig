{ inputs, ... }:
{
  styx.emacs.homeManager =
    { pkgs, ... }:
    let
      emacs = inputs.emacs-overlay.packages.${pkgs.stdenv.hostPlatform.system}.emacs-unstable-pgtk;
    in
    {
      services.emacs = {
        enable = true;
        client.enable = true;
        startWithUserSession = "graphical";
      };
      programs.emacs = {
        enable = true;
        package = emacs;
        extraPackages =
          # Only packages that should be installed globally
          epkgs: with epkgs; [
            treesit-grammars.with-all-grammars
            tree-sitter-langs
            jinx
            xeft
          ];
      };
      home.packages = with pkgs; [
        pandoc
        emacs-lsp-booster
      ];
    };
}
