{
  programs.nixvim = let
    highlight = [
      "RainbowRed"
      "RainbowYellow"
      "RainbowBlue"
      "RainbowOrange"
      "RainbowGreen"
      "RainbowViolet"
      "RainbowCyan"
    ];
  in {
    # Add indentation guides even on blank lines
    # For configuration see `:help ibl`
    # https://nix-community.github.io/nixvim/plugins/indent-blankline/index.html
    plugins.indent-blankline = {
      enable = true;

      settings = {
        indent = {
          highlight = highlight;

          char = "";
        };

        # whitespace = {
        #   highlight = highlight;
        #   remove_blankline_trail = false;
        # };

        scope = {
          enabled = true;
          highlight = highlight;
        };
      };
    };
  };
}
