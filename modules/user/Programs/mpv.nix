{
  pkgs,
  config,
  lib,
  ...
}:
let
  theme = config.colorScheme.palette;
in
{
  programs.mpv = {
    enable = true;

    defaultProfiles = [
      "fast"
    ];

    config = {
      ytdl-format = "bestvideo+bestaudio";
      sub-auto = "fuzzy";
      sub-font = "monospace";
      sub-font-size = 36;
      sub-visibility = "no";
      sub-file-paths-appent = "ass:srt:sub:subs:subtitles";

      video-sync = "display-resample";
      interpolation = "yes";
      profile = "gpu-hq";
      gpu-context = "wayland";
      vo = "gpu";
      hwdec = "auto-safe";
      gpu-api = "vulkan";

      input-ipc-server = "/tmp/mpv.sock";

      audio-file-auto = "fuzzy";
      
      term-osd-bar = "yes";
      screenshot-template = "~/Downloads/%{filename/no-ext}/%P";

      osd-font = "monospace";
      osd-font-size = 28;
      osd-duration = 2500;

      cursor-autohide = 1000;
      cursor-autohide-fs-only = "yes";

      background-color = "#${theme.base00}";
      osd-back-color = "#${theme.base01}";
      osd-border-color = "#${theme.base01}";
      osd-color = "#${theme.base05}";
      osd-shadow-color = "#${theme.base00}";

      script-opts-append = [
        "stats-border_color=251818"
        "stats-font_color=f4d6cd"
        "stats-plot_bg_border_color=f7a6cb"
        "stats-plot_bg_color=251818"
        "stats-plot_color=f7a6cb"
        (lib.concatStrings [
          "uosc-color=foreground=${theme.base0E},"
          "foreground_text=${theme.base02},"
          "background =${theme.base00},"
          "background_text=${theme.base05},"
          "curtain=${theme.base01},"
          "success=${theme.base0B},"
          "error=${theme.base08}"
        ])
      ];
    };

    scripts = with pkgs.mpvScripts; [
      mpris
      autoload
    ];
  };
}
