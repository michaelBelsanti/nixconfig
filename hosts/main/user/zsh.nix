pkgs: {
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  enableSyntaxHighlighting = true;
  autocd = true;
  defaultKeymap = "emacs";
  dotDir = ".config/zsh/";
  shellAliases = {
    ls = "exa -al";
    nixup = "doas nixos-rebuild switch --flake '/home/quasi/.flake/#framework' && source ~/.config/zsh/.zshrc";
    nixUp = "nix flake update --recreate-lock-file && doas nixos-rebuild switch --flake '/home/quasi/.flake/#framework' && source ~/.config/zsh/.zshrc";
    dotconfig = "hx ~/.flake/user/quasi/";
    nixconfig = "hx ~/.flake/system";
    nix = "noglob nix";
  };
  prezto = {
    enable = true;
    pmodules = [ "archive" "autosuggestions" "git" "ssh" "syntax-highlighting" "environment" "terminal" "editor" "history" "directory" "spectrum" "utility" "completion" "prompt" ];
    prompt.theme = "smiley";
  };
}
