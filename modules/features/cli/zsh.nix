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

            history = {
              size = 10000;
              save = 10000;
              share = true;
              ignoreDups = true;
            };

            shellAliases = {
              cat = "bat";
              du = "dust";
              ps = "procs";
              grep = "rg";
              find = "fd";

              sudo = "sudo ";
              ff = "fastfetch -l NixOS_old";
              oldvim = "nix run github:KodNova/Neovim-nvf";
              vim = "nix run github:KodNova/Neovim-Nixvim";

              nc = "/repos/NixOS-KodNovaOS";
              fleet = "vim /repos/NixOS-KodNovaOS/modules/fleet.nix";
              keep = "vim /repos/NixOS-KodNovaOS/modules/persist.nix";
              myzsh = "vim /repos/NixOS-KodNovaOS/modules/features/cli/zsh.nix";
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
          luna = "ssh 100.89.237.14";
        };
      };
    };

    lunaModule = _: {
      my.home = {
        programs.zsh.shellAliases = {
          sol = "ssh 100.116.22.124";
          solway = "waypipe ssh -t -p 2222 100.116.22.124 zellij -l welcome";

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
          N = "niri";
          mpvhw = "mpv --hwdec=vaapi";

          #ssh
          zpm = "ssh 100.72.122.3";
          xavier = "ssh bobj@100.95.133.66";

          #vpn
          vpnca = "sudo tailscale up --exit-node=ca-mtr-wg-001.mullvad.ts.net";
          vpnsw = "sudo tailscale up --exit-node=se-got-wg-003.mullvad.ts.net";
          vpnus = "sudo tailscale up --exit-node=us-chi-wg-301.mullvad.ts.net";
          vpndown = "sudo tailscale up --exit-node=";

          dev = "nix develop --command zsh";
          pn = "pnpm";
        };
      };
    };
  };
}
