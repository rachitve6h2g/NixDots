{
  description = "My experimental flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";
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
        inputs.git-hooks-nix.flakeModule
      ];

      perSystem =
        { pkgs, ... }:
        {
          pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
          formatter = pkgs.nixfmt-rfc-style;
        };
      flake = {
        formatter = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      };
    };
}
