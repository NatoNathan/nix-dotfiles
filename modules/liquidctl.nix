{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [pkgs.liquidctl];

  # Setup systemd service to run liquidctl on boot
  systemd.services.liquidctl = {
    description = "Liquidctl service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ["${pkgs.liquidctl}/bin/liquidctl initialize all"];
    };
  };

}
