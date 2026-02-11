_: {
  flake.nixosModules = {
    base = _: {
      programs.zsh.enable = true;

      my.home = {
        programs = {
          zsh = {
            enable = true;
            autocd = true;
            autosuggestion.enable = false;
            enableCompletion = true;
            syntaxHighlighting.enable = true;

            shellAliases = {
              ls = "eza --icons --group-directories-first";
              ll = "eza -l --icons --git --group-directories-first";
              la = "eza -la --icons --git --group-directories-first";
              cat = "bat";
              du = "dust";
              ps = "procs";
              grep = "rg";
              find = "fd";

              sudo = "sudo ";
              fastfetch = "fastfetch -l NixOS_old";
              vim = "nix run github:KodNova/NeovimConfig-nfv";
            };

            oh-my-zsh = {
              enable = true;
              plugins = ["git"];
            };
          };

          fzf = {
            enable = true;
            enableZshIntegration = true;
          };
        };
      };
    };

    solModule = _: {
      my.home = {
        programs.zsh.shellAliases = {
          zpm = "ssh 100.72.122.3";
          puddlejumper = "ssh 100.78.244.126";
        };
      };
    };

    workstation = _: {
      my.home = {
        programs.zsh.shellAliases = {
          odin = "/repos/odin/";
          repo = "/repos";
          H = "start-hyprland";

          xavier = "ssh bobj@100.95.133.66";

          olddev = "nix develop --command zsh";
          dev = "devbox shell";
        };
      };
    };
  };
}
