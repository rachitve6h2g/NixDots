{
  description = "My experimental flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    # NVF is a better thing
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SDDM Candy Theme
    sddm-sugar-candy-nix = {
      url = "github:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      home-manager,
      nixpkgs,
      sddm-sugar-candy-nix,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      systemSettings = {
        hostname = "nixos";
      };

      # TODO: pass essential variables as arguments in
      # other modules
      userSettings = {
        username = "krish";
        homeDir = "/home/" + userSettings.username;
        nixDotsDir = userSettings.homeDir + "/.dotfiles";

        # TODO: Get a better method to set wallpapers
        wallpapersDir = userSettings.nixDotsDir + "/wallpapers";
      };
    in
    {
      nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };
        modules = [
          ./system

          sddm-sugar-candy-nix.nixosModules.default
          # {
          #   nixpkgs = {
          #     overlays = [
          #       sddm-sugar-candy-nix.overlays.default
          #     ];
          #   };
          # }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userSettings.username} = import ./user;
              extraSpecialArgs = {
                inherit inputs;
                inherit userSettings;
              };
            };
          }
        ];
      };
    };
}
