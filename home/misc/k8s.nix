{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    kubernetes-helm
    kubectl
    argocd
    fluxcd
    k0sctl
  ];

  programs.k9s = {
    enable = true;
  };
}
