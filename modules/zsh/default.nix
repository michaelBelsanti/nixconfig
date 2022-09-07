{ config, pkgs, ...}:
{
  programs.bash.historyFileSize = 0;
  programs.atuin.enable = false;
  programs.exa.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh/";
    envExtra = "PATH=$HOME/.local/bin:$PATH";
    initExtra = "nitch";
    shellAliases = {
      ls = "exa -al";
      lt = "exa -aT";
      cat = "bat";
      fm = "clifm";

      cleanup = "doas nix-collect-garbage";
    };
    prezto = {
      enable = true;
      pmodules = [ "archive" "autosuggestions" "git" "ssh" "syntax-highlighting" "environment" "terminal" "editor" "history" "directory" "spectrum" "utility" "prompt" ];
      prompt.theme = "smiley";
    };
    # zplug = {
    #   enable = true;
    #   # zplugHome = ~/.config/zsh;
    #   plugins = [
    #     { name = "Aloxaf/fzf-tab"; }
    #   ];
    # };
  };
}
