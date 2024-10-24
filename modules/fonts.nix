{ pkgs, ... }:

{
  # fonts
  fonts = {
	  packages = with pkgs; [
		  # Normal Fonts
		  noto-fonts
		  noto-fonts-emoji
      noto-fonts-cjk-sans

		  # nerdfonts
		  (nerdfonts.override {fonts = [ "Iosevka" "FantasqueSansMono" ]; })
	  ];

    # To disable the system from using default packages
	  enableDefaultPackages = false;

    # Settings default user fonts
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "FantasqueSansM" ];
        monospace = [ "FantasqueSansM" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
