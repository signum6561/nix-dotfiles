{
  pkgs,
  ...
}:
{
  home.username = "dsynclair";
  home.homeDirectory = "/home/dsynclair";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    gimp
    fuzzel
    waypaper
    devenv
    nodejs_24
    yq
    glow
    claude-code
    lazygit
    git
    pods
    uv
  ];

  zsh-plugins = {
    zoxide = true;
    direnv = true;
  };

  chezmoi = {
    machineName = "void-station";
    rc = {
      kitty = true;
      waybar = true;
      fastfetch = true;
      vesktop = true;
      fuzzel = true;
      labwc = true;
      mako = true;
      lazygit = true;
    };
  };

  programs.home-manager.enable = true;
}
