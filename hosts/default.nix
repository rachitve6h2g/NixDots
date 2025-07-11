{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      mkHost =
        hostname:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            inputs.disko.nixosModules.disko
            ../modules/core
            ../modules/overlays
            ./${hostname}
          ];
        };
    in
    {
      hppavilion = mkHost "hppavilion";
    };
}
