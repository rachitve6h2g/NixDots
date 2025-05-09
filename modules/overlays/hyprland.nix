{
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = prev.hyprland.override {
	enableXWayland = false;
      };
    })
  ];
}
