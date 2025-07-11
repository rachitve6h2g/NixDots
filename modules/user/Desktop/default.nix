{ osConfig, lib, ... }:
{
  # wayland.systemd.target = "graphical-session.target";
  imports = [
    # ./Hyprland
    ./Niri
    # ./Sway

    ./clipboard.nix
    ./dconf.nix
    ./mako.nix
    ./poweralertd.nix
    ./theme.nix
    ./wlsunset.nix
    ./wofi.nix
  ];

  programs.zsh.profileExtra = lib.mkIf (osConfig.programs.uwsm.enable)
  #bash
  ''
    if uwsm check may-start && uwsm select; then
      exec systemd-cat -t uwsm_start uwsm start default
    fi
  '';
}
