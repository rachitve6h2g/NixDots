{
  networking = {
    # Refer this https://mynixos.com/nixpkgs/option/networking.hostName
    # For properly setting your hostname
    hostName = "hppavilion"; # Define your

    useHostResolvConf = false;

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
}
