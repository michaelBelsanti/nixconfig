{
  styx.shell.homeManager =
    { pkgs, config, ... }:
    {
      programs = {
        bash = {
          enable = true;
          enableVteIntegration = true;
          historyFile = "${config.xdg.configHome}/bash/history";
        };
        starship = {
          enable = true;
          settings = {
            format = "$all";
            character = {
              success_symbol = "[➜](bold green)";
              error_symbol = "[➜](maroon)";
            };
            shell.disabled = false;
            jobs.disabled = true; # TODO atuin creates a job during the prompt closure and the symbol_threshold option is bugged
            # Jujutsu - https://github.com/jj-vcs/jj/wiki/Starship
            custom.jj = {
              command = ''
                jj log --revisions @ --limit 1 --ignore-working-copy --no-graph --color always  --template '
                  separate(" ",
                    bookmarks.map(|x| truncate_end(10, x.name(), "…")).join(" "),
                    tags.map(|x| truncate_end(10, x.name(), "…")).join(" "),
                    surround("\"", "\"", truncate_end(24, description.first_line(), "…")),
                    if(conflict, "conflict"),
                    if(divergent, "divergent"),
                    if(hidden, styx, "hidden"),
                  )
                '
              '';
              when = "jj --ignore-working-copy root";
              symbol = "jj ";
            };
            custom.jjstate = {
              command = ''
                jj log -r@ -n1 --ignore-working-copy --no-graph -T "" --stat | tail -n1 | sd "(\d+) files? changed, (\d+) insertions?\(\+\), (\d+) deletions?\(-\)" ' ''\${1}m ''\${2}+ ''\${3}-' | sd " 0." ""
              '';
              when = "jj --ignore-working-copy root";
            };
            git_branch.disabled = true;
            git_commit.disabled = true;
            git_state.disabled = true;
            git_metrics.disabled = true;
            git_status.disabled = true;
          };
        };
        atuin = {
          enable = true;
          flags = [ "--disable-up-arrow" ];
        };
        bat = {
          enable = true;
          config.style = "plain";
          extraPackages = with pkgs.bat-extras; [
            prettybat
            batwatch
            batpipe
            batman
            # batgrep
            batdiff
          ];
        };
        bottom.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        eza = {
          enable = true;
          git = true;
          icons = "auto";
          enableNushellIntegration = false;
        };
        nix-your-shell.enable = true;
        skim.enable = true;
        tealdeer = {
          enable = true;
          settings.updates.auto_update = true;
        };
        yazi.enable = true;
        zoxide.enable = true;
      };
    };
}
