_: {
  flake.nixosModules.base = _: {
    my.home = {
      programs.zellij = {
        enable = true;
        enableZshIntegration = false;
        # don't set settings or themes here
      };

      xdg.configFile."zellij/config.kdl".text = ''
        theme "catppuccin-mocha"

        keybinds {
          shared_among "scroll" "search" {
            bind "PageDown" { PageScrollDown; }
            bind "PageUp" { PageScrollUp; }
            bind "left" { PageScrollUp; }
            bind "down" { ScrollDown; }
            bind "up" { ScrollUp; }
            bind "right" { PageScrollDown; }
            bind "Ctrl b" { PageScrollUp; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
            bind "d" { HalfPageScrollDown; }
            bind "Ctrl s" { PageScrollDown; }
            bind "h" { PageScrollUp; }
            bind "j" { ScrollDown; }
            bind "k" { ScrollUp; }
            bind "l" { PageScrollDown; }
            bind "Ctrl f" { SwitchToMode "normal"; }
            bind "u" { HalfPageScrollUp; }
          }
        }
      '';
    };
  };
}
