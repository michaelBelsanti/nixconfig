{
  delib,
  pkgs,
  config,
  lib,
  constants,
  ...
}:
delib.module {
  name = "programs.shells.zsh";
  options.programs.shells.zsh = with delib; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      programs.zsh.enable = true;
      users.users.${constants.username}.shell = lib.mkIf cfg.default pkgs.zsh;
    };
  home.ifEnabled =

    {
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;
          defaultKeymap = "emacs";
          dotDir = ".config/zsh/";
          history = {
            path = "${config.xdg.configHome}/zsh/history";
            size = 10000;
            share = true;
            ignoreSpace = true;
            expireDuplicatesFirst = true;
          };
          shellAliases = {
            nix = "noglob nix";
            nixos-rebuild = "noglob nixos-rebuild";
          };
          initExtraBeforeCompInit = ''
            export ZINIT_HOME="${constants.dataHome}/zinit/"
            if [ ! -d "$ZINIT_HOME" ]; then
               mkdir -p "$(dirname $ZINIT_HOME)"
            fi
            source ${pkgs.zinit}/share/zinit/zinit.zsh

            zinit light zsh-users/zsh-completions
            zinit light Aloxaf/fzf-tab

            # oh my zsh snippets
            zinit snippet OMZP::git
            zinit snippet OMZP::sudo
            zinit snippet OMZP::archlinux
            zinit snippet OMZP::aws
            zinit snippet OMZP::kubectl
            zinit snippet OMZP::kubectx
            zinit snippet OMZP::command-not-found
          '';
          # NOTE escaped character in list-colors
          initExtra = ''
            # Completion styling
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
            zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
            zstyle ':completion:*' menu no
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
            zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
          '';
        };
      };
    };
}
