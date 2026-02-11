{inputs, ...}: {
  flake.nixosModules.workstation = {pkgs, ...}: {
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

  flake.nixosModules.server = {pkgs, ...}: {
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
