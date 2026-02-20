{
  pkgs,
  config,
  lib,
  ...
}:
let
  tpmDir = "${config.xdg.configHome}/tmux/plugins/tpm";
in
{
  home.activation = {
    installTpm = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Checking for TPM installation..."
      if [ ! -d "${tpmDir}" ]; then
        echo "TPM not found. Cloning repository..."
        ${pkgs.git}/bin/git clone https://github.com/tmux-plugins/tpm "${tpmDir}"
      fi
    '';
  };
}
