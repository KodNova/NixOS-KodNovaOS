{inputs, ...}: {
  flake.nixosModules.hyprland-desktop = {pkgs, ...}: {
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
      pkgs.hyprcursor
      pkgs.rose-pine-hyprcursor

      # Screenshots & Clipboard
      pkgs.grim
      pkgs.slurp
      pkgs.clipman
      pkgs.xclip
      pkgs.wl-clipboard
    ];

    my.home = {config, ...}: let
      mkLiteral = config.lib.formats.rasi.mkLiteral;
    in {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
        defaultWallpaper = "/repos/NixOS-KodNovaOS/wallpaper.png";
      };

      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "";
            before_sleep_cmd = "";
            after_sleep_cmd = "";
          };

          listener = [
            {
              timeout = 600;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };

      programs = {
        rofi = {
          enable = true;

          extraConfig = {
            modi = "drun,run,window";
            show-icons = true;
            display-drun = " ";
            drun-display-format = "{name}";
            font = "Hack Nerd Font 11";
            icon-theme = "Papirus";
          };

          theme = {
            "*" = {
              base = mkLiteral "#1e1e2e";
              mantle = mkLiteral "#181825";
              crust = mkLiteral "#11111b";
              text = mkLiteral "#cdd6f4";
              subtext0 = mkLiteral "#a6adc8";
              subtext1 = mkLiteral "#bac2de";
              surface0 = mkLiteral "#313244";
              surface1 = mkLiteral "#45475a";
              surface2 = mkLiteral "#585b70";
              overlay0 = mkLiteral "#6c7086";
              overlay1 = mkLiteral "#7f849c";
              overlay2 = mkLiteral "#9399b2";
              blue = mkLiteral "#89b4fa";
              lavender = mkLiteral "#b4befe";
              sapphire = mkLiteral "#74c7ec";
              sky = mkLiteral "#89dceb";
              teal = mkLiteral "#94e2d5";
              green = mkLiteral "#a6e3a1";
              yellow = mkLiteral "#f9e2af";
              peach = mkLiteral "#fab387";
              maroon = mkLiteral "#eba0ac";
              red = mkLiteral "#f38ba8";
              mauve = mkLiteral "#cba6f7";
              pink = mkLiteral "#f5c2e7";
              flamingo = mkLiteral "#f2cdcd";
              rosewater = mkLiteral "#f5e0dc";

              # Theme variables
              selected-active-foreground = mkLiteral "@background";
              lightfg = mkLiteral "@text";
              separatorcolor = mkLiteral "@foreground";
              urgent-foreground = mkLiteral "@red";
              alternate-urgent-background = mkLiteral "@lightbg";
              lightbg = mkLiteral "@mantle";
              background-color = mkLiteral "transparent";
              border-color = mkLiteral "@foreground";
              normal-background = mkLiteral "@background";
              selected-urgent-background = mkLiteral "@red";
              alternate-active-background = mkLiteral "@lightbg";
              spacing = 2;
              alternate-normal-foreground = mkLiteral "@foreground";
              urgent-background = mkLiteral "@background";
              selected-normal-foreground = mkLiteral "@lightbg";
              active-foreground = mkLiteral "@blue";
              background = mkLiteral "@base";
              selected-active-background = mkLiteral "@blue";
              active-background = mkLiteral "@background";
              selected-normal-background = mkLiteral "@lightfg";
              alternate-normal-background = mkLiteral "@lightbg";
              foreground = mkLiteral "@text";
              selected-urgent-foreground = mkLiteral "@background";
              normal-foreground = mkLiteral "@foreground";
              alternate-urgent-foreground = mkLiteral "@red";
              alternate-active-foreground = mkLiteral "@blue";
            };

            "element" = {
              padding = mkLiteral "1px";
              cursor = mkLiteral "pointer";
              spacing = mkLiteral "5px";
              border = 0;
            };

            "element normal.normal" = {
              background-color = mkLiteral "@normal-background";
              text-color = mkLiteral "@normal-foreground";
            };

            "element normal.urgent" = {
              background-color = mkLiteral "@urgent-background";
              text-color = mkLiteral "@urgent-foreground";
            };

            "element normal.active" = {
              background-color = mkLiteral "@active-background";
              text-color = mkLiteral "@active-foreground";
            };

            "element selected.normal" = {
              background-color = mkLiteral "@selected-normal-background";
              text-color = mkLiteral "@selected-normal-foreground";
            };

            "element selected.urgent" = {
              background-color = mkLiteral "@selected-urgent-background";
              text-color = mkLiteral "@selected-urgent-foreground";
            };

            "element selected.active" = {
              background-color = mkLiteral "@selected-active-background";
              text-color = mkLiteral "@selected-active-foreground";
            };

            "element alternate.normal" = {
              background-color = mkLiteral "@alternate-normal-background";
              text-color = mkLiteral "@alternate-normal-foreground";
            };

            "element alternate.urgent" = {
              background-color = mkLiteral "@alternate-urgent-background";
              text-color = mkLiteral "@alternate-urgent-foreground";
            };

            "element alternate.active" = {
              background-color = mkLiteral "@alternate-active-background";
              text-color = mkLiteral "@alternate-active-foreground";
            };

            "element-text" = {
              background-color = mkLiteral "transparent";
              cursor = mkLiteral "inherit";
              highlight = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };

            "element-icon" = {
              background-color = mkLiteral "transparent";
              size = mkLiteral "1.0000em";
              cursor = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };

            "window" = {
              padding = 5;
              background-color = mkLiteral "@background";
              border = 1;
            };

            "mainbox" = {
              padding = 0;
              border = 0;
            };

            "message" = {
              padding = mkLiteral "1px";
              border-color = mkLiteral "@separatorcolor";
              border = mkLiteral "2px dash 0px 0px";
            };

            "textbox" = {
              text-color = mkLiteral "@foreground";
            };

            "listview" = {
              padding = mkLiteral "2px 0px 0px";
              scrollbar = true;
              border-color = mkLiteral "@separatorcolor";
              spacing = mkLiteral "2px";
              fixed-height = 0;
              border = mkLiteral "2px dash 0px 0px";
            };

            "scrollbar" = {
              width = mkLiteral "4px";
              padding = 0;
              handle-width = mkLiteral "8px";
              border = 0;
              handle-color = mkLiteral "@normal-foreground";
            };

            "sidebar" = {
              border-color = mkLiteral "@separatorcolor";
              border = mkLiteral "2px dash 0px 0px";
            };

            "button" = {
              cursor = mkLiteral "pointer";
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
            };

            "button selected" = {
              background-color = mkLiteral "@selected-normal-background";
              text-color = mkLiteral "@selected-normal-foreground";
            };

            "num-filtered-rows" = {
              expand = false;
              text-color = mkLiteral "Gray";
            };

            "num-rows" = {
              expand = false;
              text-color = mkLiteral "Gray";
            };

            "textbox-num-sep" = {
              expand = false;
              str = "/";
              text-color = mkLiteral "Gray";
            };

            "inputbar" = {
              padding = mkLiteral "1px";
              spacing = mkLiteral "0px";
              text-color = mkLiteral "@normal-foreground";
              children = mkLiteral ''[ "prompt","textbox-prompt-colon","entry","num-filtered-rows","textbox-num-sep","num-rows","case-indicator" ]'';
            };

            "case-indicator" = {
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
            };

            "entry" = {
              text-color = mkLiteral "@normal-foreground";
              cursor = mkLiteral "text";
              spacing = 0;
              placeholder-color = mkLiteral "Gray";
              placeholder = "Type to filter";
            };

            "prompt" = {
              spacing = 0;
              text-color = mkLiteral "@normal-foreground";
            };

            "textbox-prompt-colon" = {
              margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
              expand = false;
              str = ":";
              text-color = mkLiteral "inherit";
            };
          };
        };

        noctalia-shell = {
          enable = true;
          settings = {
            settingsVersion = 53;
            bar = {
              barType = "simple";
              position = "top";
              monitors = [];
              density = "comfortable";
              showOutline = false;
              showCapsule = true;
              capsuleOpacity = 1;
              capsuleColorKey = "none";
              backgroundOpacity = 1;
              useSeparateOpacity = true;
              floating = false;
              marginVertical = 4;
              marginHorizontal = 4;
              frameThickness = 8;
              frameRadius = 12;
              outerCorners = true;
              hideOnOverview = false;
              displayMode = "auto_hide";
              autoHideDelay = 500;
              autoShowDelay = 150;
              widgets = {
                left = [
                  {
                    displayMode = "onhover";
                    iconColor = "none";
                    id = "Network";
                    textColor = "none";
                  }
                  {
                    displayMode = "onhover";
                    iconColor = "none";
                    id = "Bluetooth";
                    textColor = "none";
                  }
                  {
                    displayMode = "alwaysShow";
                    iconColor = "error";
                    id = "VPN";
                    textColor = "none";
                  }
                ];
                center = [
                  {
                    colorizeDistroLogo = false;
                    colorizeSystemIcon = "tertiary";
                    customIconPath = "";
                    enableColorization = false;
                    icon = "noctalia";
                    id = "ControlCenter";
                    useDistroLogo = true;
                  }
                  {
                    hideWhenZero = false;
                    hideWhenZeroUnread = false;
                    iconColor = "none";
                    id = "NotificationHistory";
                    showUnreadBadge = true;
                    unreadBadgeColor = "primary";
                  }
                  {
                    iconColor = "none";
                    id = "WallpaperSelector";
                  }
                ];
                right = [
                  {
                    blacklist = [];
                    chevronColor = "primary";
                    colorizeIcons = false;
                    drawerEnabled = true;
                    hidePassive = false;
                    id = "Tray";
                    pinned = [];
                  }
                  {
                    displayMode = "alwaysShow";
                    iconColor = "primary";
                    id = "Volume";
                    middleClickCommand = "pwvucontrol || pavucontrol";
                    textColor = "tertiary";
                  }
                  {
                    clockColor = "none";
                    customFont = "Noto Sans";
                    formatHorizontal = "HH:mm:ss";
                    formatVertical = "HH mm - dd MM";
                    id = "Clock";
                    tooltipFormat = "HH:mm ddd, MMM dd";
                    useCustomFont = true;
                  }
                  {
                    displayMode = "forceOpen";
                    iconColor = "none";
                    id = "KeyboardLayout";
                    showIcon = true;
                    textColor = "none";
                  }
                  {
                    iconColor = "error";
                    id = "SessionMenu";
                  }
                ];
              };
              screenOverrides = [];
            };
            general = {
              avatarImage = "/repos/NixOS-KodNovaOS/profile.png";
              dimmerOpacity = 0.2;
              showScreenCorners = false;
              forceBlackScreenCorners = false;
              scaleRatio = 1;
              radiusRatio = 1;
              iRadiusRatio = 1;
              boxRadiusRatio = 1;
              screenRadiusRatio = 1;
              animationSpeed = 1;
              animationDisabled = false;
              compactLockScreen = false;
              lockScreenAnimations = true;
              lockOnSuspend = true;
              showSessionButtonsOnLockScreen = true;
              showHibernateOnLockScreen = false;
              enableShadows = true;
              shadowDirection = "center";
              shadowOffsetX = 0;
              shadowOffsetY = 0;
              language = "";
              allowPanelsOnScreenWithoutBar = true;
              showChangelogOnStartup = false;
              telemetryEnabled = false;
              enableLockScreenCountdown = true;
              lockScreenCountdownDuration = 5000;
              autoStartAuth = false;
              allowPasswordWithFprintd = false;
              clockStyle = "digital";
              clockFormat = "HH:mm:ss dd.MM.yyyy ";
              lockScreenMonitors = [];
              lockScreenBlur = 1;
              lockScreenTint = 1;
              keybinds = {
                keyUp = ["Up"];
                keyDown = ["Down"];
                keyLeft = ["Left"];
                keyRight = ["Right"];
                keyEnter = ["Return"];
                keyEscape = ["Esc"];
              };
            };
            ui = {
              fontDefault = "Sans Serif";
              fontFixed = "monospace";
              fontDefaultScale = 1;
              fontFixedScale = 1;
              tooltipsEnabled = true;
              panelBackgroundOpacity = 0.93;
              panelsAttachedToBar = true;
              settingsPanelMode = "attached";
              wifiDetailsViewMode = "grid";
              bluetoothDetailsViewMode = "grid";
              networkPanelView = "wifi";
              bluetoothHideUnnamedDevices = false;
              boxBorderEnabled = false;
            };
            location = {
              name = "Nashville,United States";
              weatherEnabled = true;
              weatherShowEffects = true;
              useFahrenheit = false;
              use12hourFormat = false;
              showWeekNumberInCalendar = false;
              showCalendarEvents = true;
              showCalendarWeather = true;
              analogClockInCalendar = false;
              firstDayOfWeek = -1;
              hideWeatherTimezone = false;
              hideWeatherCityName = true;
            };
            calendar = {
              cards = [
                {
                  enabled = true;
                  id = "calendar-header-card";
                }
                {
                  enabled = true;
                  id = "calendar-month-card";
                }
                {
                  enabled = true;
                  id = "weather-card";
                }
              ];
            };
            wallpaper = {
              enabled = true;
              overviewEnabled = false;
              directory = "/home/kodnova/Pictures/Wallpapers";
              monitorDirectories = [];
              enableMultiMonitorDirectories = false;
              showHiddenFiles = false;
              viewMode = "single";
              setWallpaperOnAllMonitors = true;
              fillMode = "crop";
              fillColor = "#000000";
              useSolidColor = false;
              solidColor = "#1a1a2e";
              automationEnabled = false;
              wallpaperChangeMode = "random";
              randomIntervalSec = 300;
              transitionDuration = 2000;
              transitionType = "random";
              skipStartupTransition = false;
              transitionEdgeSmoothness = 0.05;
              panelPosition = "follow_bar";
              hideWallpaperFilenames = false;
              overviewBlur = 0.4;
              overviewTint = 0.6;
              useWallhaven = true;
              wallhavenQuery = "nixos";
              wallhavenSorting = "relevance";
              wallhavenOrder = "desc";
              wallhavenCategories = "111";
              wallhavenPurity = "100";
              wallhavenRatios = "";
              wallhavenApiKey = "";
              wallhavenResolutionMode = "atleast";
              wallhavenResolutionWidth = "";
              wallhavenResolutionHeight = "";
              sortOrder = "name";
              favorites = [];
            };
            appLauncher = {
              enableClipboardHistory = false;
              autoPasteClipboard = false;
              enableClipPreview = true;
              clipboardWrapText = true;
              clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
              clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
              position = "top_center";
              pinnedApps = [];
              useApp2Unit = false;
              sortByMostUsed = true;
              terminalCommand = "alacritty -e";
              customLaunchPrefixEnabled = false;
              customLaunchPrefix = "";
              viewMode = "grid";
              showCategories = true;
              iconMode = "native";
              showIconBackground = false;
              enableSettingsSearch = true;
              enableWindowsSearch = true;
              enableSessionSearch = true;
              ignoreMouseInput = true;
              screenshotAnnotationTool = "";
              overviewLayer = false;
              density = "default";
            };
            controlCenter = {
              position = "close_to_bar_button";
              diskPath = "/";
              shortcuts = {
                left = [
                  {id = "WallpaperSelector";}
                  {id = "NoctaliaPerformance";}
                  {id = "PowerProfile";}
                ];
                right = [
                  {id = "KeepAwake";}
                  {id = "Network";}
                  {id = "NightLight";}
                  {id = "Notifications";}
                ];
              };
              cards = [
                {
                  enabled = true;
                  id = "profile-card";
                }
                {
                  enabled = true;
                  id = "shortcuts-card";
                }
                {
                  enabled = true;
                  id = "audio-card";
                }
                {
                  enabled = false;
                  id = "brightness-card";
                }
                {
                  enabled = false;
                  id = "weather-card";
                }
                {
                  enabled = true;
                  id = "media-sysmon-card";
                }
              ];
            };
            systemMonitor = {
              cpuWarningThreshold = 80;
              cpuCriticalThreshold = 90;
              tempWarningThreshold = 80;
              tempCriticalThreshold = 90;
              gpuWarningThreshold = 80;
              gpuCriticalThreshold = 90;
              memWarningThreshold = 80;
              memCriticalThreshold = 90;
              swapWarningThreshold = 80;
              swapCriticalThreshold = 90;
              diskWarningThreshold = 80;
              diskCriticalThreshold = 90;
              diskAvailWarningThreshold = 20;
              diskAvailCriticalThreshold = 10;
              batteryWarningThreshold = 20;
              batteryCriticalThreshold = 5;
              cpuPollingInterval = 2000;
              gpuPollingInterval = 3000;
              enableDgpuMonitoring = false;
              memPollingInterval = 3000;
              diskPollingInterval = 30000;
              networkPollingInterval = 1500;
              loadAvgPollingInterval = 3000;
              useCustomColors = false;
              warningColor = "#9bfece";
              criticalColor = "#fd4663";
              externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
            };
            dock = {
              enabled = false;
              position = "bottom";
              displayMode = "auto_hide";
              backgroundOpacity = 1;
              floatingRatio = 1;
              size = 1;
              onlySameOutput = true;
              monitors = [];
              pinnedApps = [];
              colorizeIcons = false;
              pinnedStatic = false;
              inactiveIndicators = false;
              deadOpacity = 0.6;
              animationSpeed = 1;
            };
            network = {
              wifiEnabled = true;
              bluetoothRssiPollingEnabled = false;
              bluetoothRssiPollIntervalMs = 10000;
              wifiDetailsViewMode = "grid";
              bluetoothDetailsViewMode = "grid";
              bluetoothHideUnnamedDevices = false;
            };
            sessionMenu = {
              enableCountdown = false;
              countdownDuration = 5000;
              position = "center";
              showHeader = true;
              largeButtonsStyle = true;
              largeButtonsLayout = "single-row";
              powerOptions = [
                {
                  action = "lock";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "1";
                }
                {
                  action = "suspend";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "2";
                }
                {
                  action = "reboot";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "3";
                }
                {
                  action = "logout";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "4";
                }
                {
                  action = "shutdown";
                  command = "";
                  countdownEnabled = true;
                  enabled = true;
                  keybind = "5";
                }
                {
                  action = "hibernate";
                  command = "";
                  countdownEnabled = true;
                  enabled = false;
                  keybind = "";
                }
              ];
            };
            notifications = {
              enabled = true;
              monitors = [];
              location = "top_right";
              overlayLayer = true;
              backgroundOpacity = 1;
              respectExpireTimeout = false;
              lowUrgencyDuration = 3;
              normalUrgencyDuration = 8;
              criticalUrgencyDuration = 15;
              saveToHistory = {
                low = false;
                normal = true;
                critical = true;
              };
              sounds = {
                enabled = false;
                volume = 0.5;
                separateSounds = false;
                criticalSoundFile = "";
                normalSoundFile = "";
                lowSoundFile = "";
                excludedApps = "discord,firefox,chrome,chromium,edge";
              };
              enableMediaToast = false;
              enableKeyboardLayoutToast = true;
              enableBatteryToast = true;
            };
            osd = {
              enabled = true;
              location = "top_right";
              autoHideMs = 2000;
              overlayLayer = true;
              backgroundOpacity = 1;
              enabledTypes = [0 1 2 3];
              monitors = [];
            };
            audio = {
              volumeStep = 5;
              volumeOverdrive = false;
              cavaFrameRate = 30;
              visualizerType = "linear";
              mprisBlacklist = [];
              preferredPlayer = "";
              volumeFeedback = false;
            };
            brightness = {
              brightnessStep = 5;
              enforceMinimum = true;
              enableDdcSupport = false;
            };
            colorSchemes = {
              useWallpaperColors = false;
              predefinedScheme = "Catppuccin";
              darkMode = true;
              schedulingMode = "off";
              manualSunrise = "06:30";
              manualSunset = "18:30";
              generationMethod = "tonal-spot";
              monitorForColors = "";
            };
            templates = {
              activeTemplates = [
                {
                  enabled = true;
                  id = "btop";
                }
                {
                  enabled = true;
                  id = "hyprland";
                }
                {
                  enabled = true;
                  id = "gtk";
                }
                {
                  enabled = true;
                  id = "qt";
                }
              ];
              enableUserTheming = false;
            };
            nightLight = {
              enabled = false;
              forced = false;
              autoSchedule = true;
              nightTemp = "4000";
              dayTemp = "6500";
              manualSunrise = "06:30";
              manualSunset = "18:30";
            };
            hooks = {
              enabled = false;
              wallpaperChange = "";
              darkModeChange = "";
              screenLock = "";
              screenUnlock = "";
              performanceModeEnabled = "";
              performanceModeDisabled = "";
              startup = "";
              session = "";
            };
            plugins = {
              autoUpdate = false;
            };
          };
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true; # systemd for hypridle
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

            # Scripts
            "CTRLSHIFT, backslash, exec, bash ~/scripts/dev_mode.sh"
            "CTRL SHIFT ALT, backslash, exec, bash ~/scripts/plex_mode.sh"

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
