{ pkgs, ... }: {
  imports =[ ./default.nix ];

  services.ollama.package = pkgs.ollama-cuda;
}