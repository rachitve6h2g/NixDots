{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # The ricing part is new
    nix-colors.url = "github:misterio77/nix-colors";

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

    # Catppuccin btop theme
    btop-catppuccin = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    # Enabling hyprland thru this
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    # Some basic plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # NixVim
    nixvim = {
    	url = "github:nix-community/nixvim";
	inputs.nixpkgs.follows = "nixpkgs";
    };

    # Latest yazi package
    yazi.url = "github:sxyazi/yazi";

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

    # A good Display manager is always important
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # This is gonna be the coolest 
    ags.url = "github:aylur/ags";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    sddm-sugar-candy-nix,
    ...
  } @ inputs: let
    hostname = "nixprime";
  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
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
