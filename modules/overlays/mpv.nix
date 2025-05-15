{
  nixpkgs.overlays = [
    (final: prev: {
      mpv-unwrapped = prev.mpv-unwrapped.override {
        bluraySupport = false;
        x11Support = false;
        waylandSupport = true;
        vdpauSupport = false;
        dvdnavSupport = false;
      };
    })
  ];
}
