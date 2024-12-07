{ ... }: {
  services.keyd = {
  enable = true;
  keyboards = {
    # The name is just the name of the configuration file, it does not really matter
    default = {
      ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
      # Everything but the ID section:
      settings = {
        # The main layer, if you choose to declare it in Nix
        main = {
          capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
        };
      };
    };
  };
};

 environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

}