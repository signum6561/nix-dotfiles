{
  pkgs,
  ...
}:
{
  home.username = "dsynclair";
  home.homeDirectory = "/home/dsynclair";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    gimp
    rofi
    waypaper
    nodejs_24
    yq
    glow
    lazygit
    git
    uv
    pipes
    sl
    asciiquarium-transparent
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
        catppuccin.catppuccin-vsc-icons
        catppuccin.catppuccin-vsc
        bierner.markdown-preview-github-styles
      ];
    };
  };

  programs.home-manager.enable = true;
}
