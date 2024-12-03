{pkgs, ...}: {
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
      settings = {
        General = {
          Experimental = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
