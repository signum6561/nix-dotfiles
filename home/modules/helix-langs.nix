{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.helix-langs;
in
{
  options = {
    helix-langs = {
      nixLsp = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install nil and nixfmt";
      };

      typosLsp = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to install typos-lsp";
      };
    };
  };

  config = {
    home.packages =
      [ ]
      ++ (lib.optionals cfg.nixLsp [
        pkgs.nil
        pkgs.unstable.nixfmt
      ])
      ++ (lib.optionals cfg.typosLsp [ pkgs.typos-lsp ]);
  };
}
