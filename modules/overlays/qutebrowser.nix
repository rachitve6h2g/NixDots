{
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser = prev.qutebrowser.override {
        enableWideVine = true;
        enableVulkan = false; # Was causing problem in execution and closing of app
      };
    })
  ];
}
