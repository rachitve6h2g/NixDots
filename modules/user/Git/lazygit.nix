{ lib, ... }: {
  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
        };

        git = {
          paging = {
            colorArg = "always";
            pager = lib.concatStringsSep " " [
              "delta"
              "--dark"
              "--paging"
              "--line-numbers"
              "--hyprelinks"
              "--hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\""
            ]; 
          };
        };
      };
    };
  };
}