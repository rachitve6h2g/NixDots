{
  networking = {
    # Refer this https://mynixos.com/nixpkgs/option/networking.hostName
    # For properly setting your hostname
    hostName = "hppavilion"; # Define your

    useHostResolvConf = false;
    useDHCP = false;
    useNetworkd = true;

    wireless.iwd = {
      enable = true;
      settings = {
        Settings = {
          AutoConnect = true;
        };
      };
    };
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
  };

  services = {
    gnome.gnome-keyring.enable = true;

    resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
      ];
      dnsovertls = "true";
    };
  };

  systemd = {
    network = {
      enable = true;
      links = {
        # Disable the default '80-iwd.link'
        "80-iwd".enable = false;
      };

      networks = {
        "80-wireless" = {
          enable = true;
          matchConfig = {
            Name = "wlan0";
          };
          linkConfig = {
            RequiredForOnline = "routable";
          };
          networkConfig = {
            DHCP = "yes";
            IgnoreCarrierLoss = "3s";
          };
        };
      };
    };
  };
}
