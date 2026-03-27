{
  pkgs,
  ...
}:
let
  catppuccinMacchiatoGtk = pkgs.catppuccin-gtk.override {
    accents = [ "mauve" ];
    variant = "macchiato";
  };
  catppuccinPapirusFolders = pkgs.catppuccin-papirus-folders.override {
    flavor = "macchiato";
    accent = "mauve";
  };
in
{
  home.username = "dsynclair";
  home.homeDirectory = "/home/dsynclair";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    gimp
    rofi
    waypaper
    yq
    glow
    lazygit
    git
    uv
    pipes
    sl
    catppuccinMacchiatoGtk
    catppuccinPapirusFolders
    asciiquarium-transparent
    nodejs_22
    vscode-json-languageserver
    prettier
    unstable.devenv
    unstable.jetbrains-toolbox
  ];

  zsh-plugins = {
    zoxide = true;
    direnv = true;
  };

  chezmoi = {
    machineName = "void-station";
    rc = {
      rofi = true;
      kitty = true;
      waybar = true;
      fastfetch = true;
      vesktop = true;
      labwc = true;
      mako = true;
      lazygit = true;
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bierner.markdown-preview-github-styles
      ];
    };
  };

  programs.home-manager.enable = true;
}
