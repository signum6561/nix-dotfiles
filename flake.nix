{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixgl = {
    #   url = "github:nix-community/nixGL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    flake-parts.url = "github:hercules-ci/flake-parts";

    wrappers.url = "github:lassulus/wrappers";
  };
  outputs =
    { flake-parts, ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-linux"
      ];

      perSystem =
        {
          config,
          self',
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (final: prev: {
                unstable = import inputs.nixpkgs-unstable {
                  inherit system;
                  config = prev.config;
                };
              })
            ];
            config = { };
          };
          legacyPackages = {
            homeConfigurations = {
              "void-station" = inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {
                  wrappers = inputs.wrappers;
                };
                modules = [
                  ./home/void-station.nix
                ];
              };
            };
          };
        };
    };
}
