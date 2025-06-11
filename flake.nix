{
  description = "My experimental flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager"; # The nixpkgs version and home-manager version should be same
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    battery-notifier = {
      url = "github:luisnquin/battery-notifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    # Refer https://yazi-rs.github.io/docs/installation/
    # Home-manager method
    yazi.url = "github:sxyazi/yazi";

    # Hyprland plugins fix
    # Remove this once it's fixed
    # Refer https://github.com/hyprwm/hyprland-plugins/pull/338/files (CShader replaced by SShader)
    hyprlandPlugins = {
      url = "github:hyprwm/hyprland-plugins/c491d2831448645f24a1597a17f564aa52691ac6";
      flake = false;
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
        inputs.git-hooks-nix.flakeModule
      ];

      perSystem =
        {
          pkgs,
          ...
        }:
        {
          pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
          formatter = pkgs.nixfmt-rfc-style;
        };
      flake = {
        formatter = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      };
    };
}
