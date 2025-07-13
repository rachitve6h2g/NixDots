{ config, ... }:
{
  services = {
    mpd = {
      enable = true;

      musicDirectory = "${config.xdg.userDirs.music}";
      dbFile = "${config.xdg.configHome}/mpd/database";
      playlistDirectory = "${config.xdg.configHome}/mpd/playlists";

      network = {
        listenAddress = "any";
        startWhenNeeded = true;
      };

      extraConfig = ''
        audio_output {
          type "pipewire"
          name  "PipeWire Sound Support"
        }
      '';
    };
  };

  programs = {
    rmpc = {
      enable = true;
      # config = ''${builtins.readFile ./config.ron}'';
    };
    cava.enable = true;
  };
  
  xdg.configFile."rmpc/themes/rose-pine.ron".text = ''
  '';
  
  stylix.targets.cava.rainbow.enable = true;
}
