{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableLsColors = true;
    autosuggestions = {
      enable = true;
      strategy = [
        "completion"
      ];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.chris = {
      isNormalUser = true;
      extraGroups = ["wheel" "input" "video" "networkmanager"]; # Enable ‘sudo’ for the user.
      home = "/home/chris";
      description = "Rachit Kumar Verma";
      name = "chris";
      createHome = true;
    };
  };
}
