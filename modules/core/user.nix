{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.krish = {
      imports = [ ../user ];
      home = {
        username = "krish";
        homeDirectory = "/home/krish";
        stateVersion = "25.05";
        enableNixpkgsReleaseCheck = true;
      };
      programs.home-manager.enable = true;
    };
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.krish = {
    isNormalUser = true;
    createHome = true;
    home = "/home/krish";
    group = "users";
    description = "Rachit Kumar Verma";
    extraGroups = [
      "wheel"
      "input"
      "video"
      "audio"
      "systemd-journal"
    ];
    initialPassword = "Shouvik@1234";

    shell = pkgs.nushell;
  };
  environment.shells = [ pkgs.nushell ];
}
