_: {
  flake.nixosModules.workstation = {pkgs, ...}: {
    environment.systemPackages = [pkgs.waypipe];
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

  flake.nixosModules.server = _: {
    services = {
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
}
