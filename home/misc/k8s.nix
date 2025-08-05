{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    kubernetes-helm
    kubectl
    argocd
    flux
    k0sctl
  ];

  programs.k9s = {
    enable = true;
  };
}