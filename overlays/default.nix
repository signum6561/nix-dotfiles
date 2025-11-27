{ inputs, ... }:
{
  unstable-overlay = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = prev.config;
    };
  };
}
