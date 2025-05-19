{ inputs, ... }:
{
  # Refer https://yazi-rs.github.io/docs/installation/
  # Home-manager options
  nix.settings = {
    extra-substituters = [ "https://yazi.cachix.org" ];
    extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
  };
  nixpkgs.overlays = [
    inputs.yazi.overlays.default
  ];
}
