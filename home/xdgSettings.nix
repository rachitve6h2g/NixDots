{config, ...}: {
  xdg = let
    homeDir = config.home.homeDirectory;
  in {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "${homeDir}/Desktop";
      documents = "${homeDir}/Documents";
      download = "${homeDir}/Internet";
      music = "${homeDir}/Music";
      pictures = "${homeDir}/Pictures";
      videos = "${homeDir}/Videos";
    };

    # Mime type settings
    mime = {
      enable = true;
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
    };
  };
}
