_: {
  flake.nixosModules = {
    workstation = {pkgs, ...}: {
      environment.systemPackages = [pkgs.waypipe];
    };

    sol = _: {
      services = {
        # WARN:ssh enabled
        openssh = {
          enable = true;
          ports = [2222];
          settings = {
            PermitRootLogin = "without-password";
            PasswordAuthentication = true;
          };
        };
      };
    };

    luna = _: {
      services = {
        openssh = {
          enable = false;
          ports = [2222];
          settings = {
            PermitRootLogin = "without-password";
            PasswordAuthentication = true;
          };
        };
      };
    };

    server = _: {
      services = {
        openssh = {
          # WARN:ssh enabled
          enable = true;
          ports = [2222];
          settings = {
            PermitRootLogin = "without-password";
            PasswordAuthentication = true;
          };
        };
      };
    };
  };
}
