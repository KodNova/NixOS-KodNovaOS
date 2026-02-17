_: {
  flake.nixosModules = {
    base = _: {
      services = {
        tailscale.enable = true;
      };
    };

    workstation = {pkgs, ...}: {
      environment.systemPackages = [pkgs.veracrypt];
    };

    solModule = {
      networking.firewall = {
        enable = true;
        # NOTE: 5173 is vite web dev, 3000 is for nextjs
        allowedTCPPorts = [
          5173
          3000
        ];
      };
    };

    lunaModule = {
      networking.firewall = {
        enable = true;
        checkReversePath = "loose"; # NOTE: for using tailscale ext servers
        # NOTE: 5173 is vite web dev, 3000 is for nextjs
        allowedTCPPorts = [
          5173
          3000
        ];
      };
    };

    zpmModule = {
      networking.firewall = {
        enable = true;
        # NOTE: [ombi, audibookshelf, plex, syncthing web gui, netdata, ts files, overseerr,]
        allowedTCPPorts = [3579 13378 32400 8384 19999 30033 5055 9696 7878 8989];
        # NOTE: [ts voice]
        allowedUDPPorts = [9987];
      };
    };
  };
}
