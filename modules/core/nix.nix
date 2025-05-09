{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser-overlay = prev.qutebrowser.override {
        enableWideVine = true;
        enableVulkan = true;
      };
    })
  ];
}
