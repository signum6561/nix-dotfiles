{
  description = "Minimalist Home Manager flake for void-station";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers.url = "github:lassulus/wrappers";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];
      };
    in
    {
      homeConfigurations."dsynclair" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit (inputs) wrappers; };
        modules = [
          catppuccin.homeModules.catppuccin
          ./home.nix
          ../../modules/chezmoi.nix
          ../../modules/tmux.nix
          ../../modules/zsh-plugins.nix
          ../../modules/helix-langs.nix
        ];
      };
    };
}
