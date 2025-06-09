{ config, ... }:
let
  theme = config.colorScheme.palette;
in
{
  programs.qutebrowser.settings = {

    completion = {
      fg = "#${theme.base05}";
      odd.bg = "#${theme.base01}";
      even.bg = "#${theme.base00}";
      category = {
        fg = "#${theme.base0A}";
        bg = "#${theme.base00}";
        border = {
          top = "#${theme.base00}";
          bottom = "#${theme.base00}";
        };
      };
      item = {
        selected = {
          fg = "#${theme.base05}";
          bg = "#${theme.base02}";
          border = {
            top = "#${theme.base02}";
            bottom = "#${theme.base02}";
          };
          match.fg = "#${theme.base0B}";
        };
      };
      match.fg = "#${theme.base0B}";
      scrollbar = {
        fg = "#${theme.base05}";
        bg = "#${theme.base00}";
      };
    };
    contextmenu = {
      disabled = {
        bg = "#${theme.base01}";
        fg = "#${theme.base04}";
      };
      menu = {
        bg = "#${theme.base00}";
        fg = "#${theme.base05}";
      };
      selected = {
        bg = "#${theme.base02}";
        fg = "#${theme.base05}";
      };
    };

    downloads = {
      bar.bg = "#${theme.base00}";
      start = {
        fg = "#${theme.base00}";
        bg = "#${theme.base0D}";
      };

      stop = {
        fg = "#${theme.base00}";
        bg = "#${theme.base0C}";
      };
      error.fg = "#${theme.base08}";
    };

    hints = {
      fg = "#${theme.base00}";
      bg = "#${theme.base0A}";

      match = {
        fg = "#${theme.base05}";
      };
    };
    keyhint = {
      fg = "#${theme.base05}";
      bg = "#${theme.base00}";
      suffix.fg = "#${theme.base05}";
    };
    messages = {
      error = {
        fg = "#${theme.base00}";
        bg = "#${theme.base08}";
        border = "#${theme.base08}";
      };
      warning = {
        fg = "#${theme.base00}";
        bg = "#${theme.base0E}";
        border = "#${theme.base0E}";
      };
      info = {
        fg = "#${theme.base05}";
        bg = "#${theme.base00}";
        border = "#${theme.base00}";
      };
    };

    prompts = {
      fg = "#${theme.base05}";
      bg = "#${theme.base00}";
      border = "#${theme.base00}";
      selected = {
        bg = "#${theme.base02}";
        fg = "#${theme.base05}";
      };
    };

    statusbar = {
      normal = {
        fg = "#${theme.base0B}";
        bg = "#${theme.base00}";
      };
      insert = {
        fg = "#${theme.base00}";
        bg = "#${theme.base0D}";
      };
      passthrough = {
        fg = "#${theme.base00}";
        bg = "#${theme.base0C}";
      };

      private = {
        fg = "#${theme.base00}";
        bg = "#${theme.base05}";
      };
      command = {
        fg = "#${theme.base05}";
        bg = "#${theme.base00}";
        private = {
          fg = "#${theme.base05}";
          bg = "#${theme.base00}";
        };
      };
      caret = {
        fg = "#${theme.base00}";
        bg = "#${theme.base0E}";
        selection = {
          fg = "#${theme.base00}";
          bg = "#${theme.base0D}";
        };
      };

      progress = {
        bg = "#${theme.base0D}";
      };

      url = {
        fg = "#${theme.base05}";
        error.fg = "#${theme.base08}";
        hover.fg = "#${theme.base05}";
        success = {
          http.fg = "#${theme.base0C}";
          https.fg = "#${theme.base0B}";
        };
        warn.fg = "#${theme.base0E}";
      };
    };

    tabs = {
      bar.bg = "#${theme.base00}";
      indicator = {
        start = "#${theme.base0D}";
        stop = "#${theme.base0C}";
        error = "#${theme.base08}";
      };
      odd = {
        fg = "#${theme.base05}";
        bg = "#${theme.base01}";
      };
      even = {
        fg = "#${theme.base05}";
        bg = "#${theme.base00}";
      };

      pinned = {
        even = {
          bg = "#${theme.base0C}";
          fg = "#${theme.base07}";
        };
        odd = {
          bg = "#${theme.base0B}";
          fg = "#${theme.base07}";
        };
        selected = {
          even = {
            bg = "#${theme.base02}";
            fg = "#${theme.base05}";
          };
          odd = {
            bg = "#${theme.base02}";
            fg = "#${theme.base05}";
          };
        };
      };
      selected = {
        odd = {
          fg = "#${theme.base05}";
          bg = "#${theme.base02}";
        };
        even = {
          fg = "#${theme.base05}";
          bg = "#${theme.base02}";
        };
      };
    };
  };
}
