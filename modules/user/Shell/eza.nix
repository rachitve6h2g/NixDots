{
  programs.eza = {
    enable = true;

    enableZshIntegration = true;

    git = true;
    icons = "auto";
    colors = "auto";

    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
