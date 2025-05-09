{
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser = prev.qutebrowser.override {
        enableWideVine = true;
        enableVulkan = true;
      };
    })
  ];
}
