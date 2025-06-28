{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    kubernetes-helm
    kubectl
    argocd
  ];

  programs.argocd = {
    enable = true;
  };
}