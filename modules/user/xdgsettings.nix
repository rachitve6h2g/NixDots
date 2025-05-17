{ config, ... }:
{
  home.preferXdgDirectories = true;
  xdg = {
    enable = true;
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";

    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;

      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura-pdf.desktop";
      };
    };

    systemDirs = {
      data = [
        "/usr/share"
        "/usr/local/share"
      ];

      config = [ "/etc/xdg" ];
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
