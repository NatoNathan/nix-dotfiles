{ pkgs, ... }:
let
  op-sock = {
    x86_64-linux = "~/.1password/agent.sock";
    x86_64-darwin = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };
  onePassPath = op-sock.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      identityAgent = onePassPath;
    };
  };
}
