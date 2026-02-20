_: {
  flake.nixosModules = {
    solModule = {config, ...}: {
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
            ".steam"
            ".zen"
            ".ts3client"
            ".mozilla"
            "zpm-mnt"
            "scripts"

            #.var
            ".var/app"

            #.local
            ".local/share/Steam"
            ".local/share/flatpak"
            ".local/state/nix"

            #.config
            ".config/heroic"
            ".config/discord"
            ".config/lazygit"
            ".config/zed"
            ".config/zellij"
            ".config/plexamp"
            ".config/vlc"
            ".config/Signal"
            ".config/TeamSpeak"
            ".config/syncthing"

            #.cache
            ".config/noctalia"
            ".cache/tealdeer"
            ".cache/fastfetch"
            ".cache/starship"
            ".cache/TeamSpeak"
            ".cache/zen"
            ".cache/zellij"
            ".cache/zed"
            ".cache/flatpak"
            ".cache/nix"
            ".cache/dolphin"
            ".cache/appimage-run"
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
    lunaModule = {config, ...}: {
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
            ".zen"
            ".ts3client"
            ".mozilla"
            "zpm-mnt"
            "scripts"

            #.var
            ".var/app"

            #.local
            ".local/share/flatpak"
            ".local/state/nix"

            #.config
            ".config/discord"
            ".config/lazygit"
            ".config/zed"
            ".config/zellij"
            ".config/plexamp"
            ".config/vlc"
            ".config/Signal"
            ".config/TeamSpeak"
            ".config/syncthing"

            #.cache
            ".config/noctalia"
            ".cache/tealdeer"
            ".cache/fastfetch"
            ".cache/starship"
            ".cache/TeamSpeak"
            ".cache/zen"
            ".cache/zellij"
            ".cache/zed"
            ".cache/flatpak"
            ".cache/nix"
            ".cache/dolphin"
            ".cache/appimage-run"
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
  };
}
