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
    shellAliases = {
      ls = "exa -al";
      lt = "exa -aT";
      cat = "bat";
      fm = "clifm .";
      cleanup = "doas nix-collect-garbage -d";
      open = "xdg-open";
    };
    prezto = {
      enable = true;
      pmodules = [ "archive" "autosuggestions" "git" "ssh" "syntax-highlighting" "environment" "terminal" "editor" "history" "directory" "spectrum" "utility" "prompt" ];
      prompt.theme = "smiley";
    };
    plugins = [
      #                  Broken
      # { 
      #   name = "fzf-tab"; 
      #   file = "fzf-tab.plugin.zsh";
      #   src = pkgs.fetchFromGitHub { 
      #     owner = "Aloxaf"; 
      #     repo = "fzf-tab";
      #     rev = "938eef72e93ddb0609205a663bf0783f4e1b5fae";
      #     sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      #   };
      # }
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
}