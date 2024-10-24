{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home-manager setup
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for Cliphist overlay, see ./home/Sway/miscServies.nix
    cliphist = {
      url = "github:sentriz/cliphist";
      flake = false;
    };

    # Gruvbox GRUB theme
    tartarus-grub = {
      url = "github:AllJavi/tartarus-grub";
      flake = false;
    };

    # Gruvy Bat
    gruvbox-bat = {
      url = "github:molchalin/gruvbox-material-bat";
      flake = false;
    };

    # Nix colors for a good and easy rice
    nix-colors.url = "github:misterio77/nix-colors";

    # Neovim toggleterm plugin by akinsho
    plugin-terminal = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
    } @inputs: let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        mynixos = lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs;};
          modules = [
            ./host
          ];
        };
      };

      # Home-manager configurations go here 
      homeConfigurations = {
        chris = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
