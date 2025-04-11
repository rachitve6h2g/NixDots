{
  programs.wofi = {
    enable = true;

    settings = {
      allow_images = true;
      width = 30;
      insensitive = true;
      allow_markup = true;
    };

    style = # css
      ''
        * {
          font-family: 'IosevkaTerm Nerd Font';
          font-size: 14px;
        }

        /* Window */
        window {
          margin: 0px;
          padding: 10px;
          border: 0.16em solid @mauve;
          border-radius: 0.1em;
          background-color: @base;
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
          background-color: @base;
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
          background-color: @base;
        }

        /* Scroll */
        #scroll {
          margin: 0px;
          padding: 10px;
          border: none;
          background-color: @base;
        }

        /* Input */
        #input {
          margin: 5px 20px;
          padding: 10px;
          border: none;
          border-radius: 0.1em;
          color: @text;
          background-color: @base;
          animation: fadeIn 0.5s ease-in-out both;
        }

        #input image {
            border: none;
            color: @red;
        }

        #input * {
          outline: 4px solid @red!important;
        }

        /* Text */
        #text {
          margin: 5px;
          border: none;
          color: @text;
          animation: fadeIn 0.5s ease-in-out both;
        }

        #entry {
          background-color: @base;
        }

        #entry arrow {
          border: none;
          color: @yellow;
        }

        /* Selected Entry */
        #entry:selected {
          border: 0.11em solid @blue;
        }

        #entry:selected #text {
          color: @mauve;
        }

        #entry:drop(active) {
          background-color: @yellow!important;
        }
      '';
  };
}
