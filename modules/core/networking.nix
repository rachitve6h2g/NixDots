{
  networking = {
    hostName = "hp_pavilion"; # Define your hostname.
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };
}
