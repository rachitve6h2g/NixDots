{ config, lib, ... }:
let
  theme = config.colorScheme.palette;
in
{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        format = lib.concatStrings [
          "$username"
          "$directory"
          "$git_branch"
          "$git_status"
          "$fill"
          "$c"
          "$time\n"
          "[󱞪](fg:iris) "
        ];

        palette = "rose-pine";

        palettes.rose-pine = {
          overlay = "#${theme.base02}";
          love = "#${theme.base08}";
          gold = "#${theme.base09}";
          pine = "#${theme.base0B}";
          rose = "#${theme.base0A}";
          foam = "#${theme.base0C}";
          iris = "#${theme.base0D}";
        };

        directory = {
          format = "[](fg:overlay)[ $path ]($style)[](fg:overlay) ";
          style = "bg:overlay fg:pine";
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
          style = "fg:overlay";
          symbol = " ";
        };
        git_branch = {
          format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay) ";
          style = "bg:overlay fg:foam";
          symbol = "";
        };

        git_status = {
          disabled = false;
          style = "bg:overlay fg:love";
          format = "[](fg:overlay)([$all_status$ahead_behind]($style))[](fg:overlay) ";
          up_to_date = "[ ✓ ](bg:overlay fg:iris)";
          untracked = "[?\($count\)](bg:overlay fg:gold)";
          stashed = "[\$](bg:overlay fg:iris)";
          modified = "[!\($count\)](bg:overlay fg:gold)";
          renamed = "[»\($count\)](bg:overlay fg:iris)";
          deleted = "[✘\($count\)](style)";
          staged = "[++\($count\)](bg:overlay fg:gold)";
          ahead = "[⇡\(\${count}\)](bg:overlay fg:foam)";
          diverged = "⇕[\[](bg:overlay fg:iris)[⇡\(\${ahead_count}\)](bg:overlay fg:foam)[⇣\(\${behind_count}\)](bg:overlay fg:rose)[\]](bg:overlay fg:iris)";
          behind = "[⇣\(\${count}\)](bg:overlay fg:rose)";
        };

        time = {
          disabled = false;
          format = " [](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
          style = "bg:overlay fg:rose";
          time_format = "%I:%M%P";
          use_12hr = true;
        };

        username = {
          disabled = false;
          format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay) ";
          show_always = true;
          style_root = "bg:overlay fg:iris";
          style_user = "bg:overlay fg:iris";
        };
        # Languages;

        c = {
          style = "bg:overlay fg:pine";
          format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
          disabled = false;
          symbol = " ";
        };
      };
    };
  };
}
