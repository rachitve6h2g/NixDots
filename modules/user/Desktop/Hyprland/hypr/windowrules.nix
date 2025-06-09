{
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "tag +file-manager, class:^([Tt]hunar)$"
        "opacity 0.9 0.8, tag:file-manager*"
        "float, class:^([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
      ];
    };
  };
}
