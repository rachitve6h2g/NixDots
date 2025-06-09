{ inputs, ... }:
{
  # Refer https://yazi-rs.github.io/docs/installation/
  # Home-manager options
  nixpkgs.overlays = [
    inputs.yazi.overlays.default
  ];
}
