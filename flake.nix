{
  description = "My experimental flake";

  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    home-manager = {
      url = "github:nix-community/home-manager"; # The nixpkgs version and home-manager version should be same
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland plugins fix
    # Remove this once it's fixed
    # Refer https://github.com/hyprwm/hyprland-plugins/pull/338/files (CShader replaced by SShader)
    #hyprlandPlugins = {
    #  url = "github:hyprwm/hyprland-plugins/c491d2831448645f24a1597a17f564aa52691ac6";
    #  flake = false;
    #};

    niri-flake.url = "github:sodiboo/niri-flake";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix"; # use "github:nix-community/stylix" for stable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      imports = [
        ./hosts
        ./modules/treefmt/flake-module.nix
        inputs.git-hooks-nix.flakeModule
        inputs.home-manager.flakeModules.home-manager
      ];

      perSystem =
        {
          pkgs,
          # system,
          ...
        }:
        {
          pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
