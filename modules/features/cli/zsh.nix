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
              cat = "bat";
              du = "dust";
              ps = "procs";
              grep = "rg";
              find = "fd";

              sudo = "sudo ";
              ff = "fastfetch -l NixOS_old";
              vim = "nix run github:KodNova/NeovimConfig-nfv";

              nc = "/repos/NixOS-KodNovaOS";
              fleet = "vim /repos/NixOS-KodNovaOS/modules/fleet.nix";
              keep = "vim /repos/NixOS-KodNovaOS/modules/persist.nix";
              firewall = "vim /repos/NixOS-KodNovaOS/modules/features/security.nix";
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
          luna = "ssh 100.78.244.126";
        };
      };
    };

    lunaModule = _: {
      my.home = {
        programs.zsh.shellAliases = {
          batt-full = "echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold";
          batt-limit = "echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold";
        };
      };
    };

    workstation = _: {
      my.home = {
        programs.zsh.shellAliases = {
          odin = "/repos/odin/";
          repo = "/repos";
          H = "start-hyprland";

          zpm = "ssh 100.72.122.3";
          xavier = "ssh bobj@100.95.133.66";

          dev = "nix develop --command zsh";
        };
      };
    };
  };
}
