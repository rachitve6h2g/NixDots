{
  nix = {
    settings.auto-optimise-store = true;

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };

    optimise = {
      automatic = true;
      dates = ["03:45"];
    };
  };
}
