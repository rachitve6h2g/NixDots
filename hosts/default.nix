{inputs, ...}: {
  flake.nixosConfigurations = let
    mkHost = hostname:
      inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ../modules/core
          ../modules/overlays
          ./${hostname}
        ];
      };
  in {
    hppavilion = mkHost "hppavilion";
  };
}
