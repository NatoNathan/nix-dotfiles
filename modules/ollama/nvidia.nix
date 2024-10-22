{ ... }: {
  imports =[ ./default.nix ];

  services.ollama.acceleration = "cuda";
}