{inputs, ...}: {
  flake.nixosModules = {
    noctalia = _: {
      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      services.power-profiles-daemon.enable = false;
      services.upower.enable = true;
      programs.noctalia.enable = true;

      # my.home = _: {
      #   imports = [
      #     inputs.noctalia.homeModules.default
      #   ];
      #
      #   home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
      #     defaultWallpaper = "/repos/NixOS-KodNovaOS/wallpaper.png";
      #   };
      #
      #   programs.noctalia = {
      #     enable = true;
      #     settings = {
      #       settingsVersion = 53;
      #       bar = {
      #         barType = "simple";
      #         position = "top";
      #         monitors = [];
      #         density = "comfortable";
      #         showOutline = false;
      #         showCapsule = true;
      #         capsuleOpacity = 1;
      #         capsuleColorKey = "none";
      #         backgroundOpacity = 1;
      #         useSeparateOpacity = true;
      #         floating = false;
      #         marginVertical = 4;
      #         marginHorizontal = 4;
      #         frameThickness = 8;
      #         frameRadius = 12;
      #         outerCorners = true;
      #         hideOnOverview = false;
      #         displayMode = "auto_hide";
      #         autoHideDelay = 500;
      #         autoShowDelay = 150;
      #         widgets = {
      #           left = [
      #             {
      #               displayMode = "alwaysShow";
      #               iconColor = "none";
      #               id = "Network";
      #               textColor = "none";
      #             }
      #             {
      #               displayMode = "onhover";
      #               iconColor = "none";
      #               id = "Bluetooth";
      #               textColor = "none";
      #             }
      #           ];
      #           center = [
      #             {
      #               colorizeDistroLogo = false;
      #               colorizeSystemIcon = "tertiary";
      #               customIconPath = "";
      #               enableColorization = false;
      #               icon = "noctalia";
      #               id = "ControlCenter";
      #               useDistroLogo = false;
      #             }
      #             {
      #               hideWhenZero = false;
      #               hideWhenZeroUnread = false;
      #               iconColor = "none";
      #               id = "NotificationHistory";
      #               showUnreadBadge = true;
      #               unreadBadgeColor = "primary";
      #             }
      #             {
      #               iconColor = "none";
      #               id = "WallpaperSelector";
      #             }
      #           ];
      #           right = [
      #             {
      #               blacklist = [];
      #               chevronColor = "primary";
      #               colorizeIcons = false;
      #               drawerEnabled = true;
      #               hidePassive = false;
      #               id = "Tray";
      #               pinned = [];
      #             }
      #
      #             {
      #               deviceNativePath = "__default__";
      #               displayMode = "graphic";
      #               hideIfIdle = false;
      #               hideIfNotDetected = false;
      #               id = "Battery";
      #               showNoctaliaPerformance = false;
      #               showPowerProfiles = false;
      #             }
      #             {
      #               displayMode = "alwaysShow";
      #               iconColor = "primary";
      #               id = "Volume";
      #               middleClickCommand = "pwvucontrol || pavucontrol";
      #               textColor = "tertiary";
      #             }
      #             {
      #               clockColor = "none";
      #               customFont = "Noto Sans";
      #               formatHorizontal = "HH:mm:ss";
      #               formatVertical = "HH mm - dd MM";
      #               id = "Clock";
      #               tooltipFormat = "HH:mm ddd, MMM dd";
      #               useCustomFont = true;
      #             }
      #             {
      #               displayMode = "forceOpen";
      #               iconColor = "none";
      #               id = "KeyboardLayout";
      #               showIcon = true;
      #               textColor = "none";
      #             }
      #             {
      #               iconColor = "error";
      #               id = "SessionMenu";
      #             }
      #           ];
      #         };
      #         screenOverrides = [];
      #       };
      #       general = {
      #         avatarImage = "/repos/NixOS-KodNovaOS/profile.png";
      #         dimmerOpacity = 0.2;
      #         showScreenCorners = false;
      #         forceBlackScreenCorners = false;
      #         scaleRatio = 1;
      #         radiusRatio = 1;
      #         iRadiusRatio = 1;
      #         boxRadiusRatio = 1;
      #         screenRadiusRatio = 1;
      #         animationSpeed = 1;
      #         animationDisabled = false;
      #         compactLockScreen = false;
      #         lockScreenAnimations = true;
      #         lockOnSuspend = true;
      #         showSessionButtonsOnLockScreen = true;
      #         showHibernateOnLockScreen = false;
      #         enableShadows = true;
      #         shadowDirection = "center";
      #         shadowOffsetX = 0;
      #         shadowOffsetY = 0;
      #         language = "";
      #         allowPanelsOnScreenWithoutBar = true;
      #         showChangelogOnStartup = false;
      #         telemetryEnabled = false;
      #         enableLockScreenCountdown = true;
      #         lockScreenCountdownDuration = 5000;
      #         autoStartAuth = false;
      #         allowPasswordWithFprintd = false;
      #         clockStyle = "digital";
      #         clockFormat = "HH:mm:ss dd.MM.yyyy ";
      #         lockScreenMonitors = [];
      #         lockScreenBlur = 1;
      #         lockScreenTint = 1;
      #         keybinds = {
      #           keyUp = ["Up"];
      #           keyDown = ["Down"];
      #           keyLeft = ["Left"];
      #           keyRight = ["Right"];
      #           keyEnter = ["Return"];
      #           keyEscape = ["Esc"];
      #         };
      #       };
      #       ui = {
      #         fontDefault = "Sans Serif";
      #         fontFixed = "monospace";
      #         fontDefaultScale = 1;
      #         fontFixedScale = 1;
      #         tooltipsEnabled = true;
      #         panelBackgroundOpacity = 0.93;
      #         panelsAttachedToBar = true;
      #         settingsPanelMode = "attached";
      #         wifiDetailsViewMode = "grid";
      #         bluetoothDetailsViewMode = "grid";
      #         networkPanelView = "wifi";
      #         bluetoothHideUnnamedDevices = false;
      #         boxBorderEnabled = false;
      #       };
      #       location = {
      #         name = "Nashville,United States";
      #         weatherEnabled = true;
      #         weatherShowEffects = true;
      #         useFahrenheit = false;
      #         use12hourFormat = false;
      #         showWeekNumberInCalendar = false;
      #         showCalendarEvents = true;
      #         showCalendarWeather = true;
      #         analogClockInCalendar = false;
      #         firstDayOfWeek = -1;
      #         hideWeatherTimezone = false;
      #         hideWeatherCityName = true;
      #       };
      #       calendar = {
      #         cards = [
      #           {
      #             enabled = true;
      #             id = "calendar-header-card";
      #           }
      #           {
      #             enabled = true;
      #             id = "calendar-month-card";
      #           }
      #           {
      #             enabled = true;
      #             id = "weather-card";
      #           }
      #         ];
      #       };
      #       wallpaper = {
      #         enabled = true;
      #         overviewEnabled = false;
      #         directory = "/home/kodnova/Pictures/Wallpapers";
      #         monitorDirectories = [];
      #         enableMultiMonitorDirectories = false;
      #         showHiddenFiles = false;
      #         viewMode = "single";
      #         setWallpaperOnAllMonitors = true;
      #         fillMode = "crop";
      #         fillColor = "#000000";
      #         useSolidColor = false;
      #         solidColor = "#1a1a2e";
      #         automationEnabled = false;
      #         wallpaperChangeMode = "random";
      #         randomIntervalSec = 300;
      #         transitionDuration = 2000;
      #         transitionType = "random";
      #         skipStartupTransition = false;
      #         transitionEdgeSmoothness = 0.05;
      #         panelPosition = "follow_bar";
      #         hideWallpaperFilenames = false;
      #         overviewBlur = 0.4;
      #         overviewTint = 0.6;
      #         useWallhaven = true;
      #         wallhavenQuery = "nixos";
      #         wallhavenSorting = "relevance";
      #         wallhavenOrder = "desc";
      #         wallhavenCategories = "111";
      #         wallhavenPurity = "100";
      #         wallhavenRatios = "";
      #         wallhavenApiKey = "";
      #         wallhavenResolutionMode = "atleast";
      #         wallhavenResolutionWidth = "";
      #         wallhavenResolutionHeight = "";
      #         sortOrder = "name";
      #         favorites = [];
      #       };
      #       appLauncher = {
      #         enableClipboardHistory = false;
      #         autoPasteClipboard = false;
      #         enableClipPreview = true;
      #         clipboardWrapText = true;
      #         clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
      #         clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
      #         position = "top_center";
      #         pinnedApps = [];
      #         useApp2Unit = false;
      #         sortByMostUsed = true;
      #         terminalCommand = "alacritty -e";
      #         customLaunchPrefixEnabled = false;
      #         customLaunchPrefix = "";
      #         viewMode = "grid";
      #         showCategories = true;
      #         iconMode = "native";
      #         showIconBackground = false;
      #         enableSettingsSearch = true;
      #         enableWindowsSearch = true;
      #         enableSessionSearch = true;
      #         ignoreMouseInput = true;
      #         screenshotAnnotationTool = "";
      #         overviewLayer = false;
      #         density = "default";
      #       };
      #       controlCenter = {
      #         position = "close_to_bar_button";
      #         diskPath = "/";
      #         shortcuts = {
      #           left = [
      #             {id = "WallpaperSelector";}
      #             {id = "NoctaliaPerformance";}
      #             {id = "PowerProfile";}
      #           ];
      #           right = [
      #             {id = "KeepAwake";}
      #             {id = "Network";}
      #             {id = "NightLight";}
      #             {id = "Notifications";}
      #           ];
      #         };
      #         cards = [
      #           {
      #             enabled = true;
      #             id = "profile-card";
      #           }
      #           {
      #             enabled = true;
      #             id = "shortcuts-card";
      #           }
      #           {
      #             enabled = true;
      #             id = "audio-card";
      #           }
      #           {
      #             enabled = false;
      #             id = "brightness-card";
      #           }
      #           {
      #             enabled = false;
      #             id = "weather-card";
      #           }
      #           {
      #             enabled = true;
      #             id = "media-sysmon-card";
      #           }
      #         ];
      #       };
      #       systemMonitor = {
      #         cpuWarningThreshold = 80;
      #         cpuCriticalThreshold = 90;
      #         tempWarningThreshold = 80;
      #         tempCriticalThreshold = 90;
      #         gpuWarningThreshold = 80;
      #         gpuCriticalThreshold = 90;
      #         memWarningThreshold = 80;
      #         memCriticalThreshold = 90;
      #         swapWarningThreshold = 80;
      #         swapCriticalThreshold = 90;
      #         diskWarningThreshold = 80;
      #         diskCriticalThreshold = 90;
      #         diskAvailWarningThreshold = 20;
      #         diskAvailCriticalThreshold = 10;
      #         batteryWarningThreshold = 20;
      #         batteryCriticalThreshold = 5;
      #         cpuPollingInterval = 2000;
      #         gpuPollingInterval = 3000;
      #         enableDgpuMonitoring = false;
      #         memPollingInterval = 3000;
      #         diskPollingInterval = 30000;
      #         networkPollingInterval = 1500;
      #         loadAvgPollingInterval = 3000;
      #         useCustomColors = false;
      #         warningColor = "#9bfece";
      #         criticalColor = "#fd4663";
      #         externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      #       };
      #       dock = {
      #         enabled = false;
      #         position = "bottom";
      #         displayMode = "auto_hide";
      #         backgroundOpacity = 1;
      #         floatingRatio = 1;
      #         size = 1;
      #         onlySameOutput = true;
      #         monitors = [];
      #         pinnedApps = [];
      #         colorizeIcons = false;
      #         pinnedStatic = false;
      #         inactiveIndicators = false;
      #         deadOpacity = 0.6;
      #         animationSpeed = 1;
      #       };
      #       network = {
      #         wifiEnabled = true;
      #         bluetoothRssiPollingEnabled = false;
      #         bluetoothRssiPollIntervalMs = 10000;
      #         wifiDetailsViewMode = "grid";
      #         bluetoothDetailsViewMode = "grid";
      #         bluetoothHideUnnamedDevices = false;
      #       };
      #       sessionMenu = {
      #         enableCountdown = false;
      #         countdownDuration = 5000;
      #         position = "center";
      #         showHeader = true;
      #         largeButtonsStyle = true;
      #         largeButtonsLayout = "single-row";
      #         powerOptions = [
      #           {
      #             action = "lock";
      #             command = "";
      #             countdownEnabled = true;
      #             enabled = true;
      #             keybind = "1";
      #           }
      #           {
      #             action = "suspend";
      #             command = "";
      #             countdownEnabled = true;
      #             enabled = true;
      #             keybind = "2";
      #           }
      #           {
      #             action = "reboot";
      #             command = "";
      #             countdownEnabled = true;
      #             enabled = true;
      #             keybind = "3";
      #           }
      #           {
      #             action = "logout";
      #             command = "";
      #             countdownEnabled = true;
      #             enabled = true;
      #             keybind = "4";
      #           }
      #           {
      #             action = "shutdown";
      #             command = "";
      #             countdownEnabled = true;
      #             enabled = true;
      #             keybind = "5";
      #           }
      #           {
      #             action = "hibernate";
      #             command = "";
      #             countdownEnabled = true;
      #             enabled = false;
      #             keybind = "";
      #           }
      #         ];
      #       };
      #       notifications = {
      #         enabled = true;
      #         monitors = [];
      #         location = "top_right";
      #         overlayLayer = true;
      #         backgroundOpacity = 1;
      #         respectExpireTimeout = false;
      #         lowUrgencyDuration = 3;
      #         normalUrgencyDuration = 8;
      #         criticalUrgencyDuration = 15;
      #         saveToHistory = {
      #           low = false;
      #           normal = true;
      #           critical = true;
      #         };
      #         sounds = {
      #           enabled = false;
      #           volume = 0.5;
      #           separateSounds = false;
      #           criticalSoundFile = "";
      #           normalSoundFile = "";
      #           lowSoundFile = "";
      #           excludedApps = "discord,firefox,chrome,chromium,edge";
      #         };
      #         enableMediaToast = false;
      #         enableKeyboardLayoutToast = true;
      #         enableBatteryToast = true;
      #       };
      #       osd = {
      #         enabled = true;
      #         location = "top_right";
      #         autoHideMs = 2000;
      #         overlayLayer = true;
      #         backgroundOpacity = 1;
      #         enabledTypes = [0 1 2 3];
      #         monitors = [];
      #       };
      #       audio = {
      #         volumeStep = 5;
      #         volumeOverdrive = false;
      #         cavaFrameRate = 30;
      #         visualizerType = "linear";
      #         mprisBlacklist = [];
      #         preferredPlayer = "";
      #         volumeFeedback = false;
      #       };
      #       brightness = {
      #         brightnessStep = 5;
      #         enforceMinimum = true;
      #         enableDdcSupport = false;
      #       };
      #       colorSchemes = {
      #         useWallpaperColors = false;
      #         predefinedScheme = "Catppuccin";
      #         darkMode = true;
      #         schedulingMode = "off";
      #         manualSunrise = "06:30";
      #         manualSunset = "18:30";
      #         generationMethod = "tonal-spot";
      #         monitorForColors = "";
      #       };
      #       templates = {
      #         activeTemplates = [
      #           {
      #             enabled = true;
      #             id = "btop";
      #           }
      #           {
      #             enabled = true;
      #             id = "hyprland";
      #           }
      #           {
      #             enabled = true;
      #             id = "gtk";
      #           }
      #           {
      #             enabled = true;
      #             id = "qt";
      #           }
      #         ];
      #         enableUserTheming = false;
      #       };
      #       nightLight = {
      #         enabled = false;
      #         forced = false;
      #         autoSchedule = true;
      #         nightTemp = "4000";
      #         dayTemp = "6500";
      #         manualSunrise = "06:30";
      #         manualSunset = "18:30";
      #       };
      #       hooks = {
      #         enabled = false;
      #         wallpaperChange = "";
      #         darkModeChange = "";
      #         screenLock = "";
      #         screenUnlock = "";
      #         performanceModeEnabled = "";
      #         performanceModeDisabled = "";
      #         startup = "";
      #         session = "";
      #       };
      #       plugins = {
      #         autoUpdate = false;
      #       };
      #     };
      #  };
    };
  };

  # solModule = _: {
  #   my.home = {
  #     programs.noctalia.settings = {
  #       desktopWidgets = {
  #         enabled = true;
  #         gridSnap = false;
  #         monitorWidgets = [
  #           {
  #             name = "HDMI-A-1";
  #             widgets = [];
  #           }
  #           {
  #             name = "DVI-D-1";
  #             widgets = [];
  #           }
  #           {
  #             name = "DP-2";
  #             widgets = [
  #               {
  #                 hideMode = "hidden";
  #                 id = "MediaPlayer";
  #                 roundedCorners = true;
  #                 scale = 1.0848528137423856;
  #                 showAlbumArt = true;
  #                 showBackground = true;
  #                 showButtons = true;
  #                 showVisualizer = true;
  #                 visualizerType = "linear";
  #                 x = 0;
  #                 y = 40;
  #               }
  #               {
  #                 clockColor = "secondary";
  #                 clockStyle = "minimal";
  #                 customFont = "Hack Nerd Font";
  #                 format = "HH:mm\\nd MMMM yyyy";
  #                 id = "Clock";
  #                 roundedCorners = true;
  #                 scale = 1.5232590180780452;
  #                 showBackground = true;
  #                 useCustomFont = true;
  #                 x = 2280;
  #                 y = 40;
  #               }
  #             ];
  #           }
  #         ];
  #       };
  #     };
  #   };
  # };

  # lunaModule = _: {
  #   my.home = {
  #     programs.noctalia.settings = {
  #       desktopWidgets = {
  #         enabled = true;
  #         gridSnap = false;
  #         monitorWidgets = [
  #           {
  #             name = "eDP-1";
  #             widgets = [
  #               {
  #                 hideMode = "hidden";
  #                 id = "MediaPlayer";
  #                 roundedCorners = true;
  #                 scale = 1.0848528137423856;
  #                 showAlbumArt = true;
  #                 showBackground = true;
  #                 showButtons = true;
  #                 showVisualizer = true;
  #                 visualizerType = "linear";
  #                 x = 20;
  #                 y = 40;
  #               }
  #               {
  #                 clockColor = "none";
  #                 clockStyle = "minimal";
  #                 customFont = "Hack Nerd Font";
  #                 format = "HH:mm\\nd MMMM yyyy";
  #                 id = "Clock";
  #                 roundedCorners = true;
  #                 showBackground = true;
  #                 useCustomFont = true;
  #                 x = 1368;
  #                 y = 48;
  #               }
  #             ];
  #           }
  #         ];
  #       };
  #     };
  #   };
  # };
  # };
}
