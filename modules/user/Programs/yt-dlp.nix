{ config, ... }: {
  programs = {
    yt-dlp = {
      enable = true;
      settings = {
        embed-thumbnail = true;
        add-metadata = true;
        output = "~/Videos/%(title)s.%(ext)s";
        # downloader = "aria2c";
        # See https://wiki.archlinux.org/title/Aria2#Changing_the_User_Agent
        # The user agent has to be changed for better compatibility
        # downloader-args = "aria2c:'-c -j 3 -x 3 -s 3 -k 1M'";
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
        # user-agent = "Wget";
        file-allocation = "none";
        max-connection-per-server = 4;
        min-split-size = "5M";
        log-level="warn";
      };
    };
  };
}
