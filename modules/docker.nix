{...}:{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    # Enable rootless mode
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}