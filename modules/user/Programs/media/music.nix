{ config, pkgs, ... }:
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

        audio_output {
          type "fifo"
          name "my_fifo"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };

    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };
  };

  programs = {
    rmpc = {
      enable = true;
      # config = ''${builtins.readFile ./config.ron}'';
    };
    cava = { 
      enable = true; 
      package = pkgs.cava.override { withSDL2 = true; };
      settings = {
        general = {
          framerate = 60;
          autosens = 1;
          sensitivity = 100;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;

          bar_width = 0.5;
        };
        input = {
          method = "fifo";
          source = "/tmp/mpd.fifo";
          sample_rate = 44100;
          channels = 2;
          sample_bits = 16;
        };

        output = {
          method = "ncurses";
        };

        smoothing = {
          monstercat = 1;
          waves = 1;
          noise_reduction = 88;
        };
      };
    };
  };
  
  # xdg.configFile."rmpc/themes/rose-pine.ron".text = ''
  # '';
  
  stylix.targets.cava.rainbow.enable = true;
}
