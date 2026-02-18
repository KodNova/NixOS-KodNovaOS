_: {
  flake.nixosModules.lunaModule = {
    pkgs,
    config,
    ...
  }: {
    my = {
      username = "kodnova";
      email = "Dev@KodNova.dev";
      home = {
        wayland.windowManager.hyprland.settings = {
          monitor = [
            ", preferred, auto, 1"
          ];

          bindl = [
            ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ];

          bindel = [
            # Brightness control
            ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
            ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ];
        };
      };
    };
    networking = {
      hostName = "luna";
      networkmanager.enable = true;
    };

    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 7;
        efi.canTouchEfiVariables = true;
      };
    };

    services.fstrim = {
      enable = true;
      interval = "weekly"; # This is the default; can also be "daily"
    };

    # --- USER CONFIG ---
    users.mutableUsers = false;
    users.users.${config.my.username} = {
      isNormalUser = true;
      description = config.my.username;
      # WARN: placeholder password
      hashedPassword = "$y$j9T$aK/y4/XGb2iKqAEyjyXI70$yLczsgiS6cWz/U6JMlPHa2OVyYTnY52hmOGBx8s42cB";
      extraGroups = ["networkmanager" "wheel" "scanner" "lp" "libvirtd" "video" "render"];
      shell = pkgs.zsh;
    };

    # --- IMPERMANENCE --- NOTE:keeps
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

    system.stateVersion = "25.11";

    # NOTE: below here is from hardware gen
  };
}
