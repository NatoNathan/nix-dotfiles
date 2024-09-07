{ ... }: 
let
  spotify.tcpPort = 57621;
  spotify.udpPort = 5353;
in 
{
  networking.firewall.allowedTCPPorts = [ spotify.tcpPort ];
  networking.firewall.allowedUDPPorts = [ spotify.udpPorts ];
}