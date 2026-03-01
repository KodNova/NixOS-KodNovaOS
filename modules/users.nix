_: {
  flake.nixosModules = {
    solModule = {
      pkgs,
      config,
      ...
    }: {
      my = {
        username = "kodnova";
        email = "Dev@KodNova.dev";
      };

      users.mutableUsers = false;
      users.users.${config.my.username} = {
        isNormalUser = true;
        description = config.my.username;
        # WARN: placeholder password
        hashedPassword = "$y$j9T$aK/y4/XGb2iKqAEyjyXI70$yLczsgiS6cWz/U6JMlPHa2OVyYTnY52hmOGBx8s42cB";
        extraGroups = ["networkmanager" "wheel" "scanner" "lp" "libvirtd" "video" "render" "input"];
        shell = pkgs.zsh;
      };
    };

    lunaModule = {
      pkgs,
      config,
      ...
    }: {
      my = {
        username = "kodnova";
        email = "Dev@KodNova.dev";
      };

      users.mutableUsers = false;
      users.users.${config.my.username} = {
        isNormalUser = true;
        description = config.my.username;
        # WARN: placeholder password
        hashedPassword = "$y$j9T$aK/y4/XGb2iKqAEyjyXI70$yLczsgiS6cWz/U6JMlPHa2OVyYTnY52hmOGBx8s42cB";
        extraGroups = ["networkmanager" "wheel" "lp" "libvirtd" "video" "render"];
        shell = pkgs.zsh;
      };
    };

    zpmModule = {
      pkgs,
      config,
      ...
    }: {
      my = {
        username = "kodnova";
        email = "Dev@KodNova.dev";
      };

      users.mutableUsers = false;
      users.users.${config.my.username} = {
        isNormalUser = true;
        description = config.my.username;
        # WARN: placeholder password
        hashedPassword = "$y$j9T$aK/y4/XGb2iKqAEyjyXI70$yLczsgiS6cWz/U6JMlPHa2OVyYTnY52hmOGBx8s42cB";
        extraGroups = ["networkmanager" "wheel" "docker" "lp" "libvirtd" "video" "render"];
        shell = pkgs.zsh;
      };
    };
  };
}
