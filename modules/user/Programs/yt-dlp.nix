{ config, ... }: {
  programs = {
    yt-dlp = {
      enable = true;
      settings = {
        embed-thumbnail = true;
        add-metadata = true;
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
        format = "bestvideo+bestaudio/best";
      };
    };

    # Aria2 in yt-dlp manages itself.
    # If you enable this, ~/.config/aria2/config will
    # be created which will interfere with other tasks.

    aria2 = {
      enable = true;
      settings = {
        continue = true;
        dir = "${config.xdg.userDirs.download}";
        file-allocation = "none";
        max-connection-per-server = 4;
        min-split-size = "5M";
        log-level="warn";
      };
    };
  };
}
