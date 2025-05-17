{ config, ... }:
let
  myTheme = config.colorScheme.palette;
in
{
  programs.wofi = {
    enable = true;

    settings = {
      allow_images = true;
      # width = 30;
      insensitive = true;
      allow_markup = true;
    };

    style =
      # css
      ''
        * {
          font-family: 'ComicShannsMono Nerd Font';
          font-size: 14px;
        }

        /* Window */
        window {
          margin: 0px;
          padding: 10px;
          border: 0.16em solid #${myTheme.base0E};
          border-radius: 0.1em;
          background-color: #${myTheme.base00};
          animation: slideIn 0.5s ease-in-out both;
        }

        /* Slide In */
        @keyframes slideIn {
          0% {
             opacity: 0;
          }

          100% {
             opacity: 1;
          }
        }

        /* Inner Box */
        #inner-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: #${myTheme.base00};
          animation: fadeIn 0.5s ease-in-out both;
        }

        /* Fade In */
        @keyframes fadeIn {
          0% {
             opacity: 0;
          }

          100% {
             opacity: 1;
          }
        }

        /* Outer Box */
        #outer-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: #${myTheme.base00};
        }

        /* Scroll */
        #scroll {
          margin: 0px;
          padding: 10px;
          border: none;
          background-color: #${myTheme.base00};
        }

        /* Input */
        #input {
          margin: 5px 20px;
          padding: 10px;
          border: none;
          border-radius: 0.1em;
          color: #${myTheme.base05};
          background-color: #${myTheme.base00};
          animation: fadeIn 0.5s ease-in-out both;
        }

        #input image {
            border: none;
            color: #${myTheme.base08};
        }

        #input * {
          outline: 4px solid #${myTheme.base08};
        }

        /* Text */
        #text {
          margin: 5px;
          border: none;
          color: #${myTheme.base05};
          animation: fadeIn 0.5s ease-in-out both;
        }

        #entry {
          background-color: #${myTheme.base00};
        }

        #entry arrow {
          border: none;
          color: #${myTheme.base0A};
        }

        /* Selected Entry */
        #entry:selected {
          border: 0.11em solid #${myTheme.base0D};
        }

        #entry:selected #text {
          color: #${myTheme.base0E};
        }

        #entry:drop(active) {
          background-color: #${myTheme.base0A};
        }
      '';
  };
}
