{ inputs, ... }:
{
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
}
