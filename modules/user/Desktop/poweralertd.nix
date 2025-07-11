{ lib, pkgs, ... }:
{
  services.poweralertd = {
    enable = true;
  };

  systemd.user.services.poweralertd = {
    Unit.After = lib.mkForce [ "graphical-session.target" ];
    Service = {
      Type = lib.mkForce "exec";
      ExecCondition = lib.mkForce "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"niri:sway\" \"\" ";
      Slice = lib.mkForce "app-graphical.slice";
    };
  };
}
