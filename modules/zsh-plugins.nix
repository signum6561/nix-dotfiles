{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.zsh-plugins;
in
{
  options.zsh-plugins = {
    omp = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    zoxide = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    direnv = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    home.packages =
      with pkgs;
      [
        fzf
        fd
        zinit
        eza
      ]
      ++ (lib.optionals cfg.omp [
        oh-my-posh
      ])
      ++ (lib.optionals cfg.zoxide [
        zoxide
      ])
      ++ (lib.optionals cfg.direnv [
        direnv
        nix-direnv
      ]);

    home.sessionVariables = {
      ZINIT_HOME = "${pkgs.zinit}/share/zinit";
    };

    home.file = {
      "${config.home.homeDirectory}/.nix-dotfiles/chezmoi/.chezmoidata/zsh.toml" = {
        text = ''
          [zsh]
          omp = ${lib.trivial.boolToString cfg.omp}
          zoxide = ${lib.trivial.boolToString cfg.zoxide}
          direnv = ${lib.trivial.boolToString cfg.direnv}
        '';
        force = true;
      };
    };
  };
}
