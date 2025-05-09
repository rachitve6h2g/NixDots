{
	nixpkgs.overlays = [
		( final: prev: {
			waybar = prev.waybar.override {
				evdevSupport = false;
				# niriSupport = false;
				swaySupport = false;
				traySupport = false;
			};
		})
	];
}
