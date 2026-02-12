_: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
    programs.hyprland = {
      enable = true;
      withUWSM = false;
      xwayland.enable = true;
    };

    environment.systemPackages = [
      pkgs.mako
      pkgs.swayidle
      pkgs.swaylock-effects
      pkgs.rofi-wayland
      pkgs.waybar
      pkgs.playerctl
      pkgs.gammastep
      pkgs.hyprpaper
      pkgs.waybar
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

    my.home = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        settings = {
          "$mainMod" = "SUPER";

          monitor = [
            "HDMI-A-1,1920x1080@60.00,0x0,1"
            "DP-2,2560x1440@143.856003,1920x0,1"
            "DVI-D-1,1920x1080@60.00,4480x0,1"
          ];

          exec-once = [
            "mako"
            "swayidle -w timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'"
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
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
            touchpad = {
              natural_scroll = false;
            };
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

          windowrulev2 = [
            "float,class:(Plexamp),title:(Plexamp)"
          ];

          bind = [
            # window management
            "$mainMod, C, killactive,"
            "$mainMod, P, pseudo,"
            "$mainMod, O, togglesplit,"
            "$mainMod, V, togglefloating,"
            "$mainMod, F, fullscreen,"

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

            # clipman
            "ALT CTRL, v, exec, clipman pick -t wofi"

            # app launches
            "CTRLSHIFT, F, exec, alacritty -e superfile"
            "CTRLSHIFT, backslash, exec, bash ~/scripts/dev_mode.sh"
            "CTRL SHIFT ALT, backslash, exec, bash ~/scripts/plex_mode.sh"
            "CTRLSHIFT, S, exec, steam"
            "CTRLSHIFT, T, exec, com.teamspeak.TeamSpeak3"
            "CTRLSHIFT, Z, exec, alacritty -e zellij -l welcome"
            "CTRLSHIFT, Q, exec, signal-desktop"
            "CTRLSHIFT, M, exec, thunderbird"
            "CTRLSHIFT, P, exec, pkill pavucontrol || pavucontrol"
            "CTRLSHIFT, E, exec, pkill org.kde.dolphin || org.kde.dolphin"

            # power
            "SUPER CTRL SHIFT ALT, P, exec, poweroff"
            "SUPER CTRL SHIFT ALT, R, exec, reboot"
            "SUPER CTRL SHIFT ALT, C, exit,"

            # lock
            "CTRL ALT, Delete, exec, swaylock"

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
          ];

          bindr = [
            "$mainMod, Super_L, exec, pkill rofi || rofi -show drun"
            "SUPER CTRL SHIFT ALT, w, exec, pkill waybar || waybar"
            "SUPER CTRL SHIFT ALT, g, exec, pkill gammastep || gammastep -O 3200"
            "SUPER CTRL SHIFT ALT, h, exec, pkill hyprpaper || hyprpaper -c ~/nixos-configs/dotfiles/hyprland-dots/hyprpaper/hyprpaper.conf"
            "SUPER CTRL SHIFT ALT, s, exec, pkill swayidle || swayidle -w timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'"
            "CTRL SHIFT ALT, P, exec, pkill pavucontrol || pavucontrol"
          ];

          bindl = [
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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
