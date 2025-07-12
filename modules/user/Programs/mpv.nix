{
  pkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        # If using the 'package' option, 
        # Must use the scripts option inside the wrapper function
        # Not outside.
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
          mpris
        ];
        mpv = pkgs.mpv-unwrapped.override {
          bluraySupport = false;
          x11Support = false;
          waylandSupport = true;
          vdpauSupport = false;
          dvdnavSupport = false;
        };
      }
    );

    config = {
      ytdl-format = "bestvideo+bestaudio";
      sub-auto = "fuzzy";
      # sub-font = "monospace";
      # sub-font-size = 36;
      sub-visibility = "no";
      sub-file-paths-append = "ass:srt:sub:subs:subtitles";

      video-sync = "display-resample";
      interpolation = "yes";
      profile = "gpu-hq";
      # gpu-context = "wayland";
      vo = "gpu";
      hwdec = "auto-safe";
      gpu-api = "vulkan";

      input-ipc-server = "/tmp/mpv.sock";

      audio-file-auto = "fuzzy";

      term-osd-bar = "yes";
      screenshot-template = "~/Downloads/%{filename/no-ext}/%P";

      # osd-font = "monospace";
      # osd-font-size = 28;
      osd-duration = 2500;

      cursor-autohide = 1000;
      cursor-autohide-fs-only = "yes";
    };
  };
}
