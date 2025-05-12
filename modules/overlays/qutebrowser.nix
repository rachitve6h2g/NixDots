{
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser = prev.qutebrowser.override {
        enableWideVine = true;
        # enableVulkan = true; # Was causing problem in execution and closing of app
      };
    })
  ];
}
