{inputs, ...}: {
  flake.nixosModules = {
    niri = {pkgs, ...}: {
      imports = [inputs.niri.nixosModules.niri];
      nixpkgs.overlays = [inputs.niri.overlays.niri];
      programs.niri.enable = true;

      environment.systemPackages = [
        pkgs.playerctl
        pkgs.wofi
        pkgs.hyprcursor
        pkgs.rose-pine-hyprcursor

        # Screenshots & Clipboard
        pkgs.grim
        pkgs.slurp
        pkgs.clipman
        pkgs.xclip
        pkgs.wl-clipboard
      ];

      services.kanata = {
        enable = true;
        keyboards.default = {
          config = ''
            (defsrc
              caps lmet)

            (deflayer base
              (tap-hold-release 200 200 f20 XX)
              (tap-hold-release 200 200 f20 lmet))
          '';
        };
      };

      my.home = _: {
        programs.niri = {
          settings = {
            input = {
              focus-follows-mouse.enable = true;
              keyboard.numlock = true;
            };
            binds = {
              "Mod+Return".action.spawn = "alacritty";
              "F20".action.spawn = ["bash" "-c" "pkill rofi || rofi -show drun"];

              # Window management
              "Mod+C".action.close-window = {};
              "Mod+Q".action.close-window = {};
              "Mod+V".action.toggle-window-floating = {};
              "Mod+F".action.fullscreen-window = {};

              # Noctalia controls
              "Mod+Space".action.spawn = ["noctalia-ipc" "launcher" "toggle"];
              "Mod+S".action.spawn = ["noctalia-ipc" "controlCenter" "toggle"];
              "Mod+Comma".action.spawn = ["noctalia-ipc" "settings" "toggle"];
              "Mod+Escape".action.spawn = ["noctalia-ipc" "sessionMenu" "toggle"];

              # Lock
              "Ctrl+Alt+Delete".action.spawn = ["noctalia-ipc" "lockScreen" "lock"];

              # Clipman
              "Alt+Ctrl+V".action.spawn = ["clipman" "pick" "-t" "wofi"];

              # Move window (niri uses column/row movement)
              "Mod+Shift+H".action.move-column-left = {};
              "Mod+Shift+L".action.move-column-right = {};
              "Mod+Shift+K".action.move-window-up = {};
              "Mod+Shift+J".action.move-window-down = {};

              # Resize
              "Mod+Alt+H".action.set-column-width = "-40";
              "Mod+Alt+L".action.set-column-width = "+40";
              "Mod+Alt+K".action.set-window-height = "-40";
              "Mod+Alt+J".action.set-window-height = "+40";

              # App launches
              "Ctrl+Shift+F".action.spawn = ["alacritty" "-e" "superfile"];
              "Ctrl+Shift+S".action.spawn = "steam";
              "Ctrl+Shift+Z".action.spawn = ["alacritty" "-e" "zellij" "-l" "welcome"];
              "Ctrl+Shift+Q".action.spawn = "signal-desktop";
              "Ctrl+Shift+M".action.spawn = "thunderbird";
              "Ctrl+Shift+P".action.spawn = ["bash" "-c" "pkill pavucontrol || pavucontrol"];

              # Media
              "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
              "XF86AudioStop".action.spawn = ["playerctl" "play-pause"];
              "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
              "XF86AudioNext".action.spawn = ["playerctl" "next"];

              # Volume / Brightness (repeatable)
              "XF86AudioRaiseVolume" = {
                action.spawn = ["noctalia-ipc" "volume" "increase"];
                allow-when-locked = true;
              };
              "XF86AudioLowerVolume" = {
                action.spawn = ["noctalia-ipc" "volume" "decrease"];
                allow-when-locked = true;
              };
              "XF86AudioMute" = {
                action.spawn = ["noctalia-ipc" "volume" "muteOutput"];
                allow-when-locked = true;
              };
              "XF86MonBrightnessUp" = {
                action.spawn = ["noctalia-ipc" "brightness" "increase"];
                allow-when-locked = true;
              };
              "XF86MonBrightnessDown" = {
                action.spawn = ["noctalia-ipc" "brightness" "decrease"];
                allow-when-locked = true;
              };

              # Focus (niri uses column focus for left/right)
              "Mod+H".action.focus-column-left = {};
              "Mod+L".action.focus-column-right = {};
              "Mod+K".action.focus-window-up = {};
              "Mod+J".action.focus-window-down = {};

              # Workspaces
              "Mod+1".action.focus-workspace = 1;
              "Mod+2".action.focus-workspace = 2;
              "Mod+3".action.focus-workspace = 3;
              "Mod+4".action.focus-workspace = 4;
              "Mod+5".action.focus-workspace = 5;
              "Mod+6".action.focus-workspace = 6;
              "Mod+7".action.focus-workspace = 7;
              "Mod+8".action.focus-workspace = 8;
              "Mod+9".action.focus-workspace = 9;
              "Mod+0".action.focus-workspace = 10;

              # Move to workspace
              "Mod+Shift+1".action.move-window-to-workspace = 1;
              "Mod+Shift+2".action.move-window-to-workspace = 2;
              "Mod+Shift+3".action.move-window-to-workspace = 3;
              "Mod+Shift+4".action.move-window-to-workspace = 4;
              "Mod+Shift+5".action.move-window-to-workspace = 5;
              "Mod+Shift+6".action.move-window-to-workspace = 6;
              "Mod+Shift+7".action.move-window-to-workspace = 7;
              "Mod+Shift+8".action.move-window-to-workspace = 8;
              "Mod+Shift+9".action.move-window-to-workspace = 9;
              "Mod+Shift+0".action.move-window-to-workspace = 10;

              # Power
              "Mod+Ctrl+Shift+Alt+P".action.spawn = "poweroff";
              "Mod+Ctrl+Shift+Alt+R".action.spawn = "reboot";
              "Mod+Ctrl+Shift+Alt+C".action.quit = {};
            };
          };
        };
      };
    };
  };
}
