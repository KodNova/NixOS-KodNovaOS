{...}: {
  flake.nixosModules.workstation = {...}: {
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

  flake.nixosModules.server = {...}: {
    services = {
      openssh = {
        enable = true;
        ports = [2222];
        settings = {
          PermitRootLogin = "without-password";
          PasswordAuthentication = false;
        };
      };
    };
  };
}
