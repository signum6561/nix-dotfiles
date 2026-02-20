{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.chezmoi;
in
{
  options.chezmoi = {
    machineName = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    rc = lib.mkOption {
      type = lib.types.submodule {
        options = {
          zsh = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          helix = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          fastfetch = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          tmux = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          lazygit = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          kitty = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          vesktop = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          waybar = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          rofi = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          fuzzel = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          mako = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          labwc = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          distrobox = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      };
    };
  };

  config = {
    home.packages = with pkgs; [
      unstable.chezmoi
      bitwarden-cli
    ];
    home.file = {
      "${config.xdg.configHome}/chezmoi/chezmoi.toml" = {
        text = ''
          sourceDir = "${config.home.homeDirectory}/.nix-dotfiles"

          [edit]
          apply = true

          [data]
          machine = "${cfg.machineName}"

          [data.rc]
          nix = true
          zsh = ${lib.trivial.boolToString cfg.rc.zsh}
          fastfetch = ${lib.trivial.boolToString cfg.rc.fastfetch}
          tmux = ${lib.trivial.boolToString cfg.rc.tmux}
          helix = ${lib.trivial.boolToString cfg.rc.helix}
          lazygit = ${lib.trivial.boolToString cfg.rc.lazygit}
          kitty = ${lib.trivial.boolToString cfg.rc.kitty}
          vesktop = ${lib.trivial.boolToString cfg.rc.vesktop}
          waybar = ${lib.trivial.boolToString cfg.rc.waybar}
          rofi = ${lib.trivial.boolToString cfg.rc.rofi}
          fuzzel = ${lib.trivial.boolToString cfg.rc.fuzzel}
          mako = ${lib.trivial.boolToString cfg.rc.mako}
          labwc = ${lib.trivial.boolToString cfg.rc.labwc}
          distrobox = ${lib.trivial.boolToString cfg.rc.distrobox}
        '';
        force = true;
      };
    };
  };
}
