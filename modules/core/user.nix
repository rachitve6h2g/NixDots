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
        stateVersion = "24.11";
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
    description = "Rachit Kumar Verma";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "video"
      "audio"
    ];
    initialPassword = "Shouvik@1234";

    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # Refer https://mynixos.com/home-manager/option/programs.zsh.enableCompletion
  environment.pathsToLink = [ "/share/zsh" ];
}
