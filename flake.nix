{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # The ricing part is new
    stylix = {
      url = "github:danth/stylix";
    };

    # Home-Manager configuration here
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for nix formatting
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Enabling hyprland thru this
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    # Yazi plugins
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    # Yazi flavors
    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };

    # Let's use the NixVim distro
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A good Display manager is always important
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    stylix,
    nixvim,
    sddm-sugar-candy-nix,
    ...
  } @ inputs: let
    hostname = "NixOSbtw";
  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        # Ricing using stylix.
        stylix.nixosModules.stylix

        # Importing the configuration.nix
        ./host

        # The good formatter
        # Will shift to nixfmt with treefmt once
        # I learn to use it.
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }

        # Add sugar-candy and its overlays
        sddm-sugar-candy-nix.nixosModules.default
        {
          nixpkgs = {
            overlays = [
              sddm-sugar-candy-nix.overlays.default
            ];
          };
        }
        # Using home-manager module as a NixOS module is better
        # For pure NixOS distro
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.chris = import ./home;
            extraSpecialArgs = {inherit inputs;};
          };
        }
      ];
    };
  };
}
