{ pkgs, ... }:
{
  programs.swaylock = {
  	enable = true;
	package = pkgs.swaylock-effects;

	settings = {
	    clock = true;
	    # color = "${theme.base00}";
	    # bs-hl-color = "${theme.base06}";
	    # caps-lock-bs-hl-color = "${theme.base06}";
	    # caps-lock-key-hl-color = "${theme.base0B}";
	    # layout-text-color = "${theme.base05}";
	    # ring-color = "${theme.base07}";
	    # ring-clear-color = "${theme.base06}";
	    # ring-caps-lock-color = "${theme.base09}";
	    # ring-ver-color = "${theme.base0D}";
	    # ring-wrong-color = "${theme.base08}";
	    # text-color = "${theme.base05}";
	    # text-clear-color = "${theme.base06}";
	    # text-caps-lock-color = "${theme.base06}";
	    # text-ver-color = "${theme.base0D}";
	    # text-wrong-color = "${theme.base08}";

	    image = "~/.dotfiles/wallpapers/rosepine-samurai.png";
	};
  };
}
