{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    reloadTime = 60;

    urls = [
      {
        url = "https://github.com/nix-community/home-manager/issues.atom";
        title = "Home Manager Issues";
        tags = [
          "issues"
          "nixos"
        ];
      }

      {
        url = "https://saylesss88.github.io//index.xml";
        title = "SayLess88 NixOS Blog";
        tags = [
          "news"
          "nixos"
        ];
      }
    ];

    extraConfig = ''
      color listnormal         color15 default
      color listnormal_unread  color2  default
      color listfocus_unread   color2  color0
      color listfocus          default color0
      color background         default default
      color article            default default
      color end-of-text-marker color8  default
      color info               color4  color8
      color hint-separator     default color8
      color hint-description   default color8
      color title              color14 color8

      highlight article "^(Feed|Title|Author|Link|Date): .+" color4 default bold
      highlight article "^(Feed|Title|Author|Link|Date):" color14 default bold

      highlight article "\\((link|image|video)\\)" color8 default
      highlight article "https?://[^ ]+" color4 default
      highlight article "\[[0-9]+\]" color6 default bold
    '';
  };
}
