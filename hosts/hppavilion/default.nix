{
  imports = [
    ./hardware-configuration.nix
    # ./disko-config.nix
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  services.journald.extraConfig = "SystemMaxUse=50M";
}
