{ config, pkgs, flakePath, ... }: {
  programs = {
    zsh = {
      enable = false;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh/";
      history = {
        path = "${config.xdg.configHome}/zsh/history";
        size = 10000;
        expireDuplicatesFirst = true;
      };
      shellAliases = {
        nixup =
          "doas nixos-rebuild switch --flake ${flakePath} && source ~/.config/zsh/.zshrc";
        nixUp =
          "nix flake update ${flakePath} && doas nixos-rebuild switch --flake ${flakePath} && source ~/.config/zsh/.zshrc";

        ls = "exa -al";
        lt = "exa -aT";
        cat = "bat";
        cleanup = "doas nix-collect-garbage -d";
        fm = "clifm .";
        lg = "lazygit";
        open = "xdg-open";
        nix = "noglob nix";
        nixos-rebuild = "noglob nixos-rebuild";
      };
      prezto = {
        enable = true;
        pmodules = [
          "archive"
          "autosuggestions"
          "git"
          "ssh"
          "syntax-highlighting"
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "prompt"
        ];
        prompt.theme = "smiley";
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];
    };
  };
}
