{
  programs = {
    beets = {
      enable = true;
      mpdIntegration = {
        enableStats = true;
        enableUpdate = true;
      };

      settings = {
        directory = "~/Music";
        library = "~/.config/beets/library.db";
        import = { 
          move = "yes"; 
          copy = "no";
        };
      };
    };
  };
}
