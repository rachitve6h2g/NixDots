{ lib, ... }:
{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;

      settings = lib.mkAfter {
        format = lib.concatStrings [
          "$username"
          "$directory"
          "$git_branch"
          "$git_status"
          "$fill"
          "$c"
          "$time\n"
          "[󱞪](fg:blue) "
        ];

        # palette = "red-green";
        #
        # palettes.red-green = {
        #   base02 = "#${theme.base02}";
        #   red = "#${theme.red}";
        #   orange = "#${theme.base09}";
        #   green = "#${theme.green}";
        #   yellow = "#${theme.yellow}";
        #   cyan = "#${theme.cyan}";
        #   blue = "#${theme.blue}";
        # };

        directory = {
          format = "[](fg:base02)[ $path ]($style)[](fg:base02) ";
          style = "bg:base02 fg:green";
          truncation_length = 3;
          truncation_symbol = "…/";

          substitutions = {
            Documents = "󰈙";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };

        fill = {
          style = "fg:base02";
          symbol = " ";
        };
        git_branch = {
          format = "[](fg:base02)[ $symbol $branch ]($style)[](fg:base02) ";
          style = "bg:base02 fg:cyan";
          symbol = "";
        };

        git_status = {
          disabled = false;
          style = "bg:base02 fg:red";
          format = "[](fg:base02)([$all_status$ahead_behind]($style))[](fg:base02) ";
          up_to_date = "[ ✓ ](bg:base02 fg:blue)";
          untracked = "[?\($count\)](bg:base02 fg:orange)";
          stashed = "[\$](bg:base02 fg:blue)";
          modified = "[!\($count\)](bg:base02 fg:orange)";
          renamed = "[»\($count\)](bg:base02 fg:blue)";
          deleted = "[✘\($count\)](style)";
          staged = "[++\($count\)](bg:base02 fg:orange)";
          ahead = "[⇡\(\${count}\)](bg:base02 fg:cyan)";
          diverged = "⇕[\[](bg:base02 fg:blue)[⇡\(\${ahead_count}\)](bg:base02 fg:cyan)[⇣\(\${behind_count}\)](bg:base02 fg:yellow)[\]](bg:base02 fg:blue)";
          behind = "[⇣\(\${count}\)](bg:base02 fg:yellow)";
        };

        time = {
          disabled = false;
          format = " [](fg:base02)[ $time 󰴈 ]($style)[](fg:base02)";
          style = "bg:base02 fg:yellow";
          time_format = "%I:%M%P";
          use_12hr = true;
        };

        username = {
          disabled = false;
          format = "[](fg:base02)[ 󰧱 $user ]($style)[](fg:base02) ";
          show_always = true;
          style_root = "bg:base02 fg:blue";
          style_user = "bg:base02 fg:blue";
        };
        # Languages;

        c = {
          style = "bg:base02 fg:green";
          format = " [](fg:base02)[ $symbol$version ]($style)[](fg:base02)";
          disabled = false;
          symbol = " ";
        };
      };
    };
  };
}
