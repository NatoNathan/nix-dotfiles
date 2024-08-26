{pkgs, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_commit$character";
      right_format = "$all";
    };
  };
}