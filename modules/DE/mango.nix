{inputs, ...}: {
  flake.nixosModules = {
    mango = {pkgs, ...}: {
      imports = [
        inputs.mango.nixosModules.mango
      ];

      programs.mango.enable = true;

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

      my.home = _: {
        imports = [
          inputs.noctalia.homeModules.default
          inputs.mango.hmModules.mango
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

        wayland.windowManager.mango = {
          enable = true;
          settings = ''
                          # your config.conf contents here
                          # More option see https://github.com/DreamMaoMao/mango/wiki/

            # Window effect
            blur=0
            blur_layer=0
            blur_optimized=1
            blur_params_num_passes = 2
            blur_params_radius = 5
            blur_params_noise = 0.02
            blur_params_brightness = 0.9
            blur_params_contrast = 0.9
            blur_params_saturation = 1.2

            shadows = 0
            layer_shadows = 0
            shadow_only_floating = 1
            shadows_size = 10
            shadows_blur = 15
            shadows_position_x = 0
            shadows_position_y = 0
            shadowscolor= 0x000000ff

            border_radius=6
            no_radius_when_single=0
            focused_opacity=1.0
            unfocused_opacity=1.0

            # Animation Configuration(support type:zoom,slide)
            # tag_animation_direction: 1-horizontal,0-vertical
            animations=1
            layer_animations=1
            animation_type_open=slide
            animation_type_close=slide
            animation_fade_in=1
            animation_fade_out=1
            tag_animation_direction=1
            zoom_initial_ratio=0.3
            zoom_end_ratio=0.8
            fadein_begin_opacity=0.5
            fadeout_begin_opacity=0.8
            animation_duration_move=500
            animation_duration_open=400
            animation_duration_tag=350
            animation_duration_close=800
            animation_duration_focus=0
            animation_curve_open=0.46,1.0,0.29,1
            animation_curve_move=0.46,1.0,0.29,1
            animation_curve_tag=0.46,1.0,0.29,1
            animation_curve_close=0.08,0.92,0,1
            animation_curve_focus=0.46,1.0,0.29,1
            animation_curve_opafadeout=0.5,0.5,0.5,0.5
            animation_curve_opafadein=0.46,1.0,0.29,1

            # Scroller Layout Setting
            scroller_structs=20
            scroller_default_proportion=0.8
            scroller_focus_center=0
            scroller_prefer_center=0
            edge_scroller_pointer_focus=1
            scroller_default_proportion_single=1.0
            scroller_proportion_preset=0.5,0.8,1.0

            # Master-Stack Layout Setting
            new_is_master=1
            default_mfact=0.55
            default_nmaster=1
            smartgaps=0

            # Overview Setting
            hotarea_size=10
            enable_hotarea=1
            ov_tab_mode=0
            overviewgappi=5
            overviewgappo=30

            # Misc
            no_border_when_single=0
            axis_bind_apply_timeout=100
            focus_on_activate=1
            idleinhibit_ignore_visible=0
            sloppyfocus=1
            warpcursor=1
            focus_cross_monitor=0
            focus_cross_tag=0
            enable_floating_snap=0
            snap_distance=30
            cursor_size=24
            drag_tile_to_tile=1

            # keyboard
            repeat_rate=25
            repeat_delay=600
            numlockon=0
            xkb_rules_layout=us

            # Trackpad
            # need relogin to make it apply
            disable_trackpad=0
            tap_to_click=1
            tap_and_drag=1
            drag_lock=1
            trackpad_natural_scrolling=0
            disable_while_typing=1
            left_handed=0
            middle_button_emulation=0
            swipe_min_threshold=1

            # mouse
            # need relogin to make it apply
            mouse_natural_scrolling=0

            # Appearance
            gappih=5
            gappiv=5
            gappoh=10
            gappov=10
            scratchpad_width_ratio=0.8
            scratchpad_height_ratio=0.9
            borderpx=4
            rootcolor=0x201b14ff
            bordercolor=0x444444ff
            focuscolor=0xc9b890ff
            maximizescreencolor=0x89aa61ff
            urgentcolor=0xad401fff
            scratchpadcolor=0x516c93ff
            globalcolor=0xb153a7ff
            overlaycolor=0x14a57cff

            # layout support:
            # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
            tagrule=id:1,layout_name:tile
            tagrule=id:2,layout_name:tile
            tagrule=id:3,layout_name:tile
            tagrule=id:4,layout_name:tile
            tagrule=id:5,layout_name:tile
            tagrule=id:6,layout_name:tile
            tagrule=id:7,layout_name:tile
            tagrule=id:8,layout_name:tile
            tagrule=id:9,layout_name:tile

            # Key Bindings
            # key name refer to `xev` or `wev` command output,
            # mod keys name: super,ctrl,alt,shift,none

            # reload config
            bind=SUPER,r,reload_config

            # menu and terminal
            bind=Alt,space,spawn,rofi -show drun
            bind=SUPER,Return,spawn,alacritty

            # exit
            bind=SUPER,c,quit
            bind=ALT,q,killclient,

            # switch window focus
            bind=SUPER,Tab,focusstack,next
            bind=ALT,Left,focusdir,left
            bind=ALT,Right,focusdir,right
            bind=ALT,Up,focusdir,up
            bind=ALT,Down,focusdir,down

            # swap window
            bind=SUPER+SHIFT,Up,exchange_client,up
            bind=SUPER+SHIFT,Down,exchange_client,down
            bind=SUPER+SHIFT,Left,exchange_client,left
            bind=SUPER+SHIFT,Right,exchange_client,right

            # switch window status
            bind=SUPER,g,toggleglobal,
            bind=ALT,Tab,toggleoverview,
            bind=ALT,backslash,togglefloating,
            bind=ALT,a,togglemaximizescreen,
            bind=ALT,f,togglefullscreen,
            bind=ALT+SHIFT,f,togglefakefullscreen,
            bind=SUPER,i,minimized,
            bind=SUPER,o,toggleoverlay,
            bind=SUPER+SHIFT,I,restore_minimized
            bind=ALT,z,toggle_scratchpad

            # scroller layout
            bind=ALT,e,set_proportion,1.0
            bind=ALT,x,switch_proportion_preset,

            # switch layout
            bind=SUPER,n,switch_layout

            # tag switch
            bind=SUPER,Left,viewtoleft,0
            bind=CTRL,Left,viewtoleft_have_client,0
            bind=SUPER,Right,viewtoright,0
            bind=CTRL,Right,viewtoright_have_client,0
            bind=CTRL+SUPER,Left,tagtoleft,0
            bind=CTRL+SUPER,Right,tagtoright,0

            bind=Ctrl,1,view,1,0
            bind=Ctrl,2,view,2,0
            bind=Ctrl,3,view,3,0
            bind=Ctrl,4,view,4,0
            bind=Ctrl,5,view,5,0
            bind=Ctrl,6,view,6,0
            bind=Ctrl,7,view,7,0
            bind=Ctrl,8,view,8,0
            bind=Ctrl,9,view,9,0

            # tag: move client to the tag and focus it
            # tagsilent: move client to the tag and not focus it
            # bind=Alt,1,tagsilent,1
            bind=Alt,1,tag,1,0
            bind=Alt,2,tag,2,0
            bind=Alt,3,tag,3,0
            bind=Alt,4,tag,4,0
            bind=Alt,5,tag,5,0
            bind=Alt,6,tag,6,0
            bind=Alt,7,tag,7,0
            bind=Alt,8,tag,8,0
            bind=Alt,9,tag,9,0

            # monitor switch
            bind=alt+shift,Left,focusmon,left
            bind=alt+shift,Right,focusmon,right
            bind=SUPER+Alt,Left,tagmon,left
            bind=SUPER+Alt,Right,tagmon,right

            # gaps
            bind=ALT+SHIFT,X,incgaps,1
            bind=ALT+SHIFT,Z,incgaps,-1
            bind=ALT+SHIFT,R,togglegaps

            # movewin
            bind=CTRL+SHIFT,Up,movewin,+0,-50
            bind=CTRL+SHIFT,Down,movewin,+0,+50
            bind=CTRL+SHIFT,Left,movewin,-50,+0
            bind=CTRL+SHIFT,Right,movewin,+50,+0

            # resizewin
            bind=CTRL+ALT,Up,resizewin,+0,-50
            bind=CTRL+ALT,Down,resizewin,+0,+50
            bind=CTRL+ALT,Left,resizewin,-50,+0
            bind=CTRL+ALT,Right,resizewin,+50,+0

            # Mouse Button Bindings
            # btn_left and btn_right can't bind none mod key
            mousebind=SUPER,btn_left,moveresize,curmove
            mousebind=NONE,btn_middle,togglemaximizescreen,0
            mousebind=SUPER,btn_right,moveresize,curresize


            # Axis Bindings
            axisbind=SUPER,UP,viewtoleft_have_client
            axisbind=SUPER,DOWN,viewtoright_have_client


            # layer rule
            layerrule=animation_type_open:zoom,layer_name:rofi
            layerrule=animation_type_close:zoom,layer_name:rofi
          '';
          autostart_sh = ''
            # your autostart.sh contents here (no shebang needed)
            # noctalia-shell
          '';
        };
      };
    };

    solModule = _: {
      my.home = {
        programs.noctalia-shell.settings = {
          desktopWidgets = {
            enabled = true;
            gridSnap = false;
            monitorWidgets = [
              {
                name = "HDMI-A-1";
                widgets = [];
              }
              {
                name = "DVI-D-1";
                widgets = [];
              }
              {
                name = "DP-2";
                widgets = [
                  {
                    hideMode = "hidden";
                    id = "MediaPlayer";
                    roundedCorners = true;
                    scale = 1.0848528137423856;
                    showAlbumArt = true;
                    showBackground = true;
                    showButtons = true;
                    showVisualizer = true;
                    visualizerType = "linear";
                    x = 0;
                    y = 40;
                  }
                  {
                    clockColor = "secondary";
                    clockStyle = "minimal";
                    customFont = "Hack Nerd Font";
                    format = "HH:mm\\nd MMMM yyyy";
                    id = "Clock";
                    roundedCorners = true;
                    scale = 1.5232590180780452;
                    showBackground = true;
                    useCustomFont = true;
                    x = 2280;
                    y = 40;
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
}
