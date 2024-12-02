{ pkgs, ... }:
{
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    audio.enable = true;
    enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
  };
}
