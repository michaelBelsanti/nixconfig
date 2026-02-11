{
  styx.emacs.homeManager =
    { pkgs, ... }:
    {
      services.emacs = {
        enable = true;
        client.enable = true;
      };
      programs.emacs = {
        enable = true;
        extraPackages =
          # Only packages that should be installed globally
          epkgs: with epkgs; [
            treesit-grammars.with-all-grammars
            tree-sitter-langs
            jinx
          ];
      };
      home.packages = with pkgs; [
        pandoc
        emacs-lsp-booster
      ];
    };
}
