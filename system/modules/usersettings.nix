{ pkgs, ... }: {

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.krish = {
    isNormalUser = true;
    description = "Rachit Kumar Verma";
    extraGroups = [ "networkmanager" "wheel" "input" "video" "audio" ];

    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}
