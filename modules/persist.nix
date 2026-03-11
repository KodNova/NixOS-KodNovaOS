_: {
  flake.nixosModules = {
    workstation = {config, ...}: {
      environment.persistence."/persist" = {
        hideMounts = false;
        directories = [
          "/etc/nixos"
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/etc/NetworkManager/system-connections"
          "/var/lib/NetworkManager"
          "/etc/secureboot"
          "/var/db/sudo"
          "/srv"
          "/var/lib/tailscale"
          "/var/lib/flatpak"
          "/etc/ssh"
        ];
        files = [
          "/etc/machine-id"
        ];

        users.${config.my.username} = {
          directories = [
            "Downloads"
            "Music"
            "Pictures"
            "Documents"
            "Videos"
            "scripts"

            #flatpak & nix & AppImage
            ".local/share/flatpak"
            ".cache/flatpak"
            ".local/state/nix"
            ".cache/nix"
            "AppImages"
            ".cache/appimage-run"
            ".var/app"

            #zen
            ".zen"
            ".cache/zen"

            #TeamSpeak
            ".ts3client"
            ".config/TeamSpeak"
            ".cache/TeamSpeak"

            #opencode
            ".config/opencode"
            ".cache/opencode"
            ".local/share/opencode"
            ".local/share/opentui"
            ".local/state/opencode"

            #lazygit
            "./local/state/lazygit"
            ".config/lazygit"

            #discord
            ".config/discord"

            #plex
            ".config/plexamp"

            #vlc
            ".config/vlc"

            #zed
            ".config/zed"
            ".cache/zed"

            #zellij
            ".config/zellij"
            ".cache/zellij"

            #Signal
            ".config/Signal"

            #syncthing
            ".config/syncthing"

            #firefox
            ".config/mozilla"

            #noctalia
            ".config/noctalia"

            #tealdeer(tldr)
            ".cache/tealdeer"

            #fastfetch
            ".cache/fastfetch"

            #starship
            ".cache/starship"

            #dolphin
            ".cache/dolphin"

            #pnpm
            ".cache/pnpm"

            {
              directory = ".gnupg";
              mode = "0700";
            }
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
          ];
          files = [
            ".zsh_history"
          ];
        };
      };
    };

    solModule = {config, ...}: {
      environment.persistence."/persist" = {
        users.${config.my.username} = {
          directories = [
            #steam
            ".steam"
            ".local/share/Steam"
            ".config/heroic"
          ];
        };
      };
    };

    lunaModule = {config, ...}: {
      environment.persistence."/persist" = {
        users.${config.my.username} = {
          directories = [];
        };
      };
    };
  };
}
