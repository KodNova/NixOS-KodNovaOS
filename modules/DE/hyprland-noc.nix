{inputs, ...}: {
  flake.nixosModules.hyprland-noc = {pkgs, ...}: {
    programs.hyprland = {
      enable = true;
      withUWSM = false;
      xwayland.enable = true;
    };

    # noctalia needs these
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    environment.systemPackages = [
      pkgs.playerctl
      pkgs.wofi
      pkgs.rofi
      pkgs.hyprcursor
      pkgs.rose-pine-hyprcursor

      # Screenshots & Clipboard
      pkgs.grim
      pkgs.slurp
      pkgs.clipman
      pkgs.xclip
      pkgs.wl-clipboard
    ];

    my.home = {...}: {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
        defaultWallpaper = "/repos/NixOS-KodNovaOS/wallpaper.png";
      };

      programs.noctalia-shell = {
        enable = true;
        settings = {
          bar = {
            density = "compact";
            position = "top";
            widgets = {
              left = [
                {
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {id = "Network";}
                {id = "Bluetooth";}
              ];
              center = [
                {
                  id = "Workspace";
                  hideUnoccupied = false;
                  labelMode = "none";
                }
              ];
              right = [
                {
                  id = "Clock";
                  formatHorizontal = "HH:mm";
                  useMonospacedFont = true;
                }
              ];
            };
          };
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        settings = {
          "$mainMod" = "SUPER";
          "$ipc" = "noctalia-shell ipc call";

          exec-once = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "noctalia-shell"
            "wl-paste -t text --watch clipman store --no-persist"
          ];

          env = [
            "HYPRCURSOR_THEME,rose-pine-hyprcursor"
            "HYPRCURSOR_SIZE,24"
          ];

          input = {
            kb_layout = "us";
            kb_options = "ctrl:nocaps";
            follow_mouse = 2;
            sensitivity = 0;
            force_no_accel = true;
            numlock_by_default = true;
          };

          general = {
            gaps_in = 2;
            gaps_out = 2;
            border_size = 3;
            "col.active_border" = "rgba(60049dfc)";
            "col.inactive_border" = "rgba(595959aa)";
            layout = "dwindle";
          };

          cursor = {
            inactive_timeout = 1;
            hide_on_key_press = true;
            no_hardware_cursors = false;
          };

          decoration = {
            rounding = 10;
            blur = {
              enabled = false;
              size = 8;
              passes = 1;
            };
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };

          bind = [
            # window management
            "$mainMod, C, killactive,"
            "$mainMod, P, pseudo,"
            "$mainMod, O, togglesplit,"
            "$mainMod, V, togglefloating,"
            "$mainMod, F, fullscreen,"

            # noctalia controls
            "$mainMod, SPACE, exec, $ipc launcher toggle"
            "$mainMod, S, exec, $ipc controlCenter toggle"
            "$mainMod, comma, exec, $ipc settings toggle"
            "$mainMod, Escape, exec, $ipc sessionMenu toggle"

            # lock
            "CTRL ALT, Delete, exec, $ipc lockScreen lock"

            # clipman
            "ALT CTRL, v, exec, clipman pick -t wofi"

            # move window
            "SUPER SHIFT, H, movewindow, l"
            "SUPER SHIFT, L, movewindow, r"
            "SUPER SHIFT, K, movewindow, u"
            "SUPER SHIFT, J, movewindow, d"

            # resize
            "SUPER ALT, H, resizeactive, -40 0"
            "SUPER ALT, L, resizeactive, 40 0"
            "SUPER ALT, K, resizeactive, 0 -40"
            "SUPER ALT, J, resizeactive, 0 40"

            # main hotkeys
            "$mainMod, Return, exec, alacritty"

            # app launches
            "CTRLSHIFT, F, exec, alacritty -e superfile"
            "CTRLSHIFT, S, exec, steam"
            "CTRLSHIFT, Z, exec, alacritty -e zellij -l welcome"
            "CTRLSHIFT, Q, exec, signal-desktop"
            "CTRLSHIFT, M, exec, thunderbird"
            "CTRLSHIFT, P, exec, pkill pavucontrol || pavucontrol"

            # screenshots
            "$mainMod, Print, exec, grim"
            "CTRLSHIFT, Print, exec, grim -g \"$(slurp)\""

            # media
            ",XF86AudioPlay, exec, playerctl play-pause"
            ",XF86AudioStop, exec, playerctl play-pause"
            ",XF86AudioPrev, exec, playerctl previous"
            ",XF86AudioNext, exec, playerctl next"

            # focus
            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"

            # workspaces
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # move to workspace
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            # power
            "SUPER CTRL SHIFT ALT, P, exec, poweroff"
            "SUPER CTRL SHIFT ALT, R, exec, reboot"
            "SUPER CTRL SHIFT ALT, C, exit,"
          ];

          bindel = [
            ",XF86AudioRaiseVolume, exec, $ipc volume increase"
            ",XF86AudioLowerVolume, exec, $ipc volume decrease"
            ",XF86MonBrightnessUp, exec, $ipc brightness increase"
            ",XF86MonBrightnessDown, exec, $ipc brightness decrease"
          ];

          bindl = [
            ",XF86AudioMute, exec, $ipc volume muteOutput"
            "$mainMod, Super_L, exec, pkill rofi || rofi -show drun"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}
