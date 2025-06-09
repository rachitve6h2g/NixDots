{
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
      rounded_corners = true;
    };
  };

  # IN locale doesn't have utf-8 encoding.
  programs.zsh.shellAliases.btop = "btop --force-utf";
}
