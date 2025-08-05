{ pkgs, lib, ... }:
let 
  cargoEnvExtra = if pkgs.system == "x86_64-darwin" then ". ~/.cargo/env" else "";
  fnmEnvExtra = if pkgs.system == "x86_64-darwin" then ''eval "$(fnm env --use-on-cd --version-file-strategy=recursive --resolve-engines --corepack-enabled --shell zsh)"'' else "";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    envExtra = ''
      ${cargoEnvExtra}
    '';

    initContent = lib.mkBefore ''
      ${fnmEnvExtra}
    '';
  };
}
