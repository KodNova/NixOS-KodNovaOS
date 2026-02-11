_: {
  flake.nixosModules.base = _: {
    programs.zsh.enable = true;

    my.home = {
      programs.zsh = {
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
  flake.nixosModules.solModule = _: {
    my.home = {
      programs.zsh = {
        shellAliases = {
          zpm = "ssh 100.72.122.3";
          puddlejumper = "ssh 100.78.244.126";
        };
      };
    };
  };
}
