{
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser = prev.qutebrowser.override {
        enableWideVine = true;
        withPdfReader = false;
        enableVulkan = true; # Was causing problem in execution and closing of app
      };
    })
  ];
}
