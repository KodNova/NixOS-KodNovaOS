{inputs, ...}: {
  flake.nixosModules = {
    niri = {pkgs, ...}: {
      imports = [inputs.niri.nixosModules.niri];
      nixpkgs.overlays = [inputs.niri.overlays.niri];
      programs.niri.enable = true;

      environment.systemPackages = [
        pkgs.playerctl
        pkgs.wofi
        pkgs.rose-pine-cursor
        pkgs.wl-clipboard
        pkgs.swayidle
      ];

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "niri";
        XCURSOR_THEME = "BreezeX-RosePine-Linux";
        XCURSOR_SIZE = "24";
      };

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
        config.common.default = ["*"];
      };

      services.kanata = {
        enable = false;
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
        home.packages = [pkgs.xdg-desktop-portal-gtk pkgs.cliphist];
        services = {
          cliphist.enable = true;
          cliphist.allowImages = true;
        };

        home.pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = "BreezeX-RosePine-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };

        programs.niri = {
          settings = {
            hotkey-overlay.skip-at-startup = true;
            screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

            spawn-at-startup = [
              {
                command = [
                  "dbus-update-activation-environment"
                  "--systemd"
                  "WAYLAND_DISPLAY"
                  "XDG_CURRENT_DESKTOP"
                ];
              }
              {command = ["noctalia-shell"];}
              {command = ["systemctl" "--user" "restart" "cliphist.service"];}
              {command = ["systemctl" "--user" "restart" "cliphist-images.service"];}
              {
                command = [
                  "swayidle"
                  "-w"
                  "timeout"
                  "600"
                  "niri msg action power-off-monitors"
                  "before-sleep"
                  "niri msg action power-off-monitors"
                ];
              }
            ];

            input = {
              focus-follows-mouse.enable = false;
              keyboard.numlock = true;
              warp-mouse-to-focus.enable = true;

              mouse = {
                # off
                natural-scroll = false;
                # accel-speed 0.2
                accel-profile = "flat";
                # scroll-factor 1.0
                # scroll-factor vertical=1.0 horizontal=-2.0
                # scroll-method "no-scroll"
                # scroll-button 273
                # scroll-button-lock
                # left-handed
                # middle-emulation
              };
            };
            gestures.hot-corners.enable = false;

            cursor = {
              theme = "BreezeX-RosePine-Linux";
              size = 24;
              hide-on-key-press = true;
            };

            binds = {
              "Mod+Return".action.spawn = "alacritty";
              "Mod+Space".action.spawn = ["bash" "-c" "pkill rofi || rofi -show drun"];

              # Noctalia controls
              "Mod+Alt+Space".action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
              "Mod+S".action.spawn = ["noctalia-shell" "ipc" "call" "controlCenter" "toggle"];
              "Mod+Escape".action.spawn = ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];

              # Lock
              "Ctrl+Alt+Delete".action.spawn = ["noctalia-shell" "ipc" "call" "lockScreen" "lock"];

              # clipboard
              "Alt+Ctrl+V".action.spawn = [
                "sh"
                "-c"
                "cliphist list | wofi --dmenu | cliphist decode | wl-copy"
              ];

              #mouse
              "Mod+WheelScrollDown".action.focus-column-right = {};
              "Mod+WheelScrollUp".action.focus-column-left = {};

              # Window management
              "Mod+Q".action.close-window = {};
              "Mod+V".action.toggle-window-floating = {};
              "Mod+T".action.toggle-column-tabbed-display = {};
              "Mod+O" = {
                action.toggle-overview = {};
                repeat = false;
              };

              # Move window
              "Mod+Shift+H".action.move-column-left = {};
              "Mod+Shift+L".action.move-column-right = {};
              "Mod+Shift+K".action.move-window-up = {};
              "Mod+Shift+J".action.move-window-down = {};
              "Mod+Comma".action.consume-or-expel-window-left = {};
              "Mod+Period".action.consume-or-expel-window-right = {};

              # Resize
              "Mod+Alt+H".action.set-column-width = "-40";
              "Mod+Alt+L".action.set-column-width = "+40";
              "Mod+Alt+K".action.set-window-height = "+40";
              "Mod+Alt+J".action.set-window-height = "-40";
              "Mod+R".action.switch-preset-column-width = {};
              "Mod+Alt+R".action.switch-preset-window-height = {};
              "Mod+Alt+Ctrl+F".action.fullscreen-window = {};
              "Mod+F".action.maximize-column = {};
              "Mod+Alt+F".action.expand-column-to-available-width = {};

              # App launches
              "Ctrl+Shift+F".action.spawn = ["alacritty" "-e" "superfile"];
              "Ctrl+Shift+S".action.spawn = "steam";
              "Ctrl+Shift+Z".action.spawn = ["alacritty" "-e" "zellij" "-l" "welcome"];
              "Ctrl+Shift+B".action.spawn = "app.zen_browser.zen";
              "Ctrl+Shift+Q".action.spawn = "signal-desktop";
              "Ctrl+Shift+M".action.spawn = "thunderbird";
              "Ctrl+Shift+P".action.spawn = ["bash" "-c" "pkill pavucontrol || pavucontrol"];

              # Screenshots
              "Mod+Print".action."screenshot-screen" = {};
              "Ctrl+Shift+Print".action."screenshot" = {};

              # Media
              "XF86AudioPlay" = {
                allow-when-locked = true;
                action.spawn = ["playerctl" "play-pause"];
              };
              "XF86AudioStop" = {
                allow-when-locked = true;
                action.spawn = ["playerctl" "play-pause"];
              };
              "XF86AudioPrev" = {
                allow-when-locked = true;
                action.spawn = ["playerctl" "previous"];
              };
              "XF86AudioNext" = {
                allow-when-locked = true;
                action.spawn = ["playerctl" "next"];
              };

              # Volume / Brightness (repeatable)
              "XF86AudioRaiseVolume" = {
                action.spawn = ["noctalia-shell" "ipc" "call" "volume" "increase"];
                allow-when-locked = true;
                repeat = true;
              };
              "XF86AudioLowerVolume" = {
                action.spawn = ["noctalia-shell" "ipc" "call" "volume" "decrease"];
                allow-when-locked = true;
                repeat = true;
              };
              "XF86AudioMute" = {
                action.spawn = ["noctalia-shell" "ipc" "call" "volume" "muteOutput"];
                allow-when-locked = true;
              };
              "XF86MonBrightnessUp" = {
                action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "increase"];
                allow-when-locked = true;
                repeat = true;
              };
              "XF86MonBrightnessDown" = {
                action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "decrease"];
                allow-when-locked = true;
                repeat = true;
              };
              "XF86AudioMicMute" = {
                action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
                allow-when-locked = true;
                repeat = false;
              };

              # Focus
              "Mod+H".action.focus-column-left = {};
              "Mod+L".action.focus-column-right = {};
              "Mod+K".action.focus-window-up = {};
              "Mod+J".action.focus-window-down = {};

              "Mod+Ctrl+H".action.focus-monitor-left = {};
              "Mod+Ctrl+L".action.focus-monitor-right = {};
              # "Mod+Ctrl+K".action.focus-monitor-up = {};
              # "Mod+Ctrl+J".action.focus-monitor-down = {};

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
            prefer-no-csd = true;
            layout = {
              preset-column-widths = [
                {proportion = 1.0 / 3.0;}
                {proportion = 0.5;}
                {proportion = 1.0;}
              ];
              preset-window-heights = [
                {proportion = 0.5;}
                {proportion = 1.0;}
              ];
              gaps = 4;
              center-focused-column = "on-overflow"; # [ never, always, on-overflow]
              default-column-display = "normal";
              border = {
                enable = true;
                width = 2;
                active.gradient = {
                  from = "#f9e2af";
                  to = "#b4befe";
                };
                inactive.color = "#bac2de";
                urgent.color = "#f38ba8";
              };
              focus-ring = {
                enable = false;
                width = 2;
                active.gradient = {
                  from = "#b4befe";
                  to = "#cba6f7";
                };
                inactive.color = "#bac2de";
                urgent.color = "#f38ba8";
              };
              tab-indicator = {
                enable = true;
                width = 8;
                gap = 8;
                length.total-proportion = 1.0;
                position = "top";
                place-within-column = true;
                active.color = "#cba6f7";
                inactive.color = "#74c7ec";
                urgent.color = "#f38ba8";
              };
              insert-hint.display.gradient = {
                from = "#b4befe";
                to = "#cba6f7";
              };
              background-color = "#1e1e2e";
            };
            window-rules = [
              {
                draw-border-with-background = false;
                geometry-corner-radius = {
                  top-left = 10.0;
                  top-right = 10.0;
                  bottom-left = 10.0;
                  bottom-right = 10.0;
                };
                clip-to-geometry = true;
              }
            ];

            animations = {
              enable = true;
              window-open = {
                enable = true;
                kind.easing = {
                  duration-ms = 1000;
                  curve = "ease-out-expo";
                };
              };
              window-close = {
                enable = true;
                kind.easing = {
                  duration-ms = 1000;
                  curve = "ease-out-quad";
                };
              };
            };
          };
        };
      };
    };
    solModule = _: {
      my.home = _: {
        programs.niri.settings.outputs = {
          "HDMI-A-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.0;
            };
            position = {
              x = 0;
              y = 0;
            };
            scale = 1.0;
          };
          "DP-2" = {
            mode = {
              width = 2560;
              height = 1440;
              refresh = 143.856;
            };
            position = {
              x = 1920;
              y = 0;
            };
            scale = 1.0;
          };
          "DVI-D-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.0;
            };
            position = {
              x = 4480;
              y = 0;
            };
            scale = 1.0;
          };
        };
      };
    };
    lunaModule = _: {
      my.home = _: {
        programs.niri.settings = {
          binds = {
            "Ctrl+Shift+Alt+Z".action.spawn = [
              "alacritty"
              "-e"
              "zsh"
              "-i"
              "-c"
              "solway"
            ];
          };
          input = {
            touchpad = {
              # off
              tap = true;
              # dwt
              # dwtp
              # drag false
              # drag-lock
              natural-scroll = false;
              accel-speed = 0.2;
              accel-profile = "flat";
              # scroll-factor 1.0
              # scroll-factor vertical=1.0 horizontal=-2.0
              scroll-method = "two-finger";
              # scroll-button 273
              # scroll-button-lock
              # tap-button-map "left-middle-right"
              # click-method "clickfinger"
              # left-handed
              # disabled-on-external-mouse
              # middle-emulation
            };

            trackpoint = {
              # off
              natural-scroll = false;
              # accel-speed 0.2
              accel-profile = "flat";
              # scroll-method "on-button-down"
              # scroll-button 273
              # scroll-button-lock
              # left-handed
              # middle-emu
            };
          };
        };
      };
    };
  };
}
