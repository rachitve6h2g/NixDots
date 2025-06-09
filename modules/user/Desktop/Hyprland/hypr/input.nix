{
  wayland.windowManager.hyprland.settings = {
    input = {
      repeat_rate = 35;
      follow_mouse = true;

      sensitivity = 0;

      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        scroll_factor = 0.5;
        clickfinger_behavior = true;
      };
      special_fallthrough = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_distance = 700;
      workspace_swipe_fingers = 3;
      workspace_swipe_cancel_ratio = 0.2;
      workspace_swipe_direction_lock = true;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_create_new = true;
    };
  };
}
