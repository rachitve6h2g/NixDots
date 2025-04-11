{
  programs = {
    qutebrowser = {
      enable = true;

      # TODO: Add stuff here
      quickmarks = {
        # Options for NixOS
        home-manager = "https://nix-community.github.io/home-manager/options.xhtml";
        nixconfig = "https://nixos.org/manual/nixos/stable/options.html";

        # For Other stuff
        youtube = "https://www.youtube.com/";
        moviesmod = "https://moviesmod.gift/";
        reddit = "https://www.reddit.com/";
        letstype = "https://monkeytype.com/";
        letstype2 = "https://www.keybr.com/";
        whatsapp = "https://web.whatsapp.com/";
        nvf = "https://notashelf.github.io/nvf/options.xhtml";
      };

      # Searchengines
      searchEngines = {
        chatgpt = "https://chat.openai.com/?q={}";
        wa = "https://wiki.archlinux.org/?search={}";
        yt = "https://www.youtube.com/results?search_query={}";
        mynixos = "https://mynixos.com/search?q={}";
      };
    };
  };
}
