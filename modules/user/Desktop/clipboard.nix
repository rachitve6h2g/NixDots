{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [wl-clipboard];
  services.cliphist = {
    enable = true;
    allowImages = true;

    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "100"
    ];
  };
  # For making it conform with UWSM
  systemd.user.services = lib.mkForce {
    cliphist = {
      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Unit = {
        Description = "Clipboard history \"manager\" for wayland";
        Documentation = ["https://github.com/sentriz/cliphist"];
        After = ["graphical-session.target"];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist -max-items 10 store";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
    };
  };
}
