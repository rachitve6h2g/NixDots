{
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };
}
