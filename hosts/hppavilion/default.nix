{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  services.journald.extraConfig = "SystemMaxUse=50M";
}
