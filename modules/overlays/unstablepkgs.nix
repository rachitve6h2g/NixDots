{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
    })
  ];
}
